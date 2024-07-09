import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:howapp_panel/src/utils/crop_dialog.dart';
import 'package:howapp_panel/src/utils/get_16x9_proportion.dart';
import 'package:howapp_panel/src/utils/get_image_and_crop.dart';
import 'package:howapp_panel/src/viewmodel/create_event_viewmodel.dart';
import 'package:howapp_panel/src/widgets/image_mediakit_widget.dart';

class MediaKitButtonWidget extends StatelessWidget {
  final String? id;
  final bool isExperience;
  const MediaKitButtonWidget({
    super.key,
    required this.id,
    required this.isExperience,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      height: 40,
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: Consumer(
                  builder: (context, ref, child) {
                    var param = CreateEventViewmodelParams(
                        eventId: id, isExperience: isExperience);
                    var viewmodel =
                        ref.watch(createEventViewmodelProvider(param));
                    var notifier =
                        ref.read(createEventViewmodelProvider(param).notifier);
                    return Container(
                      padding: const EdgeInsets.all(8),
                      width: 1000,
                      height: 800,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  GoRouter.of(context).pop();
                                },
                                icon: Icon(Icons.arrow_back_ios),
                              ),
                              Text('Media kit'),
                            ],
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 900,
                                    width: 900,
                                    child: GridView(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 20,
                                        mainAxisSpacing: 20,
                                      ),
                                      children: [
                                        if (viewmodel
                                            .useCreatorPhotoAsEventPhoto)
                                          SizedBox(
                                            height: 500,
                                            width: 500,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(500),
                                              child: Image.network(
                                                viewmodel.selectedEventCreator!
                                                    .profilePictureUrl,
                                              ),
                                            ),
                                          ),
                                        if (!viewmodel
                                            .useCreatorPhotoAsEventPhoto)
                                          Center(
                                            child: ImageMediaKitWidget(
                                              borderRadius: 500,
                                              colors: Colors.grey[300]!,
                                              height: 500,
                                              width: 500,
                                              onEnter: (p0) {},
                                              onExit: (p0) {},
                                              imageMemory:
                                                  viewmodel.pickedPhoto,
                                              onTap: () async {
                                                FilePickerResult? result =
                                                    await FilePicker.platform
                                                        .pickFiles(
                                                  type: FileType.image,
                                                );
                                                if (result?.files.first.bytes !=
                                                    null) {
                                                  if (context.mounted) {
                                                    cropDialog(
                                                      context,
                                                      viewmodel,
                                                      notifier,
                                                      result!
                                                          .files.first.bytes!,
                                                      viewmodel
                                                          .photoCropController,
                                                      true,
                                                    );
                                                  }
                                                }
                                              },
                                              text: 'Foto (4x4)',
                                            ),
                                          ),
                                        Center(
                                          child: ImageMediaKitWidget(
                                            colors: Colors.grey[300]!,
                                            width: 500,
                                            height: getProportion(500),
                                            onEnter: (p0) {},
                                            onExit: (p0) {},
                                            imageMemory: viewmodel.pickedBanner,
                                            onTap: () async {
                                              FilePickerResult? result =
                                                  await FilePicker.platform
                                                      .pickFiles(
                                                type: FileType.image,
                                              );
                                              if (result?.files.first.bytes !=
                                                  null) {
                                                if (context.mounted) {
                                                  cropDialog(
                                                    context,
                                                    viewmodel,
                                                    notifier,
                                                    result!.files.first.bytes!,
                                                    viewmodel
                                                        .bannerCropController,
                                                    false,
                                                  );
                                                }
                                              }
                                            },
                                            text: 'Banner (16x9)',
                                          ),
                                        ),
                                        ImageMediaKitWidget(
                                          colors: Colors.grey[300]!,
                                          width: 500,
                                          height: 500,
                                          onEnter: (p0) {},
                                          onExit: (p0) {},
                                          imageMemory:
                                              viewmodel.pickedCarouselBigImage,
                                          onTap: () async {
                                            var image = await getImageAndCrop(
                                              viewmodel
                                                  .carouselBigImageCropController,
                                              context,
                                            );
                                            if (image != null) {
                                              notifier.setEventBigCarouselImage(
                                                  image);
                                            }
                                          },
                                          text: 'Foto carrocel grande (4x4)',
                                        ),
                                        Center(
                                          child: ImageMediaKitWidget(
                                            colors: Colors.grey[300]!,
                                            width: 250,
                                            height: 250,
                                            onEnter: (p0) {},
                                            onExit: (p0) {},
                                            imageMemory: viewmodel
                                                .pickedCarouselSmallImage,
                                            onTap: () async {
                                              var image = await getImageAndCrop(
                                                viewmodel
                                                    .carouselSmallImageCropController,
                                                context,
                                              );
                                              if (image != null) {
                                                notifier
                                                    .setEventSmallCarouselImage(
                                                  image,
                                                );
                                              }
                                            },
                                            text: 'Foto carrocel pequeno (2x2)',
                                          ),
                                        ),
                                        Center(
                                          child: ImageMediaKitWidget(
                                            colors: Colors.grey[300]!,
                                            width: 400,
                                            height: 60,
                                            onEnter: (p0) {},
                                            onExit: (p0) {},
                                            imageMemory:
                                                viewmodel.pickedCardImage,
                                            onTap: () async {
                                              var image = await getImageAndCrop(
                                                viewmodel
                                                    .cardImageCropController,
                                                context,
                                              );
                                              if (image != null) {
                                                notifier.setEventCardImage(
                                                  image,
                                                );
                                              }
                                            },
                                            text: 'Foto card (20x3)',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
        child: const Text('Media kit'),
      ),
    );
  }
}
