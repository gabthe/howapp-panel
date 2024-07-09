import 'dart:typed_data';

import 'package:crop_image/crop_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:howapp_panel/src/utils/crop_dialog.dart';

Future<Uint8List?> getImageAndCrop(
  CropController cropController,
  BuildContext context,
) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.image,
  );

  if (result?.files.first.bytes != null) {
    if (context.mounted) {
      var image = await cropAnyImageDialog(
        context,
        result!.files.first.bytes!,
        cropController,
      );
      return image;
    }
  }
  return null;
}
