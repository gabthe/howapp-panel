import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howapp_panel/src/utils/crop_dialog.dart';
import 'package:howapp_panel/src/view/create_event_view.dart';
import 'package:howapp_panel/src/viewmodel/create_event_viewmodel.dart';
import 'package:howapp_panel/src/widgets/header_info_row_widget.dart';
import 'package:howapp_panel/src/widgets/pick_banner_widget.dart';

final _photoBackgroundColorProvider = StateProvider<Color>((ref) {
  return Colors.grey[100]!;
});

class EventInfosWidget extends ConsumerWidget {
  final String? id;
  final bool isExperience;
  const EventInfosWidget({
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
    return SizedBox(
      height: 500,
      width: double.infinity,
      child: Align(
        alignment: Alignment.topCenter,
        child: Stack(
          children: [
            PickBannerWidget(
              id: id,
              isExperience: isExperience,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: viewmodel.pickedBanner == null
                      ? Colors.transparent
                      : Colors.black45,
                  borderRadius: BorderRadius.circular(18),
                ),
                width: 800,
                child: Row(
                  children: [
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      onEnter: (event) {
                        ref.read(_photoBackgroundColorProvider.notifier).state =
                            Colors.grey[400]!;
                      },
                      onExit: (event) {
                        ref.read(_photoBackgroundColorProvider.notifier).state =
                            Colors.grey[100]!;
                      },
                      child: InkWell(
                        onTap: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                            type: FileType.image,
                          );
                          if (result?.files.first.bytes != null) {
                            if (context.mounted) {
                              cropDialog(
                                context,
                                viewmodel,
                                notifier,
                                result!.files.first.bytes!,
                                viewmodel.photoCropController,
                                true,
                              );
                            }
                          }
                        },
                        child: CircleAvatar(
                          backgroundColor:
                              ref.watch(_photoBackgroundColorProvider),
                          radius: 50,
                          child: viewmodel.useCreatorPhotoAsEventPhoto
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.network(
                                    viewmodel.selectedEventCreator!
                                        .profilePictureUrl,
                                  ),
                                )
                              : viewmodel.pickedPhoto == null
                                  ? const Icon(Icons.photo)
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.memory(
                                        viewmodel.pickedPhoto!,
                                      ),
                                    ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HeaderInfoRowWidget(
                            icons: Icons.home,
                            placeholderText: 'Nome do evento',
                            text: viewmodel.eventNameOnChangeString,
                            darkMode: viewmodel.pickedBanner != null,
                          ),
                          HeaderInfoRowWidget(
                            icons: Icons.info,
                            placeholderText: 'Descrição do evento',
                            text: viewmodel.eventDescritionOnChangeString,
                            darkMode: viewmodel.pickedBanner != null,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HeaderInfoRowWidget(
                            icons: Icons.person,
                            placeholderText: 'Organizador do evento',
                            text: viewmodel.selectedEventCreator?.name ?? '',
                            darkMode: viewmodel.pickedBanner != null,
                          ),
                          HeaderInfoRowWidget(
                            icons: Icons.calendar_month,
                            placeholderText: 'Data do evento',
                            text: viewmodel.changedDateOnce
                                ? formatDate(
                                    DateTime.utc(
                                      viewmodel.selectedYear,
                                      viewmodel.selectedMonth,
                                      viewmodel.selectedDay,
                                      viewmodel.selectedHour,
                                      viewmodel.selectedMinute,
                                    ),
                                  )
                                : '',
                            darkMode: viewmodel.pickedBanner != null,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HeaderInfoRowWidget(
                            icons: Icons.label,
                            placeholderText: 'Tags do evento',
                            text: viewmodel.selectedEventTags.isEmpty
                                ? ''
                                : viewmodel.allEventTags
                                    .map(
                                      (e) {
                                        return e.tagName + ', ';
                                      },
                                    )
                                    .toList()
                                    .join(),
                            darkMode: viewmodel.pickedBanner != null,
                          ),
                          HeaderInfoRowWidget(
                            icons: Icons.location_on,
                            placeholderText: 'Local do evento',
                            text: viewmodel.selectedLocalization == null
                                ? ''
                                : viewmodel.selectedLocalization!.fullAddress,
                            darkMode: viewmodel.pickedBanner != null,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
