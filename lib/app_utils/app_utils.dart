import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AppUtils {
  static void showCustomModalBottomSheet(BuildContext context, Widget child,
      {Color? bgColor}) {
    showModalBottomSheet(
      context: context,
//
// topRadius: const Radius.circular(20),
//
// animationCurve: Curves.easeIn,
      backgroundColor: bgColor ?? Theme.of(context).cardTheme.color,

      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20))),
      enableDrag: true,

      // constraints:
      //     BoxConstraints(maxHeight: getDeviceSize(context).height * 0.8),
      builder: (context) => child,
    );
  }

  static Size getDeviceSize(BuildContext context) =>
      MediaQuery.of(context).size;

 static  Future<List<PlatformFile>?> pickVideo() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.video,
        allowMultiple: true
      );
      if (result != null && result.files.isNotEmpty) {
        return result.files;
      } else {}
    } catch (e) {
      print('Error picking video: $e');
      return null;
    }
  }

}



