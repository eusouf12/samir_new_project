import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static Future<bool> checkGalleryPermission() async {
    if (Platform.isIOS) {
      final status = await Permission.photos.request();
      if (status.isGranted) return true;
      if (status.isPermanentlyDenied) {
        _showSettingsDialog("Photo Library");
      }
      return false;
    } else {
      // Android
      var statusPhotos = await Permission.photos.status;
      var statusStorage = await Permission.storage.status;
      
      if (statusPhotos.isGranted || statusStorage.isGranted) {
        return true;
      }
      
      statusPhotos = await Permission.photos.request();
      statusStorage = await Permission.storage.request();
      
      if (statusPhotos.isGranted || statusStorage.isGranted) {
        return true;
      }
      
      if (statusPhotos.isPermanentlyDenied || statusStorage.isPermanentlyDenied) {
        _showSettingsDialog("Storage/Photos");
      }
      return false;
    }
  }

  static Future<bool> checkCameraPermission() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      return true;
    }
    if (status.isPermanentlyDenied) {
      _showSettingsDialog("Camera");
    }
    return false;
  }

  static void _showSettingsDialog(String permissionName) {
    Get.dialog(
      AlertDialog(
        title: Text("Permission Required"),
        content: Text("This app needs $permissionName permission to function properly. Please grant the permission in settings."),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              openAppSettings();
            },
            child: Text("Settings"),
          ),
        ],
      ),
    );
  }
}
