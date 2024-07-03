import 'package:crop_image/crop_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:howapp_panel/src/model/activity.dart';
import 'package:howapp_panel/src/model/event_tag.dart';
import 'package:howapp_panel/src/utils/api_state.dart';
import 'package:howapp_panel/src/utils/crop_dialog.dart';
import 'package:howapp_panel/src/utils/get_16x9_proportion.dart';
import 'package:howapp_panel/src/viewmodel/create_event_viewmodel.dart';
import 'package:howapp_panel/src/widgets/pick_banner_widget.dart';
import 'package:howapp_panel/src/widgets/select_commercial_profile_dialog_widget.dart';
import 'package:intl/intl.dart';

final _isMouseOverScheduleBigButton = StateProvider<bool>((ref) {
  return false;
});

final _isMouseOverMapBigButton = StateProvider<bool>((ref) {
  return false;
});

final _isMouseOverEventCreatorBigButton = StateProvider<bool>((ref) {
  return false;
});

final _isMouseOverEventTagsBigButton = StateProvider<bool>((ref) {
  return false;
});

_formatDate(DateTime date) {
  String formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(date);
  return formattedDate;
}

final _photoBackgroundColorProvider = StateProvider<Color>((ref) {
  return Colors.grey[100]!;
});

class CreateEventView extends ConsumerWidget {
  final String? id;
  const CreateEventView({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var viewmodel = ref.watch(createEventViewmodelProvider(id));
    var notifier = ref.read(createEventViewmodelProvider(id).notifier);
    final List<int> days = List<int>.generate(31, (index) => index + 1);
    final List<int> months = List<int>.generate(12, (index) => index + 1);
    final List<int> years = [
      2023,
      2024,
      2025,
      2026,
    ];
    final List<int> hours = List<int>.generate(24, (index) => index);
    final List<int> minutes = List<int>.generate(60, (index) => index);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(id == null ? 'Criar novo evento' : 'Editar evento'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              child: Center(
                child: Container(
                  color: Colors.grey[100],
                  child: Column(
                    children: [
                      EventInfosWidget(
                        viewmodel: viewmodel,
                        notifier: notifier,
                        id: id,
                      ),
                      SizedBox(
                        width: 600,
                        child: TextFormField(
                          onChanged: (value) {
                            notifier.eventNameOnChange(value);
                          },
                          decoration: const InputDecoration(
                            labelText: 'Nome do evento',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 600,
                        child: TextFormField(
                          onChanged: (value) {
                            notifier.eventDescriptionOnChange(value);
                          },
                          decoration: const InputDecoration(
                            labelText: 'Descrição',
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(24),
                        ),
                        width: 600,
                        child: ListTile(
                          selected: viewmodel.hasTicketSelling,
                          title: const Text('Venda de ingresso'),
                          trailing: Switch(
                            value: viewmodel.hasTicketSelling,
                            onChanged: (bool value) {
                              notifier.toggleTicketSelling();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(24),
                        ),
                        width: 600,
                        child: ListTile(
                          selected: viewmodel.hasHowStore,
                          title: const Text('How Store'),
                          trailing: Switch(
                            value: viewmodel.hasHowStore,
                            onChanged: (bool value) {
                              notifier.toggleHasHowStore();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      EventDateWidget(
                        days: days,
                        viewmodel: viewmodel,
                        months: months,
                        years: years,
                        hours: hours,
                        minutes: minutes,
                        id: id,
                      ),
                      const SizedBox(height: 12),
                      if (viewmodel.selectedLocalization == null)
                        EmptyLocalizationWidget(
                          viewmodel: viewmodel,
                          notifier: notifier,
                        ),
                      if (viewmodel.selectedLocalization != null)
                        ShowSelectedLocalizationWidget(
                          viewmodel: viewmodel,
                          notifier: notifier,
                        ),
                      const SizedBox(height: 12),
                      EventCreatorWidget(
                        viewmodel: viewmodel,
                      ),
                      if (viewmodel.selectedEventCreator != null)
                        const SizedBox(height: 12),
                      if (viewmodel.selectedEventCreator != null)
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(24),
                          ),
                          width: 600,
                          child: ListTile(
                            selected: viewmodel.useCreatorPhotoAsEventPhoto,
                            title: const Text(
                                'Usar foto do criador do evento como foto do evento'),
                            trailing: Switch(
                              value: viewmodel.useCreatorPhotoAsEventPhoto,
                              onChanged: (bool value) {
                                notifier.toggleUseCreatorPhotoAsEventPhoto();
                              },
                            ),
                          ),
                        ),
                      const SizedBox(height: 12),
                      EventTagsBigButtonWidget(
                        viewmodel: viewmodel,
                        notifier: notifier,
                        id: id,
                      ),
                      const SizedBox(height: 12),
                      if (viewmodel.listOfEventActivities.isEmpty)
                        EmptyEventActivitiesWidget(
                          days: days,
                          months: months,
                          years: years,
                          hours: hours,
                          minutes: minutes,
                          id: id,
                        ),
                      if (viewmodel.listOfEventActivities.isNotEmpty)
                        ListOfActivitiesWidget(
                          viewmodel: viewmodel,
                          days: days,
                          months: months,
                          years: years,
                          hours: hours,
                          minutes: minutes,
                          id: id,
                        ),
                      const SizedBox(height: 12),
                      MediaKitButtonWidget(
                        id: id,
                      ),
                      const SizedBox(height: 12),
                      if (viewmodel.creatingEventInFirestore !=
                          ApiState.pending)
                        SizedBox(
                          width: 600,
                          height: 40,
                          child: ElevatedButton(
                            child: const Text('Criar evento'),
                            onPressed: () async {
                              var errorMessage = notifier.validateEventForm();
                              if (errorMessage == null) {
                                await notifier.createEvent();
                                if (context.mounted) {
                                  ref.invalidate(createEventViewmodelProvider);

                                  GoRouter.of(context)
                                      .pushReplacementNamed('home');
                                  showSuccessSnackbar(context, 'Evento criado');
                                }
                              } else {
                                showErrorSnackbar(context, errorMessage);
                              }
                            },
                          ),
                        ),
                      const SizedBox(height: 64),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 15,
            right: 15,
            child: EventCreationHelperWidget(viewmodel: viewmodel),
          ),
          if (viewmodel.creatingEventInFirestore == ApiState.pending ||
              viewmodel.fetchingEventData == ApiState.pending)
            Container(
              color: Colors.grey.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}

void showErrorSnackbar(
  BuildContext context,
  String message,
) {
  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor: Colors.red,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showSuccessSnackbar(
  BuildContext context,
  String message,
) {
  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor: Colors.green,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

class EventCreationHelperWidget extends StatelessWidget {
  const EventCreationHelperWidget({
    super.key,
    required this.viewmodel,
  });

  final CreateEventViewmodel viewmodel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.grey[300]!.withOpacity(0.7),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: EdgeInsets.all(16),
      child: Expanded(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Checklist'),
              SizedBox(
                height: 50,
                child: CheckboxListTile(
                  title: const Text(
                    'Preencher nome',
                    style: TextStyle(fontSize: 12),
                  ),
                  value: viewmodel.eventNameOnChangeString.isNotEmpty,
                  onChanged: (bool? value) {},
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              SizedBox(
                height: 50,
                child: CheckboxListTile(
                  title: const Text(
                    'Preencher descrição',
                    style: TextStyle(fontSize: 12),
                  ),
                  value: viewmodel.eventDescritionOnChangeString.isNotEmpty,
                  onChanged: (bool? value) {},
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              SizedBox(
                height: 50,
                child: CheckboxListTile(
                  title: const Text(
                    'Selecionar data',
                    style: TextStyle(fontSize: 12),
                  ),
                  value: viewmodel.changedDateOnce,
                  onChanged: (bool? value) {},
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              SizedBox(
                height: 50,
                child: CheckboxListTile(
                  title: const Text(
                    'Selecionar local',
                    style: TextStyle(fontSize: 12),
                  ),
                  value: viewmodel.selectedLocalization != null,
                  onChanged: (bool? value) {},
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              SizedBox(
                height: 50,
                child: CheckboxListTile(
                  title: const Text(
                    'Selecionar foto do evento',
                    style: TextStyle(fontSize: 12),
                  ),
                  value: viewmodel.pickedPhoto != null ||
                      viewmodel.useCreatorPhotoAsEventPhoto,
                  onChanged: (bool? value) {},
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              SizedBox(
                height: 50,
                child: CheckboxListTile(
                  title: const Text(
                    'Selecionar perfil do criador',
                    style: TextStyle(fontSize: 12),
                  ),
                  value: viewmodel.selectedEventCreator != null,
                  onChanged: (bool? value) {},
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              SizedBox(
                height: 50,
                child: CheckboxListTile(
                  title: const Text(
                    'Selecionar banner',
                    style: TextStyle(fontSize: 12),
                  ),
                  value: viewmodel.pickedBanner != null,
                  onChanged: (bool? value) {},
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              SizedBox(
                height: 50,
                child: CheckboxListTile(
                  title: const Text(
                    'Preencher tags',
                    style: TextStyle(fontSize: 12),
                  ),
                  value: viewmodel.selectedEventTags.isNotEmpty,
                  onChanged: (bool? value) {},
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              SizedBox(
                height: 50,
                child: CheckboxListTile(
                  title: const Text(
                    'Selecionar imagem grande do carrossel',
                    style: TextStyle(fontSize: 12),
                  ),
                  value: viewmodel.pickedCarouselBigImage != null,
                  onChanged: (bool? value) {},
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              SizedBox(
                height: 50,
                child: CheckboxListTile(
                  title: const Text(
                    'Selecionar imagem pequena do carrossel ',
                    style: TextStyle(fontSize: 12),
                  ),
                  value: viewmodel.pickedCarouselSmallImage != null,
                  onChanged: (bool? value) {},
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              SizedBox(
                height: 50,
                child: CheckboxListTile(
                  title: const Text(
                    'Selecionar imagem do card ',
                    style: TextStyle(fontSize: 12),
                  ),
                  value: viewmodel.pickedCardImage != null,
                  onChanged: (bool? value) {},
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              SizedBox(
                height: 50,
                child: CheckboxListTile(
                  title: const Text(
                    'Preencher cronograma',
                    style: TextStyle(fontSize: 12),
                  ),
                  value: viewmodel.listOfEventActivities.isNotEmpty,
                  onChanged: (bool? value) {},
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MediaKitButtonWidget extends StatelessWidget {
  final String? id;
  const MediaKitButtonWidget({
    super.key,
    required this.id,
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
                    var viewmodel = ref.watch(createEventViewmodelProvider(id));
                    var notifier =
                        ref.read(createEventViewmodelProvider(id).notifier);
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

class MediaKitTextWidget extends StatelessWidget {
  final String text;
  const MediaKitTextWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class EventTagsBigButtonWidget extends ConsumerWidget {
  final String? id;
  const EventTagsBigButtonWidget({
    super.key,
    required this.viewmodel,
    required this.notifier,
    required this.id,
  });

  final CreateEventViewmodel viewmodel;
  final CreateEventViewmodelNotifier notifier;

  @override
  Widget build(BuildContext context, ref) {
    return MouseRegion(
      onEnter: (event) {
        ref.read(_isMouseOverEventTagsBigButton.notifier).state = true;
      },
      onExit: (event) {
        ref.read(_isMouseOverEventTagsBigButton.notifier).state = false;
      },
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return Consumer(builder: (context, ref, child) {
                var currentViewmodel =
                    ref.watch(createEventViewmodelProvider(id));
                var currentNotifier =
                    ref.read(createEventViewmodelProvider(id).notifier);
                return Dialog(
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      return Container(
                        padding: const EdgeInsets.all(8),
                        width: 300,
                        height: 600,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    GoRouter.of(context).pop();
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back_ios,
                                  ),
                                ),
                                const Text(
                                  'Selecionar tags do evento',
                                ),
                              ],
                            ),
                            Expanded(
                              flex: 2,
                              child: ListView.builder(
                                itemCount: currentViewmodel.allEventTags.length,
                                itemBuilder: (context, index) {
                                  EventTag eventTag =
                                      currentViewmodel.allEventTags[index];
                                  return Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: Row(
                                        children: [
                                          Text(
                                            eventTag.tagName,
                                          ),
                                          const Spacer(),
                                          TextButton(
                                            onPressed: () {
                                              // Atualize o estado do viewmodel
                                              currentNotifier.addNewTagToEvent(
                                                eventTag,
                                              );
                                            },
                                            child: const Text(
                                              'Adicionar',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const Text('Tags adicionadas'),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: ListView.builder(
                                  itemCount:
                                      currentViewmodel.selectedEventTags.length,
                                  itemBuilder: (context, index) {
                                    var selectedTag = currentViewmodel
                                        .selectedEventTags[index];
                                    return Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              selectedTag.tagName,
                                            ),
                                            const Spacer(),
                                            TextButton(
                                              onPressed: () {
                                                currentNotifier
                                                    .removeTagFromEvent(
                                                        selectedTag);
                                              },
                                              child: const Text('Remover'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              });
            },
          );
        },
        child: Container(
          width: 600,
          height: 150,
          decoration: BoxDecoration(
            color: ref.watch(_isMouseOverEventTagsBigButton)
                ? Colors.grey[400]
                : Colors.grey[300],
            borderRadius: BorderRadius.circular(24),
          ),
          child: viewmodel.selectedEventTags.isNotEmpty
              ? ListView.builder(
                  itemCount: viewmodel.selectedEventTags.length,
                  itemBuilder: (context, index) {
                    var selectedTag = viewmodel.selectedEventTags[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            Text(
                              selectedTag.tagName,
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                notifier.removeTagFromEvent(selectedTag);
                              },
                              child: const Text('Remover'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Text(
                    'Tags do evento',
                    style: TextStyle(
                      color: ref.watch(_isMouseOverEventTagsBigButton)
                          ? Colors.blueGrey[100]
                          : Colors.blueGrey[200],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

class EventDateWidget extends StatelessWidget {
  const EventDateWidget({
    super.key,
    required this.days,
    required this.viewmodel,
    required this.months,
    required this.years,
    required this.hours,
    required this.minutes,
    required this.id,
  });

  final List<int> days;
  final CreateEventViewmodel viewmodel;
  final List<int> months;
  final List<int> years;
  final List<int> hours;
  final List<int> minutes;
  final String? id;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      child: Row(
        children: [
          const Text('Data do evento: '),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropDownDatePickerWidget(
                intList: days,
                type: 'day',
                initialValue: viewmodel.selectedDay,
                id: id,
              ),
              const Text('/'),
              DropDownDatePickerWidget(
                intList: months,
                type: 'month',
                initialValue: viewmodel.selectedMonth,
                id: id,
              ),
              const Text('/'),
              DropDownDatePickerWidget(
                intList: years,
                type: 'year',
                initialValue: viewmodel.selectedYear,
                id: id,
              ),
              const Text(' : '),
              DropDownDatePickerWidget(
                intList: hours,
                type: 'hour',
                initialValue: viewmodel.selectedHour,
                id: id,
              ),
              const Text(':'),
              DropDownDatePickerWidget(
                intList: minutes,
                type: 'minute',
                initialValue: viewmodel.selectedMinute,
                id: id,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class EventCreatorWidget extends ConsumerWidget {
  const EventCreatorWidget({
    super.key,
    required this.viewmodel,
  });

  final CreateEventViewmodel viewmodel;

  @override
  Widget build(BuildContext context, ref) {
    return MouseRegion(
      onEnter: (event) {
        ref.read(_isMouseOverEventCreatorBigButton.notifier).state = true;
      },
      onExit: (event) {
        ref.read(_isMouseOverEventCreatorBigButton.notifier).state = false;
      },
      child: InkWell(
        onTap: () {
          showDialog<void>(
            context: context,
            barrierDismissible: true, // user must tap button for close dialog!
            builder: (BuildContext context) {
              return const SelectComercialProfileDialog();
            },
          );
        },
        child: SizedBox(
          height: viewmodel.selectedEventCreator == null
              ? getProportion(600)
              : getProportion(600) + 40,
          child: Stack(
            children: [
              Container(
                width: 600,
                height: getProportion(600),
                decoration: BoxDecoration(
                  color: ref.watch(_isMouseOverEventCreatorBigButton)
                      ? Colors.grey[400]
                      : Colors.grey[300],
                  borderRadius: BorderRadius.circular(24),
                ),
                child: viewmodel.selectedEventCreator != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Image.network(
                          viewmodel.selectedEventCreator!.bannerPictureUrl,
                          fit: BoxFit.contain,
                        ),
                      )
                    : Center(
                        child: Text(
                          'Criador do evento',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ref.watch(_isMouseOverEventCreatorBigButton)
                                ? Colors.blueGrey[100]
                                : Colors.blueGrey[200],
                          ),
                        ),
                      ),
              ),
              if (viewmodel.selectedEventCreator != null)
                Positioned(
                  bottom: 0,
                  left: 10,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                          viewmodel.selectedEventCreator!.profilePictureUrl,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        color: Colors.black54,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              viewmodel.selectedEventCreator!.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              viewmodel.selectedEventCreator!.username,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}

class EventInfosWidget extends ConsumerWidget {
  final String? id;
  const EventInfosWidget(
      {super.key,
      required this.viewmodel,
      required this.notifier,
      required this.id});

  final CreateEventViewmodel viewmodel;
  final CreateEventViewmodelNotifier notifier;

  @override
  Widget build(BuildContext context, ref) {
    return SizedBox(
      height: 500,
      width: double.infinity,
      child: Align(
        alignment: Alignment.topCenter,
        child: Stack(
          children: [
            PickBannerWidget(id: id),
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
                                ? _formatDate(
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

class EmptyLocalizationWidget extends ConsumerWidget {
  const EmptyLocalizationWidget({
    super.key,
    required this.viewmodel,
    required this.notifier,
  });

  final CreateEventViewmodel viewmodel;
  final CreateEventViewmodelNotifier notifier;

  @override
  Widget build(BuildContext context, ref) {
    return MouseRegion(
      onEnter: (event) {
        ref.read(_isMouseOverMapBigButton.notifier).state = true;
      },
      onExit: (event) {
        ref.read(_isMouseOverMapBigButton.notifier).state = false;
      },
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  width: 600,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                GoRouter.of(context).pop();
                              },
                              icon: const Icon(Icons.arrow_back_ios),
                            ),
                            const Text('Selecionar localização do evento'),
                          ],
                        ),
                        SizedBox(
                          width: 500,
                          child: TextFormField(
                            controller: viewmodel.searchInputController,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                onPressed: () async {
                                  notifier.findPlaceFromInput();
                                },
                                icon: const Icon(Icons.search),
                              ),
                              labelText: 'Pesquisar localização',
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: SizedBox(
                            width: 500,
                            height: 500,
                            child: GoogleMap(
                              onTap: (argument) {
                                notifier.createNewMarkerInMap(
                                  argument,
                                );
                                GoRouter.of(context).pop();
                              },
                              markers: viewmodel.googleMapMarker,
                              onMapCreated: (controller) {
                                notifier.setMapController(controller);
                              },
                              initialCameraPosition: const CameraPosition(
                                zoom: 15,
                                target: LatLng(
                                  -20.815353910716716,
                                  -49.38264553344107,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: Container(
          height: 150,
          width: 600,
          decoration: BoxDecoration(
            color: ref.watch(_isMouseOverMapBigButton)
                ? Colors.grey[400]
                : Colors.grey[300],
            borderRadius: BorderRadius.circular(24),
          ),
          child: Center(
            child: Text(
              'Local do evento',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: ref.watch(_isMouseOverMapBigButton)
                    ? Colors.blueGrey[100]
                    : Colors.blueGrey[200],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ListOfActivitiesWidget extends ConsumerWidget {
  final List<int> days;
  final List<int> months;
  final List<int> years;
  final List<int> hours;
  final List<int> minutes;
  final String? id;
  const ListOfActivitiesWidget({
    super.key,
    required this.viewmodel,
    required this.days,
    required this.months,
    required this.years,
    required this.hours,
    required this.minutes,
    required this.id,
  });

  final CreateEventViewmodel viewmodel;

  @override
  Widget build(BuildContext context, ref) {
    var notifier = ref.read(createEventViewmodelProvider(id).notifier);
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: Consumer(
                builder: (context, ref, child) {
                  var viewmodel = ref.watch(createEventViewmodelProvider(id));
                  var notifier =
                      ref.read(createEventViewmodelProvider(id).notifier);

                  return StatefulBuilder(
                    builder: (context, setState) {
                      return Container(
                        padding: const EdgeInsets.all(8),
                        width: 600,
                        height: 320,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller:
                                        viewmodel.activityNameController,
                                    decoration: const InputDecoration(
                                      labelText: 'Nome da atividade',
                                      // suffixIcon: TextButton(
                                      //   onPressed: () {},
                                      //   child: Text('Adicionar'),
                                      // ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text('Hora de inicio: '),
                                DropDownDatePickerWidget(
                                  intList: days,
                                  type: 'activity-day',
                                  initialValue: viewmodel.activityStartDay,
                                  id: id,
                                ),
                                const Text('/'),
                                DropDownDatePickerWidget(
                                  intList: months,
                                  type: 'activity-month',
                                  initialValue: viewmodel.activityStartMonth,
                                  id: id,
                                ),
                                const Text('/'),
                                DropDownDatePickerWidget(
                                  intList: years,
                                  type: 'activity-year',
                                  initialValue: viewmodel.activityStartYear,
                                  id: id,
                                ),
                                const Text(' : '),
                                DropDownDatePickerWidget(
                                  intList: hours,
                                  type: 'activity-hour',
                                  initialValue: viewmodel.activityStartHour,
                                  id: id,
                                ),
                                const Text(':'),
                                DropDownDatePickerWidget(
                                  intList: minutes,
                                  type: 'activity-minute',
                                  initialValue: viewmodel.activityStartMinute,
                                  id: id,
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                                if (viewmodel
                                    .activityNameController.text.isNotEmpty) {
                                  var a = Activity(
                                    name: viewmodel.activityNameController.text,
                                    start: DateTime.utc(
                                      viewmodel.activityStartYear,
                                      viewmodel.activityStartMonth,
                                      viewmodel.activityStartDay,
                                      viewmodel.activityStartHour,
                                      viewmodel.activityStartMinute,
                                    ),
                                  );
                                  notifier.addNewActivity(a);
                                  viewmodel.activityNameController.clear();
                                }
                              },
                              child: const Text('Adicionar'),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(
                                    12,
                                  ),
                                ),
                                child: ListView.builder(
                                  itemCount:
                                      viewmodel.listOfEventActivities.length,
                                  itemBuilder: (context, index) {
                                    var activity =
                                        viewmodel.listOfEventActivities[index];
                                    return Card(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(activity.name),
                                          ),
                                          Expanded(
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.calendar_month,
                                                ),
                                                Text(
                                                  '${_formatDate(activity.start)}',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: TextButton(
                                              onPressed: () {
                                                notifier
                                                    .removeActivity(activity);
                                              },
                                              child: const Text(
                                                'Remover',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            );
          },
        );
      },
      child: Container(
        width: 600,
        height: 400,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: Row(
                children: [
                  Expanded(child: Text('Nome')),
                  Expanded(child: Text('Horario')),
                  Spacer()
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: viewmodel.listOfEventActivities.length,
                itemBuilder: (context, index) {
                  var activity = viewmodel.listOfEventActivities[index];
                  return Card(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(activity.name),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(
                                Icons.calendar_month,
                              ),
                              Text(
                                '${_formatDate(activity.start)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              notifier.removeActivity(activity);
                            },
                            child: const Text(
                              'Remover',
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmptyEventActivitiesWidget extends ConsumerWidget {
  const EmptyEventActivitiesWidget({
    super.key,
    required List<int> days,
    required List<int> months,
    required List<int> years,
    required List<int> hours,
    required List<int> minutes,
    required this.id,
  })  : days = days,
        months = months,
        years = years,
        hours = hours,
        minutes = minutes;

  final List<int> days;
  final List<int> months;
  final List<int> years;
  final List<int> hours;
  final List<int> minutes;
  final String? id;

  @override
  Widget build(BuildContext context, ref) {
    return MouseRegion(
      onEnter: (event) {
        ref.read(_isMouseOverScheduleBigButton.notifier).state = true;
      },
      onExit: (event) {
        ref.read(_isMouseOverScheduleBigButton.notifier).state = false;
      },
      cursor: SystemMouseCursors.copy,
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: Consumer(
                  builder: (context, ref, child) {
                    var viewmodel = ref.watch(createEventViewmodelProvider(id));
                    var notifier =
                        ref.read(createEventViewmodelProvider(id).notifier);

                    return StatefulBuilder(
                      builder: (context, setState) {
                        return Container(
                          padding: const EdgeInsets.all(8),
                          width: 600,
                          height: 320,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller:
                                          viewmodel.activityNameController,
                                      decoration: const InputDecoration(
                                        labelText: 'Nome da atividade',
                                        // suffixIcon: TextButton(
                                        //   onPressed: () {},
                                        //   child: Text('Adicionar'),
                                        // ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text('Hora de inicio: '),
                                  DropDownDatePickerWidget(
                                    intList: days,
                                    type: 'activity-day',
                                    initialValue: viewmodel.activityStartDay,
                                    id: id,
                                  ),
                                  const Text('/'),
                                  DropDownDatePickerWidget(
                                    intList: months,
                                    type: 'activity-month',
                                    initialValue: viewmodel.activityStartMonth,
                                    id: id,
                                  ),
                                  const Text('/'),
                                  DropDownDatePickerWidget(
                                    intList: years,
                                    type: 'activity-year',
                                    initialValue: viewmodel.activityStartYear,
                                    id: id,
                                  ),
                                  const Text(' : '),
                                  DropDownDatePickerWidget(
                                    intList: hours,
                                    type: 'activity-hour',
                                    initialValue: viewmodel.activityStartHour,
                                    id: id,
                                  ),
                                  const Text(':'),
                                  DropDownDatePickerWidget(
                                    intList: minutes,
                                    type: 'activity-minute',
                                    initialValue: viewmodel.activityStartMinute,
                                    id: id,
                                  ),
                                ],
                              ),
                              TextButton(
                                onPressed: () {
                                  if (viewmodel
                                      .activityNameController.text.isNotEmpty) {
                                    var a = Activity(
                                      name:
                                          viewmodel.activityNameController.text,
                                      start: DateTime.utc(
                                        viewmodel.activityStartYear,
                                        viewmodel.activityStartMonth,
                                        viewmodel.activityStartDay,
                                        viewmodel.activityStartHour,
                                        viewmodel.activityStartMinute,
                                      ),
                                    );
                                    notifier.addNewActivity(a);
                                    viewmodel.activityNameController.clear();
                                  }
                                },
                                child: const Text('Adicionar'),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(
                                      12,
                                    ),
                                  ),
                                  child: ListView.builder(
                                    itemCount:
                                        viewmodel.listOfEventActivities.length,
                                    itemBuilder: (context, index) {
                                      var activity = viewmodel
                                          .listOfEventActivities[index];
                                      return Card(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(activity.name),
                                            ),
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.calendar_month,
                                                  ),
                                                  Text(
                                                    '${_formatDate(activity.start)}',
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: TextButton(
                                                onPressed: () {
                                                  notifier
                                                      .removeActivity(activity);
                                                },
                                                child: const Text(
                                                  'Remover',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            },
          );
        },
        child: Container(
          width: 600,
          height: 400,
          decoration: BoxDecoration(
            color: ref.watch(_isMouseOverScheduleBigButton)
                ? Colors.grey[400]
                : Colors.grey[300],
            borderRadius: BorderRadius.circular(24),
          ),
          child: Center(
            child: Text(
              'Cronograma do evento',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: ref.watch(_isMouseOverScheduleBigButton)
                    ? Colors.blueGrey[100]
                    : Colors.blueGrey[200],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonsGridWidget extends StatelessWidget {
  const ButtonsGridWidget({
    super.key,
    required this.viewmodel,
    required List<int> days,
    required List<int> months,
    required List<int> years,
    required List<int> hours,
    required List<int> minutes,
    required this.id,
  })  : days = days,
        months = months,
        years = years,
        hours = hours,
        minutes = minutes;

  final CreateEventViewmodel viewmodel;
  final List<int> days;
  final List<int> months;
  final List<int> years;
  final List<int> hours;
  final List<int> minutes;
  final String? id;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      height: 100,
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          mainAxisExtent: 30,
        ),
        children: [
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: Consumer(
                      builder: (context, ref, child) {
                        return Container(
                          padding: const EdgeInsets.all(8),
                          height: 200,
                          width: 400,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      GoRouter.of(context).pop();
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back_ios,
                                    ),
                                  ),
                                  const Text(
                                    'Selecionar data e hora',
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    DropDownDatePickerWidget(
                                      intList: days,
                                      type: 'day',
                                      initialValue: viewmodel.selectedDay,
                                      id: id,
                                    ),
                                    const Text('/'),
                                    DropDownDatePickerWidget(
                                      intList: months,
                                      type: 'month',
                                      initialValue: viewmodel.selectedMonth,
                                      id: id,
                                    ),
                                    const Text('/'),
                                    DropDownDatePickerWidget(
                                      intList: years,
                                      type: 'year',
                                      initialValue: viewmodel.selectedYear,
                                      id: id,
                                    ),
                                    const Text(' : '),
                                    DropDownDatePickerWidget(
                                      intList: hours,
                                      type: 'hour',
                                      initialValue: viewmodel.selectedHour,
                                      id: id,
                                    ),
                                    const Text(':'),
                                    DropDownDatePickerWidget(
                                      intList: minutes,
                                      type: 'minute',
                                      initialValue: viewmodel.selectedMinute,
                                      id: id,
                                    ),
                                  ],
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
            child: const Text('Selecionar data e hora'),
          ),
        ],
      ),
    );
  }
}

class ShowSelectedLocalizationWidget extends StatelessWidget {
  const ShowSelectedLocalizationWidget({
    super.key,
    required this.viewmodel,
    required this.notifier,
  });

  final CreateEventViewmodel viewmodel;
  final CreateEventViewmodelNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Stack(
        children: [
          SizedBox(
            height: 150,
            width: 600,
            child: GoogleMap(
              markers: viewmodel.googleMapMarker,
              initialCameraPosition: const CameraPosition(
                zoom: 9,
                target: LatLng(
                  -20.815353910716716,
                  -49.38264553344107,
                ),
              ),
            ),
          ),
          Positioned(
            top: 5,
            left: 5,
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        width: 600,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    GoRouter.of(context).pop();
                                  },
                                  icon: const Icon(Icons.arrow_back_ios),
                                ),
                                const Text('Selecionar localização do evento'),
                              ],
                            ),
                            SizedBox(
                              width: 500,
                              child: TextFormField(
                                controller: viewmodel.searchInputController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  suffixIcon: IconButton(
                                    onPressed: () async {
                                      notifier.findPlaceFromInput();
                                    },
                                    icon: const Icon(Icons.search),
                                  ),
                                  labelText: 'Pesquisar localização',
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: SizedBox(
                                width: 500,
                                height: 500,
                                child: GoogleMap(
                                  onTap: (argument) {
                                    notifier.createNewMarkerInMap(
                                      argument,
                                    );
                                    GoRouter.of(context).pop();
                                  },
                                  markers: viewmodel.googleMapMarker,
                                  onMapCreated: (controller) {
                                    notifier.setMapController(controller);
                                  },
                                  initialCameraPosition: const CameraPosition(
                                    zoom: 15,
                                    target: LatLng(
                                      -20.815353910716716,
                                      -49.38264553344107,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                height: 20,
                width: 160,
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Center(
                  child: Text(
                    'Alterar localização',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DropDownDatePickerWidget extends ConsumerWidget {
  final List<int> intList;
  final String type;
  final int initialValue;
  final String? id;

  const DropDownDatePickerWidget({
    Key? key,
    required this.intList,
    required this.type,
    required this.initialValue,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var notifier = ref.read(createEventViewmodelProvider(id).notifier);
    var selectedValue = _getSelectedValue(type, ref);

    return DropdownButton<int>(
      value: selectedValue,
      onChanged: (int? newValue) {
        if (newValue != null) {
          _updateValue(newValue, type, notifier);
        }
      },
      items: intList.map<DropdownMenuItem<int>>((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text('$value'),
        );
      }).toList(),
    );
  }

  int _getSelectedValue(String type, WidgetRef ref) {
    var viewmodel = ref.watch(createEventViewmodelProvider(id));
    switch (type) {
      case 'day':
        return viewmodel.selectedDay;
      case 'month':
        return viewmodel.selectedMonth;
      case 'year':
        return viewmodel.selectedYear;
      case 'hour':
        return viewmodel.selectedHour;
      case 'minute':
        return viewmodel.selectedMinute;
      case 'activity-day':
        return viewmodel.activityStartDay;
      case 'activity-month':
        return viewmodel.activityStartMonth;
      case 'activity-year':
        return viewmodel.activityStartYear;
      case 'activity-hour':
        return viewmodel.activityStartHour;
      case 'activity-minute':
        return viewmodel.activityStartMinute;
      default:
        return initialValue; // Caso padrão
    }
  }

  void _updateValue(
      int newValue, String type, CreateEventViewmodelNotifier notifier) {
    print('updated $type to $newValue');

    switch (type) {
      case 'day':
        notifier.setStartTime(day: newValue);

        break;
      case 'month':
        notifier.setStartTime(month: newValue);

        break;
      case 'year':
        notifier.setStartTime(year: newValue);

        break;
      case 'hour':
        notifier.setStartTime(hour: newValue);

        break;
      case 'minute':
        notifier.setStartTime(minute: newValue);

        break;
      case 'activity-day':
        notifier.setActivityStartTime(day: newValue);

        break;
      case 'activity-month':
        notifier.setActivityStartTime(month: newValue);

        break;
      case 'activity-year':
        notifier.setActivityStartTime(year: newValue);

        break;
      case 'activity-hour':
        notifier.setActivityStartTime(hour: newValue);

        break;
      case 'activity-minute':
        notifier.setActivityStartTime(minute: newValue);

        break;
    }
  }
}

class HeaderInfoRowWidget extends StatelessWidget {
  final String text;
  final String placeholderText;
  final IconData icons;
  final bool darkMode;
  final Color? darkModeColor;

  const HeaderInfoRowWidget({
    super.key,
    this.darkModeColor,
    required this.text,
    required this.icons,
    required this.placeholderText,
    required this.darkMode,
  });

  @override
  Widget build(BuildContext context) {
    // Define o valor padrão para darkModeColor como Colors.white se for null
    final effectiveDarkModeColor = darkModeColor ?? Colors.white;

    return Row(
      children: [
        Icon(
          icons,
          color: darkMode ? effectiveDarkModeColor : Colors.black,
        ),
        Flexible(
          child: Tooltip(
            message: text,
            child: Text(
              text.isEmpty ? placeholderText : text,
              style: TextStyle(
                color: darkMode ? effectiveDarkModeColor : Colors.black,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

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
