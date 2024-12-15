import 'package:app_qldt_hust/core/blocs/lecturer/class/cubit/class_cubit.dart';
import 'package:app_qldt_hust/core/commons/widgets/date_picker_custom.dart';
import 'package:app_qldt_hust/core/commons/widgets/toast_custom.dart';
import 'package:app_qldt_hust/core/commons/widgets/widget_custom.dart';
import 'package:app_qldt_hust/core/theme/colors.dart';
import 'package:app_qldt_hust/core/theme/text_style.dart';
import 'package:app_qldt_hust/screens/auth/widgets/textformfield_auth.dart';
import 'package:app_qldt_hust/screens/lecturer/widgets/textformfield_lecture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CreateClassScreen extends StatefulWidget {
  const CreateClassScreen({super.key});

  @override
  State<CreateClassScreen> createState() => _CreateClassScreenState();
  static String get routerConfig => '/create_class';
}

class _CreateClassScreenState extends State<CreateClassScreen> {
  final TextEditingController _classIdController = TextEditingController();
  final TextEditingController _classNameController = TextEditingController();
  final TextEditingController _classTypeController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _maxStudentController = TextEditingController();

  FocusNode _focusNode = FocusNode();

  late ClassCubit _classCubit = ClassCubit();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _classIdController.dispose();
    _classNameController.dispose();
    _classTypeController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _maxStudentController.dispose();
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
    _classCubit.createClass(
        class_id: _classIdController.text,
        class_name: _classNameController.text,
        class_type: _classTypeController.text,
        start_date: _startDateController.text,
        end_date: _endDateController.text,
        max_student: int.tryParse(_maxStudentController.text) ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.redDelete,
      appBar: AppBar(
        backgroundColor: AppColors.redDelete,
        centerTitle: true,
        title: InkWell(
          child: Text("Tạo lớp mới", style: TextStyles.text18w6white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocListener(
            listener: (context, state) {
              if (state is ClassCreateLoading) {
                CustomLoading(context);
              } else if (state is ClassCreateLoaded) {
                showToastSuccess(message: "Thêm mới thành công");
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
                    style: TextStyle(color: Colors.white),
                    controller: _classIdController,
                    decoration: InputDecorationLecture("Mã lớp học"),
                  ),
                  SizedBox(height: 24),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: _classNameController,
                    decoration: InputDecorationLecture("Tên lớp"),
                  ),
                  SizedBox(height: 24),
                  DropdownButtonFormField<String>(
                    style: TextStyle(color: Colors.white),
                    dropdownColor: AppColors.redDelete,
                    value: _classTypeController.text.isNotEmpty
                        ? _classTypeController.text
                        : null, // Hiển thị giá trị hiện tại hoặc null nếu chưa chọn
                    decoration: InputDecorationLecture("Loại lớp"),
                    items: ['LT', 'BT', 'LT_BT']
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
                          _classTypeController.text =
                              value; // Cập nhật controller
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
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecorationLecture("Số sinh viên"),
                    controller: _maxStudentController,
                    keyboardType: TextInputType.number, // Hiển thị bàn phím số
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        final enteredValue = int.tryParse(value) ?? 0;
                        if (enteredValue > 50) {
                          _maxStudentController.text = '50'; // Chuyển về 300
                          _maxStudentController.selection =
                              TextSelection.fromPosition(
                            TextPosition(
                                offset: _maxStudentController
                                    .text.length), // Đặt con trỏ ở cuối
                          );
                        }
                      }
                    },
                  ),
                  SizedBox(height: 24),
                  buttonColors(context, "Tạo lớp mới", 28, () async {
                    onSubmit();
                  }),
                ]),
          ),
        ),
      ),
    );
  }
}
