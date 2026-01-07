import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../host_part/host_listing_screen/controller/listing_controller.dart';


class ImagePickerController extends GetxController {
  final ImagePicker _picker = ImagePicker();

  // Pick multiple images from gallery
  Future<void> pickFromGallery() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null && images.isNotEmpty) {
      final listingController = Get.find<ListingController>();
      for (var img in images) {
        listingController.addImage(File(img.path));
      }
    }
  }

  // Pick single image from camera
  Future<void> pickFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      final listingController = Get.find<ListingController>();
      listingController.addImage(File(image.path));
    }
  }
}
