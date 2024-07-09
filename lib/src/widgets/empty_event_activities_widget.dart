import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howapp_panel/src/model/activity.dart';
import 'package:howapp_panel/src/view/create_event_view.dart';
import 'package:howapp_panel/src/viewmodel/create_event_viewmodel.dart';
import 'package:howapp_panel/src/widgets/drop_down_date_picker_widget.dart';

final _isMouseOverScheduleBigButton = StateProvider<bool>((ref) {
  return false;
});

class EmptyEventActivitiesWidget extends ConsumerWidget {
  const EmptyEventActivitiesWidget({
    super.key,
    required List<int> days,
    required List<int> months,
    required List<int> years,
    required List<int> hours,
    required List<int> minutes,
    required this.id,
    required this.isExperience,
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
  final bool isExperience;

  @override
  Widget build(BuildContext context, ref) {
    var params =
        CreateEventViewmodelParams(eventId: id, isExperience: isExperience);
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
                    var viewmodel =
                        ref.watch(createEventViewmodelProvider(params));
                    var notifier =
                        ref.read(createEventViewmodelProvider(params).notifier);

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
                                    isExperience: isExperience,
                                  ),
                                  const Text('/'),
                                  DropDownDatePickerWidget(
                                    intList: months,
                                    type: 'activity-month',
                                    initialValue: viewmodel.activityStartMonth,
                                    id: id,
                                    isExperience: isExperience,
                                  ),
                                  const Text('/'),
                                  DropDownDatePickerWidget(
                                    intList: years,
                                    type: 'activity-year',
                                    initialValue: viewmodel.activityStartYear,
                                    id: id,
                                    isExperience: isExperience,
                                  ),
                                  const Text(' : '),
                                  DropDownDatePickerWidget(
                                    intList: hours,
                                    type: 'activity-hour',
                                    initialValue: viewmodel.activityStartHour,
                                    id: id,
                                    isExperience: isExperience,
                                  ),
                                  const Text(':'),
                                  DropDownDatePickerWidget(
                                    intList: minutes,
                                    type: 'activity-minute',
                                    initialValue: viewmodel.activityStartMinute,
                                    id: id,
                                    isExperience: isExperience,
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
                                                    '${formatDate(activity.start)}',
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
