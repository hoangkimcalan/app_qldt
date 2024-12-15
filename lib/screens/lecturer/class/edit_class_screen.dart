import 'package:app_qldt_hust/core/blocs/lecturer/class/cubit/class_cubit.dart';
import 'package:app_qldt_hust/core/commons/widgets/date_picker_custom.dart';
import 'package:app_qldt_hust/core/commons/widgets/toast_custom.dart';
import 'package:app_qldt_hust/core/commons/widgets/widget_custom.dart';
import 'package:app_qldt_hust/core/helpers/logger.dart';
import 'package:app_qldt_hust/core/models/lecturer/class/info_class.dart';
import 'package:app_qldt_hust/core/theme/colors.dart';
import 'package:app_qldt_hust/core/theme/text_style.dart';
import 'package:app_qldt_hust/screens/auth/widgets/textformfield_auth.dart';
import 'package:app_qldt_hust/screens/lecturer/widgets/textformfield_lecture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class EditClassScreen extends StatefulWidget {
  final InfoClass infoClass;
  const EditClassScreen({super.key, required this.infoClass});

  @override
  State<EditClassScreen> createState() => _EditClassScreenState();
  static String get routerConfig => '/edit_class';
}

class _EditClassScreenState extends State<EditClassScreen> {
  final TextEditingController _classIdController = TextEditingController();
  final TextEditingController _classNameController = TextEditingController();
  final TextEditingController _classStatusController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  FocusNode _focusNode = FocusNode();

  late ClassCubit _classCubit = ClassCubit();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
    _classIdController.text = widget.infoClass.class_id;
    _classNameController.text = widget.infoClass.class_name;
    _classStatusController.text = widget.infoClass.status;
    _startDateController.text = widget.infoClass.start_date;
    _endDateController.text = widget.infoClass.end_date;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _classIdController.dispose();
    _classNameController.dispose();
    _classStatusController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  Future<void> _selectDateStart(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        // Định dạng ngày thành yyyy/MM/dd
        final formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
        _startDateController.text = formattedDate;
      });
    }
  }

  Future<void> _selectDateEnd(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final startDate =
          DateFormat('yyyy-MM-dd').parse(_startDateController.text);

      if (pickedDate.isAfter(startDate)) {
        setState(() {
          final formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          _endDateController.text = formattedDate;
        });
      } else {
        showToastErr(message: "Ngày kết thúc phải lớn hơn ngày bắt đầu");
      }
    }
  }

  Future<void> onSubmit() async {
    _classCubit.editClass(
      class_id: _classIdController.text,
      class_name: _classNameController.text,
      status: _classStatusController.text,
      start_date: _startDateController.text,
      end_date: _endDateController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.redDelete,
      appBar: AppBar(
        backgroundColor: AppColors.redDelete,
        centerTitle: true,
        title: InkWell(
          child: Text("Chỉnh sửa lớp ${widget.infoClass.class_name}",
              style: TextStyles.text18w6white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocListener(
            listener: (context, state) {
              logger.log("STATE ${state}", name: "Editclass");
              if (state is EditClassLoading) {
                CustomLoading(context);
              } else if (state is EditClassLoaded) {
                Navigator.pop(context);
                showToastSuccess(message: "Chỉnh sửa thành công");
                Navigator.pop(context);
                Navigator.pop(context);
              }
            },
            bloc: _classCubit,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    enabled: false,
                    style: TextStyle(color: Colors.white),
                    controller: _classIdController,
                    decoration: InputDecorationLecture("Mã lớp học"),
                  ),
                  SizedBox(height: 24),
                  TextFormField(
                    focusNode: _focusNode,
                    style: TextStyle(color: Colors.white),
                    controller: _classNameController,
                    decoration: InputDecorationLecture("Tên lớp"),
                  ),
                  SizedBox(height: 24),
                  DropdownButtonFormField<String>(
                    style: TextStyle(color: Colors.white),
                    dropdownColor: AppColors.redDelete,
                    value: _classStatusController.text.isNotEmpty
                        ? _classStatusController.text
                        : null, // Hiển thị giá trị hiện tại hoặc null nếu chưa chọn
                    decoration: InputDecorationLecture("Trạng thái lớp"),
                    items: ['ACTIVE', 'COMPLETED', 'UPCOMING']
                        .map((type) => DropdownMenuItem<String>(
                              value: type,
                              child: Text(
                                type,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20.0),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _classStatusController.text = value;
                        });
                      }
                    },
                  ),
                  SizedBox(height: 24),
                  CommonDatePickerField(
                    labelText: 'Ngày bắt đầu',
                    controller: _startDateController,
                    onTap: () {
                      _selectDateStart(context); // Gọi hàm chọn ngày
                    },
                  ),
                  SizedBox(height: 24),
                  CommonDatePickerField(
                    labelText: 'Ngày kết thúc',
                    controller: _endDateController,
                    onTap: () {
                      _selectDateEnd(context); // Gọi hàm chọn ngày
                    },
                  ),
                  SizedBox(height: 24),
                  buttonColors(context, "Chỉnh sửa", 28, () async {
                    onSubmit();
                  })
                ]),
          ),
        ),
      ),
    );
  }
}
