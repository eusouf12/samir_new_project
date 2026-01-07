import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/ToastMsg/toast_message.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../model/my_profile_model.dart';

class HostProfileController extends GetxController {
  ///========= Image Picker GetX Controller Code ===========//
  final Rx<File?> selectedImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

// Pick an image from the gallery
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


}