import 'package:go_router/go_router.dart';
import 'package:howapp_panel/src/view/create_event_view.dart';
import 'package:howapp_panel/src/view/create_tag.dart';
import 'package:howapp_panel/src/view/create_type_of_place.dart';
import 'package:howapp_panel/src/view/events_view.dart';
import 'package:howapp_panel/src/view/highlight_view.dart';
import 'package:howapp_panel/src/view/home_view.dart';

final routes = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      name: 'home',
      path: '/home',
      builder: (context, state) {
        return const HomePage();
      },
    ),
    GoRoute(
      name: 'create-event',
      path: '/create-event',
      builder: (context, state) {
        Map<String, dynamic> params = state.extra as Map<String, dynamic>;
        return CreateEventView(
          id: params['id'],
          isExperience: params['isExperience'],
        );
      },
    ),
    GoRoute(
      name: 'events',
      path: '/events',
      builder: (context, state) {
        bool isExperience = state.extra as bool;
        return EventsView(isExperience: isExperience);
      },
    ),
    GoRoute(
      name: 'highlight',
      path: '/highlight',
      builder: (context, state) {
        bool isExperience = state.extra as bool;
        return HighlightView(isExperience: isExperience);
      },
    ),
    GoRoute(
      name: 'create-tag',
      path: '/create-tag',
      builder: (context, state) {
        return const CreateTagView();
      },
    ),
    GoRoute(
      name: 'create-type-of-place',
      path: '/create-type-of-place',
      builder: (context, state) {
        return const CreateTypeOfPlace();
      },
    ),
  ],
);
