class ApiPath {
  //base url
  static const String url = 'http://157.66.24.126:8080/';
  //dang ky
  static const String apiRegister = '${url}it4788/signup';
  //get verify code
  static const String apiGetverifycode = '${url}it4788/get_verify_code';
  //check verify code
  static const String apiCheckverifycode = '${url}it4788/check_verify_code';
  //dang nhap
  static const String apiLogin = '${url}it4788/login';
  //get user info
  static const String apiGetUserInfo = '${url}it4788/get_user_info';

  //get user info
  static const String apiChangeInfoAfterSignup =
      '${url}it4788/change_info_after_signup';

  //IT5023E

  //LECTURER
  // class/create_class
  static const String createClass = '${url}it5023e/create_class';
  //class/get_class_list
  static const String getClassList = '${url}it5023e/get_class_list';
  //class/get_class_info
  static const String getClassInfo = '${url}it5023e/get_class_info';
  //class/edit_class
  static const String editClass = '${url}it5023e/edit_class';
  //class/delete_class
  static const String deleteClass = '${url}it5023e/delete_class';

  //STUDENT
  //class/get_basic_info
  static const String getBasicClassInfo = '${url}it5023e/get_basic_class_info';

  //class/register_class
  static const String registerClass = '${url}it5023e/register_class';

  //class/delete_class
  static const String deleteClassStudent = '${url}it5023e/delete_class';

  //COMMON
  //material
  //get material
  static const String getMaterialList = '${url}it5023e/get_material_list';

  //upload material
  static const String uploadMaterial = '${url}it5023e/upload_material';

  //edit material
  static const String editMaterial = '${url}it5023e/edit_material';

  //delete material
  static const String deleteMaterial = '${url}it5023e/delete_material';

  //Assignment
  //list assignments
  static const String getAllSurveys = '${url}it5023e/get_all_surveys';

  //create assignment
  static const String createSurveys = '${url}it5023e/create_survey';

  //edit assignment
  static const String editSurveys = '${url}it5023e/edit_survey';

  //submit assignment
  static const String submitSurveys = '${url}it5023e/submit_survey';

  //get submit
  static const String getsubmitSurveys = '${url}it5023e/get_submission';

  //atttendance
  static const String takeAttendance = '${url}it5023e/take_attendance';
}
