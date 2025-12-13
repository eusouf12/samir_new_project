import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  // Login tab
  var isLoginSelected = true.obs;

  void toggleTab(bool isLogin) => isLoginSelected.value = isLogin;

  // Register tab specific
  var uploadedFile = Rxn<PlatformFile>();
  var isPasswordHidden = true.obs;

  void setUploadedFile(PlatformFile file) => uploadedFile.value = file;
  void togglePasswordVisibility() => isPasswordHidden.value = !isPasswordHidden.value;
}