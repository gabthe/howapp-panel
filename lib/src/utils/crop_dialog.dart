import 'dart:typed_data';

import 'package:crop_image/crop_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui' as ui;

import 'package:howapp_panel/src/viewmodel/create_event_viewmodel.dart';

cropDialog(
  BuildContext context,
  CreateEventViewmodel viewmodel,
  CreateEventViewmodelNotifier notifier,
  Uint8List uint8List,
  CropController cropController,
  bool isPhoto,
) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Recortar imagem'),
        content: SizedBox(
          width: 600,
          height: 600,
          child: CropImage(
            controller: cropController,
            image: Image.memory(uint8List),
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              cropController.rotateLeft();
            },
            icon: const Icon(
              Icons.rotate_left,
            ),
          ),
          IconButton(
            onPressed: () {
              cropController.rotateRight();
            },
            icon: const Icon(
              Icons.rotate_right,
            ),
          ),
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () {
              GoRouter.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('OK'),
            onPressed: () async {
              // Adicione a ação desejada aqui
              ui.Image bitmap = await cropController.croppedBitmap();
              var data = await bitmap.toByteData(
                format: ui.ImageByteFormat.png,
              );
              if (isPhoto) {
                notifier.setEventPhoto(
                  data!.buffer.asUint8List(),
                );
              } else {
                notifier.setEventBanner(
                  data!.buffer.asUint8List(),
                );
              }

              GoRouter.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<Uint8List?> cropAnyImageDialog(
  BuildContext context,
  Uint8List imageMemory,
  CropController cropController,
) async {
  return await showDialog<Uint8List>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Recortar imagem'),
        content: SizedBox(
          width: 600,
          height: 600,
          child: CropImage(
            controller: cropController,
            image: Image.memory(imageMemory),
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              cropController.rotateLeft();
            },
            icon: const Icon(
              Icons.rotate_left,
            ),
          ),
          IconButton(
            onPressed: () {
              cropController.rotateRight();
            },
            icon: const Icon(
              Icons.rotate_right,
            ),
          ),
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () {
              GoRouter.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('OK'),
            onPressed: () async {
              // Adicione a ação desejada aqui
              ui.Image bitmap = await cropController.croppedBitmap();
              var data = await bitmap.toByteData(
                format: ui.ImageByteFormat.png,
              );

              // RETORNAR data!.buffer.asUint8List()

              GoRouter.of(context).pop(
                data!.buffer.asUint8List(),
              );
            },
          ),
        ],
      );
    },
  );
}
