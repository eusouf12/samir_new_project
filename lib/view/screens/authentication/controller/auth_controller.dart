import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../helper/shared_prefe/shared_prefe.dart';
import '../../../../service/api_check.dart';
import '../../../../service/api_client.dart';
import '../../../../service/api_url.dart';
import '../../../../service/socket_service.dart';
import '../../../../utils/ToastMsg/toast_message.dart';
import '../../../../utils/app_const/app_const.dart';
import '../../../../utils/app_strings/app_strings.dart';
import '../../../../utils/local_storage/local_storage.dart';




class AuthController extends GetxController {
  ///========== SignUp Api Controller ==========
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> usernameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> locationController = TextEditingController().obs;
  Rx<TextEditingController> phoneNumberController = TextEditingController().obs;
  Rx<TextEditingController> dateOfBirthController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<TextEditingController> confirmPasswordController = TextEditingController().obs;

  RxString passwordError = "".obs;
  var completePhoneNumber = ''.obs;
  var countryCode = ''.obs;


  /// ---------- STATES ---------- ///
  RxBool isSignupLoading = false.obs;
  RxBool isOtpVerifying = false.obs;
  RxBool isLoginLoading = false.obs;
  RxBool isRegistering = false.obs;

  void validatePasswordLive(String value) {
    String pattern =
        r'^(?=.{6,})(?=.*[^a-zA-Z0-9]).*$';

    if (value.isEmpty) {
      passwordError.value =
      "Your password must have one number, one upper case,One lower case and symbol.";
    } else if (!RegExp(pattern).hasMatch(value)) {
      passwordError.value =
      "Your password must have one number, one upper and lower case and symbol.";
    } else {
      passwordError.value = "";
    }
  }
  bool isEmailValidate(String input) {
    return RegExp(
      r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$",
    ).hasMatch(input);
  }

