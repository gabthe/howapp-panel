import 'package:go_router/go_router.dart';
import 'package:howapp_panel/src/view/create_event_view.dart';
import 'package:howapp_panel/src/view/create_tag.dart';
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
        return const CreateEventView();
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
  ],
);
