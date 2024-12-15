import 'package:app_qldt_hust/core/blocs/material/cubit/material_cubit.dart';
import 'package:app_qldt_hust/core/commons/widgets/toast_custom.dart';
import 'package:app_qldt_hust/core/models/material/info_material.dart';
import 'package:app_qldt_hust/core/theme/app_dimens.dart';
import 'package:app_qldt_hust/core/theme/colors.dart';
import 'package:app_qldt_hust/core/theme/text_style.dart';
import 'package:app_qldt_hust/screens/material/edit_material_screen.dart';
import 'package:app_qldt_hust/screens/material/upload_material_screen.dart';
import 'package:app_qldt_hust/screens/material/widgets/custom_dialog_material.dart';
import 'package:flutter/material.dart' hide MaterialState;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class ListMaterialScreen extends StatefulWidget {
  final String class_id;
  final String class_name;

  const ListMaterialScreen(
      {super.key, required this.class_id, required this.class_name});

  @override
  State<ListMaterialScreen> createState() => _ListMaterialScreenState();
  static String get routerConfig => '/list_material';
}

class _ListMaterialScreenState extends State<ListMaterialScreen> {
  final MaterialCubit materialCubit = MaterialCubit();

  @override
  void initState() {
    materialCubit.getListMaterial(widget.class_id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.redDelete,
        appBar: AppBar(
          backgroundColor: AppColors.redDelete,
          centerTitle: true,
          title: InkWell(
            child: Text(
              "Tài liệu lớp học ${widget.class_name}",
              style: TextStyles.text18w6white,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                size: 28,
                Icons.add,
                color: AppColors.white,
              ),
              onPressed: () async {
                await context.push(
                  UploadMaterialScreen.routerConfig,
                  extra: widget.class_id,
                );
                materialCubit.getListMaterial(widget.class_id);
              },
            )
          ],
        ),
        body: BlocProvider<MaterialCubit>.value(
          value: materialCubit,
          child: BlocBuilder<MaterialCubit, MaterialState>(
            bloc: materialCubit,
            builder: (context, state) {
              if (state is MaterialGetLoaded) {
                return RefreshIndicator(
                  onRefresh: () async {},
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
                    itemCount: materialCubit.materialList.length,
                    itemBuilder: (context, index) => infoMaterial(
                        context, materialCubit.materialList[index]),
                  ),
                );
              }
              if (state is MaterialGetLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.white,
                  ),
                );
              }
              return Text("Đã có lỗi xảy ra");
            },
          ),
        ));
  }

  Widget infoMaterial(BuildContext context, InfoMaterial infoMaterial) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppDimens.space15),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: AppDimens.space15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: AppShadow.shadow),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 8),
              Expanded(
                flex: 290,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tên tài liệu: ${infoMaterial.material_name}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.clip,
                    ),
                    const SizedBox(
                      height: AppDimens.space5,
                    ),
                    Text(
                      'Mô tả: ${infoMaterial.description}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.clip,
                    ),
                    const SizedBox(
                      height: AppDimens.space5,
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            // Kiểm tra nếu URL hợp lệ
                            final Uri url =
                                Uri.parse('${infoMaterial.material_link}');
                            if (!await launchUrl(url)) {
                              showToastErr(message: "Không thể mở link");
                            }
                          },
                          child: Text('Link tài liệu'),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            Clipboard.setData(ClipboardData(
                                text: infoMaterial.material_link));
                            showToastSuccess(message: "Sao chép thành công");
                          },
                          child: Icon(Icons.copy),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: AppDimens.space5,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(20),
                          child: Container(
                            height: 80,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    await context.push(
                                      EditMaterialScreen.routerConfig,
                                      extra: infoMaterial,
                                    );
                                    materialCubit
                                        .getListMaterial(widget.class_id);
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(Icons.edit),
                                      const SizedBox(width: 20),
                                      Text(
                                        'Sửa',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        overflow: TextOverflow.clip,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                InkWell(
                                  onTap: () async {
                                    DeleteWarningDialogMaterial(
                                        context, "Xác nhận xóa tài liệu này",
                                        () async {
                                      await materialCubit
                                          .deleteMaterial(infoMaterial.id);

                                      await materialCubit
                                          .getListMaterial(widget.class_id);
                                    }, materialCubit);
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(Icons.delete),
                                      const SizedBox(width: 20),
                                      Text(
                                        'Xóa',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        overflow: TextOverflow.clip,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                },
                child: const Icon(Icons.more_vert),
              ),
              const Spacer(flex: 8)
            ],
          ),
        ),
      ),
    );
  }
}
