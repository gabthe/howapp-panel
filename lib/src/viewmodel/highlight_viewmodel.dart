// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:howapp_panel/src/model/event.dart';
import 'package:howapp_panel/src/repository/event_repo.dart';
import 'package:howapp_panel/src/utils/api_state.dart';

class HighlightsViewmodel {
  ApiState fetchingEvents;
  List<Event> events;
  List<Event> commomEvents;
  List<Event?> highlightedEvents;
  HighlightsViewmodel({
    required this.fetchingEvents,
    required this.events,
    required this.commomEvents,
    required this.highlightedEvents,
  });

  HighlightsViewmodel copyWith({
    ApiState? fetchingEvents,
    List<Event>? events,
    List<Event>? commomEvents,
    List<Event?>? highlightedEvents,
  }) {
    return HighlightsViewmodel(
      fetchingEvents: fetchingEvents ?? this.fetchingEvents,
      events: events ?? this.events,
      commomEvents: commomEvents ?? this.commomEvents,
      highlightedEvents: highlightedEvents ?? this.highlightedEvents,
    );
  }
}

class HighlightsViewmodelNotifier extends StateNotifier<HighlightsViewmodel> {
  final EventRepo eventRepo;
  final bool isExperience;
  HighlightsViewmodelNotifier({
    required this.eventRepo,
    required this.isExperience,
  }) : super(
          HighlightsViewmodel(
            events: [],
            highlightedEvents: [],
            commomEvents: [],
            fetchingEvents: ApiState.idle,
          ),
        ) {
    init();
  }
  init() async {
    try {
      state = state.copyWith(fetchingEvents: ApiState.pending);
      await _updateEventsList();
      state = state.copyWith(fetchingEvents: ApiState.succeeded);
    } catch (e) {
      state = state.copyWith(fetchingEvents: ApiState.error);
      print(e);
    }
  }

  List<Event?> generateEventList(List<Event> events) {
    List<Event?> eventList = List.filled(33, null);

    for (var event in events) {
      if (event.highlightIndex != null && event.highlightIndex! < 33) {
        eventList[event.highlightIndex!] = event;
      }
    }

    return eventList;
  }

  updateEventHighlight(String id, int highlightIndex) async {
    try {
      await eventRepo.updateEventHighlight(id, highlightIndex);
      await _updateEventsList();
    } catch (e) {
      rethrow;
    }
  }

  removeEventHighlight(String id) async {
    try {
      await eventRepo.removeEventHighlight(id);
      await _updateEventsList();
    } catch (e) {
      rethrow;
    }
  }

  _updateEventsList() async {
    try {
      state = state.copyWith(fetchingEvents: ApiState.pending);

      List<Event> allEvents =
          await eventRepo.fetchAllEvents(fetchExperiences: isExperience);
      List<Event> allCommomEvents = await eventRepo
          .fetchAllNotHighlightedEvents(fetchExperiences: isExperience);
      var highlightedEvents = generateEventList(allEvents);
      state = state.copyWith(
        events: allEvents,
        commomEvents: allCommomEvents,
        highlightedEvents: highlightedEvents,
      );
      state = state.copyWith(fetchingEvents: ApiState.succeeded);
    } catch (e, st) {
      state = state.copyWith(fetchingEvents: ApiState.error);

      log('error', error: e, stackTrace: st);
    }
  }
}

final highlightsViewmodelProvider = StateNotifierProvider.autoDispose
    .family<HighlightsViewmodelNotifier, HighlightsViewmodel, bool>(
        (ref, isExperience) {
  return HighlightsViewmodelNotifier(
      eventRepo: ref.watch(eventRepoProvider), isExperience: isExperience);
});
