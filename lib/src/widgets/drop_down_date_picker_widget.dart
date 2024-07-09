import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howapp_panel/src/viewmodel/create_event_viewmodel.dart';

class DropDownDatePickerWidget extends ConsumerWidget {
  final List<int> intList;
  final String type;
  final int initialValue;
  final String? id;
  final bool isExperience;

  const DropDownDatePickerWidget({
    Key? key,
    required this.intList,
    required this.type,
    required this.initialValue,
    required this.id,
    required this.isExperience,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var params =
        CreateEventViewmodelParams(eventId: id, isExperience: isExperience);
    var notifier = ref.read(createEventViewmodelProvider(params).notifier);
    var selectedValue = _getSelectedValue(type, ref, params);

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

  int _getSelectedValue(
    String type,
    WidgetRef ref,
    CreateEventViewmodelParams params,
  ) {
    var viewmodel = ref.watch(createEventViewmodelProvider(params));
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
