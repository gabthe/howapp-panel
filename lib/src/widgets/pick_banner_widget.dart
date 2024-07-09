import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howapp_panel/src/utils/crop_dialog.dart';
import 'package:howapp_panel/src/viewmodel/create_event_viewmodel.dart';

final _bannerBackgroundColorProvider = StateProvider<Color>((ref) {
  return Colors.grey[300]!;
});

class PickBannerWidget extends ConsumerWidget {
  final String? id;
  final bool isExperience;
  const PickBannerWidget({
    super.key,
    required this.id,
    required this.isExperience,
  });

  @override
  Widget build(BuildContext context, ref) {
    var params =
        CreateEventViewmodelParams(eventId: id, isExperience: isExperience);
    var viewmodel = ref.watch(createEventViewmodelProvider(params));
    var notifier = ref.read(createEventViewmodelProvider(params).notifier);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) {
        ref.read(_bannerBackgroundColorProvider.notifier).state =
            Colors.grey[400]!;
      },
      onExit: (event) {
        ref.read(_bannerBackgroundColorProvider.notifier).state =
            Colors.grey[300]!;
      },
      child: InkWell(
        onTap: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.image,
          );
          if (result?.files.first.bytes != null) {
            if (context.mounted) {
              cropDialog(
                context,
                viewmodel,
                notifier,
                result!.files.first.bytes!,
                viewmodel.bannerCropController,
                false,
              );
            }
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: ref.watch(_bannerBackgroundColorProvider),
          ),
          width: 800,
          height: 450,
          child: viewmodel.pickedBanner == null
              ? const Center(child: Icon(Icons.photo))
              : ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.memory(
                    viewmodel.pickedBanner!,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
      ),
    );
  }
}
