// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:howapp_panel/src/model/commercial_profile.dart';
import 'package:howapp_panel/src/model/event_tag.dart';

class CreateEventViewmodel {
  TextEditingController eventNameController;
  List<EventTag> eventTags;
  List<EventTag> selectedEventTags;
  ComercialProfile? selectedEventCreator;
  List<ComercialProfile> eventCreators;
  CreateEventViewmodel({
    required this.eventNameController,
    required this.eventTags,
    required this.selectedEventTags,
    this.selectedEventCreator,
    required this.eventCreators,
  });

  CreateEventViewmodel copyWith({
    TextEditingController? eventNameController,
    List<EventTag>? eventTags,
    List<EventTag>? selectedEventTags,
    ComercialProfile? selectedEventCreator,
    List<ComercialProfile>? eventCreators,
  }) {
    return CreateEventViewmodel(
      eventNameController: eventNameController ?? this.eventNameController,
      eventTags: eventTags ?? this.eventTags,
      selectedEventTags: selectedEventTags ?? this.selectedEventTags,
      selectedEventCreator: selectedEventCreator ?? this.selectedEventCreator,
      eventCreators: eventCreators ?? this.eventCreators,
    );
  }
}

class CreateEventViewmodelNotifier extends StateNotifier<CreateEventViewmodel> {
  CreateEventViewmodelNotifier()
      : super(
          CreateEventViewmodel(
            eventCreators: [],
            eventNameController: TextEditingController(),
            eventTags: [],
            selectedEventTags: [],
          ),
        ) {
    init();
  }
  init() async {
    try {} catch (e, st) {
      log('create_event_viewmodel', error: e, stackTrace: st);
    }
  }
}
