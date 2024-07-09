// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howapp_panel/src/model/event.dart';
import 'package:howapp_panel/src/repository/event_repo.dart';

class EventsViewmodel {
  List<Event> events;
  EventsViewmodel({
    required this.events,
  });

  EventsViewmodel copyWith({
    List<Event>? events,
  }) {
    return EventsViewmodel(
      events: events ?? this.events,
    );
  }
}

class EventsViewmodelNotifier extends StateNotifier<EventsViewmodel> {
  EventRepo eventRepo;
  bool isExperience;
  EventsViewmodelNotifier({
    required this.eventRepo,
    required this.isExperience,
  }) : super(
          EventsViewmodel(
            events: [],
          ),
        ) {
    init();
  }
  init() async {
    try {
      List<Event> allEvents =
          await eventRepo.fetchAllEvents(fetchExperiences: isExperience);
      state = state.copyWith(events: allEvents);
    } catch (e) {
      print(e);
    }
  }

  // reorderEvents({
  //   required int oldIndex,
  //   required int newIndex,
  // }) {
  //   if (newIndex > oldIndex) {
  //     newIndex -= 1;
  //   }
  //   final Event event = state.events.removeAt(oldIndex);
  //   state.events.insert(newIndex, event);
  //   state = state.copyWith();
  // }
}

final eventsViewmodelProvider = StateNotifierProvider.autoDispose
    .family<EventsViewmodelNotifier, EventsViewmodel, bool>(
        (ref, isExperience) {
  return EventsViewmodelNotifier(
    eventRepo: ref.watch(eventRepoProvider),
    isExperience: isExperience,
  );
});
