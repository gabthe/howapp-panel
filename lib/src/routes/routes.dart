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
        String? id = state.extra as String?;
        return CreateEventView(
          id: id,
        );
      },
    ),
    GoRoute(
      name: 'events',
      path: '/events',
      builder: (context, state) {
        return const EventsView();
      },
    ),
    GoRoute(
      name: 'highlight',
      path: '/highlight',
      builder: (context, state) {
        return const HighlightView();
      },
    ),
    // PATH PARAM EXEMPLO
    //  GoRoute(
    //   name: 'create-event',
    //   path: '/create-event/:id',
    //   builder: (context, state) {
    //     return const CreateEventView();
    //   },
    // ),
    // COMO NAVEGAR
    //  GoRouter.of(context).goNamed(
    //               'create-event',
    //               pathParameters: {
    //                 'id': '123',
    //               },
    //             );
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
