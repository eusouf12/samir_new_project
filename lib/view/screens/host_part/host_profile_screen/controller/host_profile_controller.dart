import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../helper/shared_prefe/shared_prefe.dart';
import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/ToastMsg/toast_message.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../Influencer_part/inf_profile_screen/model/share_profile_model.dart';
import '../../collaboration_screen/views/stripe_web_view_create_screen.dart';
import '../model/about_us_model.dart';
import '../model/my_profile_model.dart';
import '../model/terms _model.dart';

class HostProfileController extends GetxController {
  final Rx<File?> selectedImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

// Pick an image using the camera
  Future<void> pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  //============== my profile controller============
  Rxn<UserData> userData = Rxn<UserData>();
  RxList<UserSocialMedia> socialLinks = <UserSocialMedia>[].obs;
  final isUserLoading = false.obs;
  final rxUserStatus = Status.loading.obs;
  void setUserStatus(Status status) => rxUserStatus.value = status;

  Future<void> getUserProfile() async {
    isUserLoading.value = true;
    setUserStatus(Status.loading);

    try {
      final response = await ApiClient.getData(ApiUrl.myProfile);
      final Map<String, dynamic> jsonResponse;

      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);

        final UserResponse model = UserResponse.fromJson(jsonResponse);
        userData.value = model.data;

        if (nameController.value.text.isEmpty) {
          nameController.value.text = userData.value?.name ??"";
        }
        if (fullAddress.value.text.isEmpty) {
          fullAddress.value.text = userData.value?.fullAddress ??"";
        }
        if (countryController.value.text.isEmpty) {
          countryController.value.text = userData.value?.country ??"";
        }
        emailController.value.text = userData.value?.email ??"";

        if (dateOfBirthController.value.text.isEmpty) {
          dateOfBirthController.value.text = userData.value?.dateOfBirth ?? "";
        }
        if (phoneNumberController.value.text.isEmpty) {
          phoneNumberController.value.text = userData.value?.phone ?? "";
        }
        if (userNameController.value.text.isEmpty) {
          userNameController.value.text = userData.value?.userName ?? "";
        }
        if (genderController.value.text.isEmpty) {
          genderController.value.text = userData.value?.gender ?? "";
        }
        if (userData.value?.socialMediaLinks != null) {
          socialLinks.assignAll(userData.value!.socialMediaLinks!);
        } else {
          socialLinks.clear();
        }
        setUserStatus(Status.completed);
      }
      else {
        setUserStatus(Status.error);
        showCustomSnackBar( "Error , Failed to load user profile", isError: true,);
      }
    } catch (e) {
      setUserStatus(Status.error);
      showCustomSnackBar( "Error , ${e.toString()}", isError: true,);
    } finally {
      isUserLoading.value = false;
    }
  }

  // update social media
  void addOrUpdateSocialLink({required String platform, required String url, required String followers,}) {
    if (platform.trim().isEmpty) return;

    final cleanPlatform = platform.toLowerCase().trim();
    final cleanUrl = url.startsWith("http") ? url : "https://${url.trim()}";
    final cleanFollowers = followers.replaceAll(" ", "").trim();

    int index = socialLinks.indexWhere((element) => (element.platform ?? '').toLowerCase().trim() == cleanPlatform,);

    if (index != -1) {
      socialLinks[index].url = cleanUrl;
      socialLinks[index].followers = cleanFollowers;
    }
    else {
      socialLinks.add(
        UserSocialMedia(
          platform: cleanPlatform,
          url: cleanUrl,
          followers: cleanFollowers,
        ),
      );
    }

    socialLinks.refresh();
  }

  final List<String> availablePlatforms = [
    "facebook",
    "instagram",
    "youtube",
    "tiktok",
    "x",
  ];

  RxString selectedPlatform = "".obs;
  final TextEditingController socialUrlController = TextEditingController();
  final TextEditingController followersCountController = TextEditingController();

  // Text controllers
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> userNameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> countryController = TextEditingController().obs;
  Rx<TextEditingController> fullAddress = TextEditingController().obs;
  Rx<TextEditingController> phoneNumberController = TextEditingController().obs;
  Rx<TextEditingController> dateOfBirthController = TextEditingController().obs;
  Rx<TextEditingController> genderController = TextEditingController().obs;

  //========== Update Profile ==========
  RxBool updateProfileLoading = false.obs;
  Future<void> updateProfile() async {
    final role = await SharePrefsHelper.getString(AppConstants.role);
    updateProfileLoading.value = true;
    refresh();

    try {
      Map<String, dynamic> body = {
        "name": nameController.value.text,
        "userName": userNameController.value.text,
        "phone": phoneNumberController.value.text,
        "dateOfBirth": dateOfBirthController.value.text,
        "country": countryController.value.text,
        "fullAddress": fullAddress.value.text,
        "gender": genderController.value.text,
      };

      /// Only influencer gets social links
      if (role != "host") {
        body["socialMediaLinks"] =
            socialLinks.map((e) => e.toJson()).toList();
      }

      dynamic response;
      if (selectedImage.value != null) {
        response = await ApiClient.patchMultipartData(ApiUrl.updateProfile, body,
          multipartBody: [
            MultipartBody("image", selectedImage.value!),
          ],
        );
      } else {
        response = await ApiClient.patchData(ApiUrl.updateProfile, jsonEncode(body),);
      }

      updateProfileLoading.value = false;
      refresh();

      Map<String, dynamic> jsonResponse = response.body is String ? jsonDecode(response.body) : response.body as Map<String, dynamic>;

      if (response.statusCode == 200 || response.statusCode == 201) {
          getUserProfile();

           Navigator.of(Get.context!).pop();
          Future.delayed(const Duration(milliseconds: 100), () {
            showCustomSnackBar(jsonResponse['message']?.toString() ?? "Profile updated successfully!", isError: false,);
          });
      }
      else {
        showCustomSnackBar(jsonResponse['message']?.toString() ?? "Update failed", isError: true,);
      }
    } catch (e) {
      updateProfileLoading.value = false;
      refresh();
      showCustomSnackBar("An error occurred. Please try again.", isError: true,);
      debugPrint("Profile update error: $e");
    }
  }

  //=================== CHANGE PASS===================
  Rx<TextEditingController> newPasswordController = TextEditingController().obs;
  Rx<TextEditingController> confirmPasswordController = TextEditingController().obs;
  Rx<TextEditingController> oldPasswordController = TextEditingController().obs;
  RxBool changePassLoading = false.obs;

  Future<void> changePassword() async {
    changePassLoading.value = true;
    refresh();

    try {
      Map<String, String> body = {
        "currentPassword": oldPasswordController.value.text.trim(),
        "newPassword": newPasswordController.value.text.trim(),
        "confirmPassword": confirmPasswordController.value.text.trim(),
      };

      dynamic response = await ApiClient.postData(ApiUrl.changePassword, jsonEncode(body),);
      changePassLoading.value = false;
      refresh();

      Map<String, dynamic> jsonResponse = response.body is String
          ? jsonDecode(response.body)
          : response.body as Map<String, dynamic>;

      if (response.statusCode == 200 || response.statusCode == 201) {
        showCustomSnackBar(jsonResponse['message']?.toString() ?? "Change password successfully!", isError: false,);

        String? userRole = await SharePrefsHelper.getString(AppConstants.role);
        resetPasswordFields();
        Get.back();

      }
      else if (response.statusCode == 404 || response.statusCode == 400 || response.statusCode == 422) {
        // Handle validation errors
        Map<String, dynamic> jsonResponse = response.body is String
            ? jsonDecode(response.body)
            : response.body as Map<String, dynamic>;

        if (jsonResponse.containsKey('errorSources') && jsonResponse['errorSources'] is List) {
          List<dynamic> errorSources = jsonResponse['errorSources'];

          // Show all error messages
          for (var error in errorSources) {
            if (error is Map<String, dynamic> && error.containsKey('message')) {
              showCustomSnackBar(error['message'].toString(), isError: true);
              break;
            }
          }
        } else if (jsonResponse.containsKey('message')) {
          showCustomSnackBar(jsonResponse['message'].toString(), isError: true);
        } else {
          showCustomSnackBar("Invalid data provided", isError: true);
        }
      }
      else {
        showCustomSnackBar(jsonResponse['message']?.toString() ?? "Change password failed", isError: true,);
      }
    } catch (e) {
      changePassLoading.value = false;
      refresh();
      showCustomSnackBar("An error occurred. Please try again.", isError: true,);
      debugPrint("Password update error: $e");
    }
  }

  void resetPasswordFields() {
    oldPasswordController.value.clear();
    newPasswordController.value.clear();
    confirmPasswordController.value.clear();
  }

  //==================== Get About Us =================
  final rxAboutStatus = Status.loading.obs;
  void setAboutStatus(Status status) {rxAboutStatus.value = status;}

  Rx<LegalDocumentAboutModel?> aboutUsModel = Rx<LegalDocumentAboutModel?>(null);

  Future<void> getAboutUs() async {
    setAboutStatus(Status.loading);

    try {
      final response = await ApiClient.getData(ApiUrl.aboutUs);

      if (response.statusCode == 200 || response.statusCode == 201) {

        final Map<String, dynamic> jsonResponse = response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);

        aboutUsModel.value = LegalDocumentAboutModel.fromJson(jsonResponse);


        setAboutStatus(Status.completed);

        debugPrint(
          "================ About Us Loaded =================\n"
              "Total Items: ${aboutUsModel.value?.description}",
        );

      } else if (response.statusCode == 404) {
        setAboutStatus(Status.error);
        aboutUsModel.value = null;
      } else {
        setAboutStatus(
          response.statusText == ApiClient.somethingWentWrong
              ? Status.internetError
              : Status.error,
        );
      }
    } catch (e) {
      setAboutStatus(Status.error);
      debugPrint("About Us Parsing/Error: $e");
    }

    refresh();
  }

  // ================ terms =============

  final rxStatus = Status.loading.obs;
  void setStatus(Status status) => rxStatus.value = status;

  Rx<LegalDocumentModel?> termsModel = Rx<LegalDocumentModel?>(null);

  Future<void> getTermsConditions() async {
    setStatus(Status.loading);
    try {
      final response = await ApiClient.getData(ApiUrl.termsCondition);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = response.body is String
            ? jsonDecode(response.body)
            : Map<String, dynamic>.from(response.body);

        final listData = jsonResponse['data'] as List<dynamic>? ?? [];
        if (listData.isNotEmpty) {
          termsModel.value = LegalDocumentModel.fromJson(listData.first);
        } else {
          termsModel.value = LegalDocumentModel(content: '', description: '');
        }

        setStatus(Status.completed);
      } else if (response.statusCode == 404) {
        setStatus(Status.error);
        termsModel.value = null;
      } else {
        setStatus(response.statusText == ApiClient.somethingWentWrong
            ? Status.internetError
            : Status.error);
      }
    } catch (e) {
      setStatus(Status.error);
      debugPrint("Terms Parsing/Error: $e");
    }
  }

  //  =================== Privacy Policy =============

  final rxPrivacyStatus = Status.loading.obs;
  void setPrivacyStatus(Status status) => rxPrivacyStatus.value = status;

  Rx<LegalDocumentModel?> privacyModel = Rx<LegalDocumentModel?>(null);

  Future<void> getPrivacyPolicy() async {
    setPrivacyStatus(Status.loading);
    try {
      final response = await ApiClient.getData(ApiUrl.privacyPolicy);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = response.body is String
            ? jsonDecode(response.body)
            : Map<String, dynamic>.from(response.body);

        final listData = jsonResponse['data'] as List<dynamic>? ?? [];
        if (listData.isNotEmpty) {
          privacyModel.value = LegalDocumentModel.fromJson(listData.first);
        } else {
          privacyModel.value = LegalDocumentModel(content: '', description: '');
        }

        setPrivacyStatus(Status.completed);
      } else if (response.statusCode == 404) {
        setPrivacyStatus(Status.error);
        privacyModel.value = null;
      } else {
        setPrivacyStatus(response.statusText == ApiClient.somethingWentWrong
            ? Status.internetError
            : Status.error);
      }
    } catch (e) {
      setPrivacyStatus(Status.error);
      debugPrint("Privacy Parsing/Error: $e");
    }
  }

  // ======== share profile ========== shareProfile
  Rxn<ShareableData> shareProfileData = Rxn<ShareableData>();
  final isShareProfileLoading = false.obs;
  final rxShareProfileStatus = Status.loading.obs;

  void setShareProfileStatus(Status status) => rxShareProfileStatus.value = status;

  Future<void> shareProfile() async {
    isShareProfileLoading.value = true;
    setShareProfileStatus(Status.loading);

    try {
      final response = await ApiClient.getData(ApiUrl.shareProfile);

      final Map<String, dynamic> jsonResponse;

      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);

        final ShareableLinkResponse model =
        ShareableLinkResponse.fromJson(jsonResponse);

        shareProfileData.value = model.data;

        setShareProfileStatus(Status.completed);
      } else {
        setShareProfileStatus(Status.error);
        showCustomSnackBar("Error, Failed to load share profile", isError: true,);
      }
    } catch (e) {
      setShareProfileStatus(Status.error);
      showCustomSnackBar("Error, ${e.toString()}", isError: true,);
    } finally {
      isShareProfileLoading.value = false;
    }
  }

  // inf payment

  RxBool infPaymentLoading = false.obs;

  Future<void> influencerOnboarding() async {
    infPaymentLoading.value = true;
    update();

    try {
      var response = await ApiClient.postData(ApiUrl.infPayment, jsonEncode({}),);

      infPaymentLoading.value = false;
      Map<String, dynamic> jsonResponse = response.body is String ? jsonDecode(response.body) : response.body as Map<String, dynamic>;

      if (response.statusCode == 200 || response.statusCode == 201) {
        final onboardingUrl = jsonResponse["onboardingLink"];

        if (onboardingUrl != null && onboardingUrl.toString().isNotEmpty) {
          showCustomSnackBar(jsonResponse['message']?.toString() ?? "Redirecting to Stripe...", isError: false,);

          Get.to(() => StripeWebViewCreateScreen(checkoutUrl: onboardingUrl));
        } else {
          showCustomSnackBar(jsonResponse['message']?.toString()??"Onboarding link not found.", isError: true);
        }
      } else {
        showCustomSnackBar(jsonResponse['message']?.toString() ?? "Verification failed.", isError: true,);
      }
    } catch (e) {
      infPaymentLoading.value = false;
      showCustomSnackBar("Something went wrong.", isError: true);
      debugPrint("Influencer Onboarding Error: $e");
    } finally {
      update();
    }
  }
}