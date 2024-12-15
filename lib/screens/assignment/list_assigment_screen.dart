import 'package:app_qldt_hust/core/blocs/assignment/cubit/assignment_cubit.dart';
import 'package:app_qldt_hust/core/commons/widgets/toast_custom.dart';
import 'package:app_qldt_hust/core/helpers/logger.dart';
import 'package:app_qldt_hust/core/models/assignment/info_assignment.dart';
import 'package:app_qldt_hust/core/theme/app_dimens.dart';
import 'package:app_qldt_hust/core/theme/colors.dart';
import 'package:app_qldt_hust/core/theme/text_style.dart';
import 'package:app_qldt_hust/screens/assignment/create_assignment_screen.dart';
import 'package:app_qldt_hust/screens/assignment/edit_assignment_screen.dart';
import 'package:app_qldt_hust/screens/assignment/submit_assigment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sp_util/sp_util.dart';
import 'package:url_launcher/url_launcher.dart';

class ListAssignmentScreen extends StatefulWidget {
  final String class_id;
  final String class_name;
  const ListAssignmentScreen(
      {super.key, required this.class_id, required this.class_name});

  @override
  State<ListAssignmentScreen> createState() => _ListAssignmentScreenState();
  static String get routerConfig => '/list_assignment';
}

class _ListAssignmentScreenState extends State<ListAssignmentScreen> {
  final AssignmentCubit assignmentCubit = AssignmentCubit();

  @override
  void initState() {
    assignmentCubit.getListAssignment(widget.class_id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(158, 13, 8, 1),
      appBar: AppBar(
        backgroundColor: AppColors.redDelete,
        centerTitle: true,
        title: InkWell(
          child: Text(
            "Bài tập lớp học ${widget.class_name}",
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
                CreateAssignmentScreen.routerConfig,
                extra: widget.class_id,
              );
              assignmentCubit.getListAssignment(widget.class_id);
            },
          )
        ],
      ),
      body: BlocProvider<AssignmentCubit>.value(
        value: assignmentCubit,
        child: BlocBuilder<AssignmentCubit, AssignmentState>(
          bloc: assignmentCubit,
          builder: (context, state) {
            logger.log("STATE ${state}");
            if (state is AssignmentGetLoaded) {
              return RefreshIndicator(
                onRefresh: () async {},
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
                  itemCount: assignmentCubit.assignmentList.length,
                  itemBuilder: (context, index) => infoAssignment(
                      context, assignmentCubit.assignmentList[index]),
                ),
              );
            }
            if (state is AssignmentGetLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.white,
                ),
              );
            }
            return Text("Đã có lỗi xảy ra");
          },
        ),
      ),
    );
  }

  Widget infoAssignment(BuildContext context, InfoAssignment infoAssignment) {
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
                      'Tên bài tập: ${infoAssignment.title}',
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
                      'Mô tả: ${infoAssignment.description}',
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
                      'Hạn nộp: ${infoAssignment.deadline}',
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
                                Uri.parse('${infoAssignment.file_url}');
                            if (!await launchUrl(url)) {
                              showToastErr(message: "Không thể mở link");
                            }
                          },
                          child: Text('Link tài liệu'),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            Clipboard.setData(
                                ClipboardData(text: infoAssignment.file_url));
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
              SpUtil.getString("role") == "LECTURER"
                  ? GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: const EdgeInsets.all(20),
                                child: Container(
                                  height: 80,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          await context.push(
                                            EditAssignmentScreen.routerConfig,
                                            extra: infoAssignment,
                                          );
                                          assignmentCubit.getListAssignment(
                                              widget.class_id);
                                        },
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
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
                                        onTap: () async {},
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
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
                    )
                  : Column(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            context.push(
                              SubmitAssignmentScreen.routerConfig,
                              extra: infoAssignment.id.toString(),
                            );
                          },
                          child: Text('Nộp bài'),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled:
                                  true, // Cho phép scroll nếu nội dung dài
                              builder: (context) {
                                return FutureBuilder<Map<String, dynamic>>(
                                  future: assignmentCubit.getsubmitAssignment(
                                      infoAssignment.id.toString()),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Center(
                                          child: Text(
                                            "Lỗi: ${snapshot.error}",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      );
                                    } else if (snapshot.hasData) {
                                      final result = snapshot.data!;
                                      if (result["success"] == true) {
                                        final data = result["data"];
                                        return Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.5,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                    height: AppDimens.space5),
                                                Text(
                                                  'Thông tin nộp bài',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  overflow: TextOverflow.clip,
                                                ),
                                                const SizedBox(
                                                    height: AppDimens.space5),
                                                Text(
                                                  'Thời gian đã nộp: ${data["data"]["submission_time"]}',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  overflow: TextOverflow.clip,
                                                ),
                                                const SizedBox(
                                                    height: AppDimens.space5),
                                                Text(
                                                  'Sinh viên: ${data["data"]["student_account"]["last_name"]} ${data["data"]["student_account"]["first_name"]}',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  overflow: TextOverflow.clip,
                                                ),
                                                const SizedBox(
                                                    height: AppDimens.space5),
                                                Text(
                                                  'Email:  ${data["data"]["student_account"]["email"]}',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  overflow: TextOverflow.clip,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                    } else {
                                      return SizedBox(
                                        height: 100,
                                        child: Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: Center(
                                            child: Text(
                                              "Bạn chưa nộp bài này ",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ),
                                      );
                                    }

                                    return SizedBox(
                                      height: 100,
                                      child: Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Center(
                                          child: Text(
                                            "Bạn chưa nộp bài này",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                          child: Text('Chi tiết'),
                        ),
                      ],
                    ),
              const Spacer(flex: 8)
            ],
          ),
        ),
      ),
    );
  }
}
