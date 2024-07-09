import 'package:flutter/material.dart';
import 'package:howapp_panel/src/viewmodel/create_event_viewmodel.dart';
import 'package:howapp_panel/src/widgets/drop_down_date_picker_widget.dart';

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
    required this.isExperience,
  });

  final List<int> days;
  final CreateEventViewmodel viewmodel;
  final List<int> months;
  final List<int> years;
  final List<int> hours;
  final List<int> minutes;
  final String? id;
  final bool isExperience;

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
                isExperience: isExperience,
              ),
              const Text('/'),
              DropDownDatePickerWidget(
                intList: months,
                type: 'month',
                initialValue: viewmodel.selectedMonth,
                id: id,
                isExperience: isExperience,
              ),
              const Text('/'),
              DropDownDatePickerWidget(
                intList: years,
                type: 'year',
                initialValue: viewmodel.selectedYear,
                id: id,
                isExperience: isExperience,
              ),
              const Text(' : '),
              DropDownDatePickerWidget(
                intList: hours,
                type: 'hour',
                initialValue: viewmodel.selectedHour,
                id: id,
                isExperience: isExperience,
              ),
              const Text(':'),
              DropDownDatePickerWidget(
                intList: minutes,
                type: 'minute',
                initialValue: viewmodel.selectedMinute,
                id: id,
                isExperience: isExperience,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
