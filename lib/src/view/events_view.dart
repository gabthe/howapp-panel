import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:howapp_panel/src/utils/get_16x9_proportion.dart';
import 'package:howapp_panel/src/viewmodel/events_viewmodel.dart';

class EventsView extends ConsumerWidget {
  const EventsView({
    super.key,
    required this.isExperience,
  });
  final bool isExperience;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var viewmodel = ref.watch(eventsViewmodelProvider(isExperience));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eventos'),
      ),
      body: Column(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                mainAxisExtent: getProportion(500) + 40,
              ),
              children: viewmodel.events.map(
                (event) {
                  return Center(
                    child: Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            GoRouter.of(context).goNamed(
                              'create-event',
                              extra: {
                                'id': event.id,
                                'isExperience': event.isExperience,
                              },
                            );
                          },
                          child: SizedBox(
                            height: getProportion(500) + 40,
                            width: 500,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: SizedBox(
                                height: getProportion(500),
                                width: 500,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network(event.bannerUrl),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 15,
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 35,
                                  backgroundImage: NetworkImage(event.photoUrl),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      event.name,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      event.creatorName,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ).toList(),
            ),
          )
              //  ListView.builder(
              //   itemCount: viewmodel.events.length,
              //   itemBuilder: (context, index) {
              //     var event = viewmodel.events[index];
              //     return Center(
              //       child: Container(
              //         color: Colors.grey,
              //         width: 400,
              //         height: getProportion(400),
              //         child: Text(event.name),
              //       ),
              //     );
              //   },
              // ),
              ),
          // Expanded(
          //   child: ReorderableListView(
          //     onReorder: (int oldIndex, int newIndex) {
          //       print('$oldIndex $newIndex');
          //       notifier.reorderEvents(oldIndex: oldIndex, newIndex: newIndex);
          //     },
          //     children: [
          //       for (final item in viewmodel.events)
          //         ListTile(
          //           key: ValueKey(item),
          //           title: Text(item.name),
          //           trailing: const Icon(Icons.drag_handle),
          //         ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
