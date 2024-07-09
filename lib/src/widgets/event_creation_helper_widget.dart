import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howapp_panel/src/viewmodel/create_event_viewmodel.dart';

class EventCreationHelperWidget extends ConsumerWidget {
  final String? id;
  final bool isExperience;
  const EventCreationHelperWidget({
    super.key,
    required this.id,
    required this.isExperience,
  });

  @override
  Widget build(BuildContext context, ref) {
    var viewmodel = ref.watch(
      createEventViewmodelProvider(
        CreateEventViewmodelParams(eventId: id, isExperience: isExperience),
      ),
    );
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
