import 'package:app_qldt_hust/core/models/auth/info_user.dart';
import 'package:app_qldt_hust/core/models/lecturer/class/info_class.dart';
import 'package:app_qldt_hust/core/models/material/info_material.dart';
import 'package:app_qldt_hust/screens/assignment/create_assignment_screen.dart';
import 'package:app_qldt_hust/screens/assignment/list_assigment_screen.dart';
import 'package:app_qldt_hust/screens/assignment/submit_assigment_screen.dart';
import 'package:app_qldt_hust/screens/attendance/take_attendance_screen.dart';
import 'package:app_qldt_hust/screens/auth/login_screen.dart';
import 'package:app_qldt_hust/screens/auth/register_screen.dart';
import 'package:app_qldt_hust/screens/auth/user_info_screen.dart';
import 'package:app_qldt_hust/screens/lecturer/class/create_class_screen.dart';
import 'package:app_qldt_hust/screens/lecturer/class/edit_class_screen.dart';
import 'package:app_qldt_hust/screens/lecturer/class/info_class_screen.dart';
import 'package:app_qldt_hust/screens/lecturer/class/list_class_screen.dart';
import 'package:app_qldt_hust/screens/main/main_lecturer_screen.dart';
import 'package:app_qldt_hust/screens/main/main_student_screen.dart';
import 'package:app_qldt_hust/screens/material/edit_material_screen.dart';
import 'package:app_qldt_hust/screens/material/list_material_screen.dart';
import 'package:app_qldt_hust/screens/material/upload_material_screen.dart';
import 'package:app_qldt_hust/screens/student/class/info_class_student_screen.dart';
import 'package:app_qldt_hust/screens/student/class/list_class_student_screen.dart';
import 'package:app_qldt_hust/screens/student/class/register_class_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sp_util/sp_util.dart';

final router = GoRouter(
  initialLocation: RegisterScreen.routerConfig,
  redirect: (BuildContext context, GoRouterState state) async {
    String? token = SpUtil.getString('token');
    String? role = SpUtil.getString('role');

    // Nếu đã có token và role
    if (token != null && token.isNotEmpty) {
      if (state.fullPath == RegisterScreen.routerConfig) {
        // Chuyển hướng lần đầu dựa trên role
        if (role == "LECTURER") {
          return MainLecturerScreen.routerConfig;
        } else {
          return MainStudentScreen.routerConfig;
        }
      }
    }

    // Nếu không cần chuyển hướng
    return null;
  },
  routes: <RouteBase>[
    //dang ky
    GoRoute(
      path: RegisterScreen.routerConfig,
      builder: (context, state) => const RegisterScreen(),
    ),

    //dang nhap
    GoRoute(
      path: LoginScreen.routerConfig,
      builder: (context, state) => const LoginScreen(),
    ),
    //dang nhap
    GoRoute(
      path: UserInfoScreen.routerConfig,
      builder: (context, state) {
        InfoUser infoUser = state.extra as InfoUser;

        return UserInfoScreen(infoUser: infoUser);
      },
    ),
    //
    //MAIN LECTURER
    //
    GoRoute(
      path: MainLecturerScreen.routerConfig,
      builder: (context, state) => const MainLecturerScreen(),
    ),
    //create class
    GoRoute(
      path: CreateClassScreen.routerConfig,
      builder: (context, state) => const CreateClassScreen(),
    ),
    //class list
    GoRoute(
      path: ListClassScreen.routerConfig,
      builder: (context, state) => const ListClassScreen(),
    ),
    //class info
    GoRoute(
      path: InfoClassScreen.routerConfig,
      builder: (context, state) {
        InfoClass infoClass = state.extra as InfoClass;
        return InfoClassScreen(
          infoClass: infoClass,
        );
      },
    ),
    //edit class
    GoRoute(
      path: EditClassScreen.routerConfig,
      builder: (context, state) {
        InfoClass infoClass = state.extra as InfoClass;
        return EditClassScreen(
          infoClass: infoClass,
        );
      },
    ),

    //class list
    GoRoute(
      path: ListClassStudentScreen.routerConfig,
      builder: (context, state) => const ListClassStudentScreen(),
    ),
    //class info
    GoRoute(
      path: InfoClassStudentScreen.routerConfig,
      builder: (context, state) {
        InfoClass infoClass = state.extra as InfoClass;
        return InfoClassStudentScreen(
          infoClass: infoClass,
        );
      },
    ),
    //
    //MAIN STUDENT
    //
    GoRoute(
      path: MainStudentScreen.routerConfig,
      builder: (context, state) => const MainStudentScreen(),
    ),

    //register class
    GoRoute(
      path: RegisterClassScreen.routerConfig,
      builder: (context, state) => const RegisterClassScreen(),
    ),

    ///submit class
    GoRoute(
      path: SubmitAssignmentScreen.routerConfig,
      builder: (context, state) {
        String assignmentId = state.extra as String;
        return SubmitAssignmentScreen(assignmentId: assignmentId);
      },
    ),

    ///List material
    GoRoute(
      path: ListMaterialScreen.routerConfig,
      builder: (context, state) {
        final extra = state.extra as Map<String, String>;
        return ListMaterialScreen(
          class_id: extra['class_id']!,
          class_name: extra['class_name']!,
        );
      },
    ),

    ///upload material
    GoRoute(
      path: UploadMaterialScreen.routerConfig,
      builder: (context, state) {
        String class_id = state.extra as String;
        return UploadMaterialScreen(class_id: class_id);
      },
    ),

    ///edit material
    GoRoute(
      path: EditMaterialScreen.routerConfig,
      builder: (context, state) {
        InfoMaterial infoMaterial = state.extra as InfoMaterial;
        return EditMaterialScreen(infoMaterial: infoMaterial);
      },
    ),

    //List assignment
    GoRoute(
      path: ListAssignmentScreen.routerConfig,
      builder: (context, state) {
        final extra = state.extra as Map<String, String>;
        return ListAssignmentScreen(
          class_id: extra['class_id']!,
          class_name: extra['class_name']!,
        );
      },
    ),

    ///create assignment
    GoRoute(
      path: CreateAssignmentScreen.routerConfig,
      builder: (context, state) {
        String class_id = state.extra as String;
        return CreateAssignmentScreen(class_id: class_id);
      },
    ),

    ///take attendance
    GoRoute(
      path: TakeAttendanceScreen.routerConfig,
      builder: (context, state) {
        String class_id = state.extra as String;
        return TakeAttendanceScreen(class_id: class_id);
      },
    ),
  ],
);

class AppRouter {
  static backToPage(
          {required BuildContext context, required String routerConfig}) =>
      Navigator.popUntil(
        context,
        ModalRoute.withName(routerConfig),
      );

  static removeAllDialog(BuildContext context) =>
      Navigator.of(context).popUntil(
        (route) => (route is DialogRoute) != true,
      );
}
