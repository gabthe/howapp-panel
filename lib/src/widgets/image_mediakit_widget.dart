import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImageMediaKitWidget extends ConsumerWidget {
  final double width;
  final double height;
  final Color colors;
  final double? borderRadius;
  final void Function()? onTap;
  final void Function(PointerEnterEvent)? onEnter;
  final void Function(PointerExitEvent)? onExit;
  final String text;
  final Uint8List? imageMemory;
  const ImageMediaKitWidget({
    super.key,
    required this.width,
    required this.height,
    required this.onTap,
    required this.colors,
    required this.onEnter,
    required this.onExit,
    required this.text,
    this.imageMemory,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context, ref) {
    return MouseRegion(
      onEnter: onEnter,
      onExit: onExit,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius ?? 12),
            color: colors,
          ),
          child: imageMemory == null
              ? Center(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Colors.blueGrey[200],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadius ?? 12),
                  child: Image.memory(
                    imageMemory!,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
      ),
    );
  }
}
