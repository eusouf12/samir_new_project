import 'dart:convert';
import 'package:get/get.dart';
import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/ToastMsg/toast_message.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../model/night_credit_model.dart';

class InfHomeController extends GetxController {

  Rxn<GiftsData> giftsData = Rxn<GiftsData>();

  final isGiftsLoading = false.obs;
  final rxGiftsStatus = Status.loading.obs;

  void setGiftsStatus(Status status) => rxGiftsStatus.value = status;

  Future<void> getUserGifts() async {
    isGiftsLoading.value = true;
    setGiftsStatus(Status.loading);

    try {
      final response = await ApiClient.getData(ApiUrl.getRedeemStars);

      final Map<String, dynamic> jsonResponse;

      if (response.statusCode == 200 || response.statusCode == 201) {

        jsonResponse = response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);

        final model = GiftsResponse.fromJson(jsonResponse);

        giftsData.value = model.data;

        setGiftsStatus(Status.completed);

      }
      else {
        setGiftsStatus(Status.error);
        showCustomSnackBar("Failed to load gifts", isError: true,);
      }
    } catch (e) {
      setGiftsStatus(Status.error);
      showCustomSnackBar("Error: ${e.toString()}", isError: true,);
    } finally {
      isGiftsLoading.value = false;
    }
  }
}