  ///=============== Date Formate Function ================
  Future<void> pickDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dateOfBirthController.value.text =
          DateFormat('yyyy-MM-dd').format(picked);
    }
  }


  ///========== SignUp Api Loading ==========
  RxBool signUpLoading = false.obs;

  Future<void> signUp() async {
    signUpLoading.value = true;

    final role = StorageService().read<String>("role");
    Map<String, dynamic> body = {
      "name": nameController.value.text.trim(),
      "userName": usernameController.value.text.trim(),
      "email": emailController.value.text.trim().toLowerCase(),
      "password": passwordController.value.text,
      "confirmPassword": confirmPasswordController.value.text,
      "role": role,
    };

    try {
      var response = await ApiClient.postData(ApiUrl.signUp, jsonEncode(body));

      if (response.statusCode == 200 || response.statusCode == 201) {
        signUpLoading.value = false;
        refresh();

        Map<String, dynamic> jsonResponse;

        (response.body is String) ?
        jsonResponse = jsonDecode(response.body) : jsonResponse =
        response.body as Map<String, dynamic>;


        showCustomSnackBar(jsonResponse['message']?.toString() ??
            "Registration successful! Please verify your email.",
            isError: false);

        Get.toNamed(AppRoutes.accountReadyScreen);

        // Clear signup data
        clearSignUpData();
      }
      else {
        signUpLoading.value = false;
        refresh();

        if (response.statusText == ApiClient.somethingWentWrong) {
          showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
        } else {
          Map<String, dynamic> jsonResponse;

          (response.body is String) ?
          jsonResponse = jsonDecode(response.body) : jsonResponse =
          response.body as Map<String, dynamic>;


          showCustomSnackBar(jsonResponse['message']?.toString() ??
              "Registration fail your email.",
              isError: true);

          ApiChecker.checkApi(response);
        }
      }
    } catch (e) {
      signUpLoading.value = false;
      refresh();
      showCustomSnackBar("An error occurred. Please try again.", isError: true);
      debugPrint("SignUp Error: $e");
    }
  }

  //========== Clear SignUp Data ==========
  void clearSignUpData() {
    nameController.value.clear();
    emailController.value.clear();
    phoneNumberController.value.clear();
    dateOfBirthController.value.clear();
    passwordController.value.clear();
    confirmPasswordController.value.clear();
    forgetPasswordController.value.clear();
  }

  //=====================LOGIN METHOD=====================
  RxBool isLoginTab = true.obs;

  void toggleTab(bool isLogin) => isLoginTab.value = isLogin;

  //======================LOGIN CONTROLLER=====================
  Rx<TextEditingController> loginEmailController = TextEditingController().obs;
  Rx<TextEditingController> loginPasswordController = TextEditingController().obs;

  @override
  void onInit() {
    super.onInit();
    //loginEmailController.value.text = "fdafdfda";
     loginEmailController.value.text = "eusouf12" ;
    loginPasswordController.value.text = "123456";
  }

  RxBool loginUserLoading = false.obs;

  Future<void> loginUser() async {
    loginUserLoading.value = true;

    Map<String, String> body = {
      isEmailValidate(loginEmailController.value.text.trim()) ? "email" : "userName": "${loginEmailController.value.text.trim()}",
      "password": loginPasswordController.value.text.trim(),
    };

    try {
      var response = await ApiClient.postData(ApiUrl.signIn, jsonEncode(body));

      if (response.statusCode == 200 || response.statusCode == 201) {
        loginUserLoading.value = false;
        refresh();

        Map<String, dynamic> jsonResponse;

        if (response.body is String) {
          jsonResponse = jsonDecode(response.body);
        } else {
          jsonResponse = response.body as Map<String, dynamic>;
        }

        showCustomSnackBar(jsonResponse['message']?.toString() ?? "Login successful", isError: false,);

        // Access Token
        String accessToken = jsonResponse['accessToken'].toString();
        final sendToken ="Bearer $accessToken" ;
        debugPrint("Bearer Token: $sendToken");
        await SharePrefsHelper.setString(AppConstants.bearerToken, sendToken);

        // Decode token
        Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
        String userId = decodedToken['_id'].toString();
        String userRole = decodedToken['role'].toString();
        debugPrint("userId==========: $userId");

        await SharePrefsHelper.setString(AppConstants.userId, userId);
        String id = await SharePrefsHelper.getString(AppConstants.userId);
        await SharePrefsHelper.setString(AppConstants.role, userRole);
        String resetToken = await SharePrefsHelper.getString("resetToken");
        debugPrint("Reset Token: $resetToken");


        //Socket initialization
        try {
          SocketApi.init(ApiUrl.socketUrl, userId);
          debugPrint("🔁 Reconnected Socket with new user ======================= : $userId");
        } catch (e) {
          debugPrint("⚠️ Socket re-init failed after login: $e");
        }


        userRole.toLowerCase() == "influencer" ? Get.offAllNamed(AppRoutes.infHomeScreen) : Get.offAllNamed(AppRoutes.hostHomeScreen);
      }
      else {
        loginUserLoading.value = false;
        refresh();

        Map<String, dynamic> errorResponse;

        if (response.body is String) {
          errorResponse = jsonDecode(response.body);
        } else {
          errorResponse = response.body as Map<String, dynamic>;
        }
        if (response.statusCode == 400 || response.statusCode == 401) {
          showCustomSnackBar(
            errorResponse['message']?.toString() ?? "Invalid email or password",
            isError: true,
          );
        } else {
          showCustomSnackBar(errorResponse['message']?.toString() ?? "Login failed", isError: true);
        }
      }
    } catch (e) {
      loginUserLoading.value = false;
      refresh();
      showCustomSnackBar("An error occurred. Please try again.", isError: true);
      debugPrint("Login Error: $e");
    }
  }


  ///========== OTP Controller SIGN UP PATCH METHOD==========

  Rx<TextEditingController> otpController = TextEditingController().obs;
  RxBool otpLoading = false.obs;

  /// otp time countdown
  RxInt otpTimer = 30.obs;
  RxBool canResend = false.obs;
  Timer? timer;

  void startOtpTimer() {
    otpTimer.value = 30;
    canResend.value = false;

    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (otpTimer.value > 0) {
        otpTimer.value--;
      } else {
        canResend.value = true;
        timer.cancel();
      }
    });
  }

  //=================== resend otp ===================
  Future<void> resendOtp({required String email}) async {
    try {
      final response = await ApiClient.getData(ApiUrl.recentOtp(email: email));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse =
        response.body is String ? jsonDecode(response.body) : response.body;

        final bool success = jsonResponse['success'] ?? false;
        final String mainMessage = jsonResponse['message'] ?? '';
        final String? internalMessage = jsonResponse['data']?['message'];

        print("Main Message: $mainMessage");
        print("Internal Message: $internalMessage");

        if (internalMessage == "This user is already verified.") {
          print("User already verified!");
        }
        else {
          startOtpTimer();
        }
      }
    } catch (e) {
      print(e);
    }
  }

  ///======================Forget password CONTROLLER=====================

  Rx<TextEditingController> forgetPasswordController = TextEditingController()
      .obs;
  RxBool forgetPasswordLoading = false.obs;

  Future<void> forgetPassword({required String screenName}) async {
    forgetPasswordLoading.value = true;
    refresh();

    Map<String, String> body = {
      "email": forgetPasswordController.value.text,
    };

    try {
      var response = await ApiClient.postData(
          ApiUrl.forgotPassword, jsonEncode(body));

      forgetPasswordLoading.value = false;
      refresh();

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> jsonResponse;

        if (response.body is String) {
          jsonResponse = jsonDecode(response.body);
        }
        else {
          jsonResponse = response.body as Map<String, dynamic>;
        }

        showCustomSnackBar(
          jsonResponse['message']?.toString() ?? "Check your email for OTP",
          isError: false,);
        forgetPasswordController.value.clear();
        Get.toNamed(AppRoutes.otpScreen,
          arguments: SignUpAuthModel(
            forgetPasswordController.value.text, AppStrings.forgetPassword,),
        );
      }
      else {
        if (response.statusText == ApiClient.somethingWentWrong) {
          showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
        } else {
          showCustomSnackBar(
              'Please enter your correct email address!', isError: true);
          ApiChecker.checkApi(response);
        }
      }
    } catch (e) {
      forgetPasswordLoading.value = false;
      refresh();
      showCustomSnackBar("An error occurred. Please try again.", isError: true);
      debugPrint("ForgotPassword Error: $e");
    }
  }

  ///======================update password CONTROLLER=====================

  Rx<TextEditingController> updatePasswordController = TextEditingController().obs;
  Rx<TextEditingController> updateConfirmPasswordController = TextEditingController().obs;
  RxBool updatePasswordLoading = false.obs;

  Future<void> updatePassword() async {
    updatePasswordLoading.value = true;
    refresh();
    String resetToken = await SharePrefsHelper.getString("resetToken");
    // Prepare request body
    Map<String, dynamic> body = {
      "newPassword":updatePasswordController.value.text,
      "confirmPassword": updateConfirmPasswordController.value.text,
    };

    try {
      var response = await ApiClient.postData(
          ApiUrl.newPassword, jsonEncode(body),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $resetToken',
          }
      );

      updatePasswordLoading.value = false;
      refresh();
      Map<String, dynamic> jsonResponse;

      if (response.statusCode == 200 || response.statusCode == 201) {
        response.body is String ? jsonResponse = jsonDecode(response.body) :
        jsonResponse = response.body as Map<String, dynamic>;

        showCustomSnackBar(jsonResponse['message']?.toString() ?? "Password updated successfully!", isError: false,);
        updatePasswordController.value.clear();
        updateConfirmPasswordController.value.clear();
        Get.offAllNamed(AppRoutes.loginScreen);
      }
      else {
        response.body is String ? jsonResponse = jsonDecode(response.body) :
        jsonResponse = response.body as Map<String, dynamic>;
        debugPrint("===================${response.body} 1");
        showCustomSnackBar(jsonResponse['message']?.toString() ?? "Password update failed", isError: true,);
      }
    } catch (e) {
      updatePasswordLoading.value = false;
      refresh();
      showCustomSnackBar("An error occurred. Please try again.", isError: true);
      debugPrint("UpdatePassword Error: $e");
    }
  }

  //========== OTP Controller ForgetPass POST METHOD==========
  RxBool otpForgetLoading = false.obs;
  Future<void> verifyOtpForgetPass() async {
    otpForgetLoading.value = true;
    refresh();

    if (otpController.value.text.isEmpty) {
      otpForgetLoading.value = false;
      showCustomSnackBar("OTP cannot be empty.", isError: true);
      return;
    }

    Map<String, dynamic> body = {
      "otp": otpController.value.text,
    };

    try {
      var response = await ApiClient.postData(
        ApiUrl.verificationOtpForgetPass,
        jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      otpForgetLoading.value = false;
      refresh();

      Map<String, dynamic> jsonResponse =
      response.body is String ? jsonDecode(response.body) : response.body;

      if (response.statusCode == 200 || response.statusCode == 201) {
        showCustomSnackBar(jsonResponse['message'] ?? "OTP Verified", isError: false,);

        otpController.value.clear();

        // ✅ Correct key from backend
        String resetToken = jsonResponse['resetToken'];

        // ✅ Store reset token (NOT bearer token)
        await SharePrefsHelper.setString("resetToken", resetToken,);

        Get.offAllNamed(AppRoutes.setNewPassword);
      } else {
        showCustomSnackBar(jsonResponse['message'] ?? "OTP verification failed", isError: true,);
      }
    } catch (e) {
      otpForgetLoading.value = false;
      refresh();

      showCustomSnackBar("Error occurred: $e", isError: true);
      debugPrint("OTP Verification Error: $e");
    }
  }

}
///========== Models ==========
class SignUpAuthModel {
  final String email;
  final String screenName;

  SignUpAuthModel(
      this.email,
      this.screenName,
      );
}
