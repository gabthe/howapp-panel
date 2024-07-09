import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:howapp_panel/src/utils/show_snackbar.dart';
import 'package:howapp_panel/src/widgets/empty_event_activities_widget.dart';
import 'package:howapp_panel/src/widgets/empty_localization_widget.dart';
import 'package:howapp_panel/src/widgets/event_creation_helper_widget.dart';
import 'package:howapp_panel/src/widgets/event_creator_widget.dart';
import 'package:howapp_panel/src/widgets/event_date_widget.dart';
import 'package:howapp_panel/src/widgets/event_tags_big_button_widget.dart';
import 'package:howapp_panel/src/widgets/list_of_activities_widget.dart';
import 'package:howapp_panel/src/widgets/mediakit_button_widget.dart';
import 'package:howapp_panel/src/widgets/show_selected_localization_widget.dart';
import 'package:intl/intl.dart';

import 'package:howapp_panel/src/utils/api_state.dart';
import 'package:howapp_panel/src/viewmodel/create_event_viewmodel.dart';
import 'package:howapp_panel/src/widgets/event_infos_widget.dart';

formatDate(DateTime date) {
  String formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(date);
  return formattedDate;
}

class CreateEventView extends ConsumerWidget {
  final String? id;
  final bool isExperience;
  const CreateEventView({
    super.key,
    required this.id,
    required this.isExperience,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var params = CreateEventViewmodelParams(
      eventId: id,
      isExperience: isExperience,
    );
    var viewmodel = ref.watch(createEventViewmodelProvider(params));
    var notifier = ref.read(createEventViewmodelProvider(params).notifier);
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
        title: Text(
          id == null
              ? 'Criar ${isExperience ? 'experiencia' : 'evento'}'
              : 'Editar ${isExperience ? 'experiencia' : 'evento'}',
        ),
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
                        id: id,
                        isExperience: isExperience,
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
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(24),
                        ),
                        width: 600,
                        child: ListTile(
                          selected: viewmodel.hasHowStore,
                          title: const Text('Experiencia'),
                          trailing: Switch(
                            value: isExperience,
                            onChanged: (bool value) {
                              // notifier.toggleHasHowStore();
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
                        isExperience: isExperience,
                      ),
                      const SizedBox(height: 12),
                      if (viewmodel.selectedLocalization == null)
                        EmptyLocalizationWidget(
                          id: id,
                          isExperience: isExperience,
                        ),
                      if (viewmodel.selectedLocalization != null)
                        ShowSelectedLocalizationWidget(
                          id: id,
                          isExperience: isExperience,
                        ),
                      const SizedBox(height: 12),
                      EventCreatorWidget(
                        id: id,
                        isExperience: isExperience,
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
                        id: id,
                        isExperience: isExperience,
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
                          isExperience: isExperience,
                        ),
                      if (viewmodel.listOfEventActivities.isNotEmpty)
                        ListOfActivitiesWidget(
                          id: id,
                          isExperience: isExperience,
                          days: days,
                          months: months,
                          years: years,
                          hours: hours,
                          minutes: minutes,
                        ),
                      const SizedBox(height: 12),
                      MediaKitButtonWidget(
                        id: id,
                        isExperience: isExperience,
                      ),
                      const SizedBox(height: 12),
                      if (viewmodel.creatingEventInFirestore !=
                          ApiState.pending)
                        SizedBox(
                          width: 600,
                          height: 40,
                          child: ElevatedButton(
                            child: Text(
                              isExperience
                                  ? 'Criar experiencia'
                                  : 'Criar evento',
                            ),
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
            child: EventCreationHelperWidget(
              id: id,
              isExperience: isExperience,
            ),
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
