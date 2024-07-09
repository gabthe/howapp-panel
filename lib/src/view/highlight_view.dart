import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:howapp_panel/src/model/event.dart';
import 'package:howapp_panel/src/utils/api_state.dart';
import 'package:howapp_panel/src/viewmodel/highlight_viewmodel.dart';

class HighlightView extends ConsumerWidget {
  final bool isExperience;
  const HighlightView({super.key, required this.isExperience});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var viewmodel = ref.watch(highlightsViewmodelProvider(isExperience));
    var notifier = ref.read(highlightsViewmodelProvider(isExperience).notifier);
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(24),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        const Text(
                          'Eventos em destaque',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        if (viewmodel.fetchingEvents == ApiState.pending)
                          const Center(
                            child: CircularProgressIndicator(),
                          ),
                        if (viewmodel.fetchingEvents != ApiState.pending)
                          Expanded(
                            child: ListView.builder(
                              itemCount: 33,
                              itemBuilder: (context, index) {
                                Event? event =
                                    viewmodel.highlightedEvents[index];
                                if (event != null) {
                                  return Expanded(
                                    child: EventHighlightCard(
                                      event: event,
                                      index: index,
                                      isInHighlightOrder: true,
                                      isExperience: isExperience,
                                    ),
                                  );
                                }

                                return Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  padding: const EdgeInsets.all(8),
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey[100],
                                    borderRadius: BorderRadius.circular(
                                      12,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Text('#${index + 1} '),
                                      const Spacer(),
                                      if (event == null)
                                        TextButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Dialog(
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16),
                                                    width: 900,
                                                    height: 600,
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            IconButton(
                                                              onPressed: () {
                                                                GoRouter.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              icon: const Icon(
                                                                Icons
                                                                    .arrow_back_ios,
                                                              ),
                                                            ),
                                                            const Text(
                                                                'Todos eventos'),
                                                          ],
                                                        ),
                                                        if (viewmodel
                                                                .fetchingEvents ==
                                                            ApiState.pending)
                                                          const Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          ),
                                                        if (viewmodel
                                                                .fetchingEvents !=
                                                            ApiState.pending)
                                                          Expanded(
                                                            child: ListView
                                                                .builder(
                                                              itemCount: viewmodel
                                                                  .commomEvents
                                                                  .length,
                                                              itemBuilder: (context,
                                                                  internIndex) {
                                                                var event = viewmodel
                                                                        .commomEvents[
                                                                    internIndex];
                                                                return Expanded(
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      notifier
                                                                          .updateEventHighlight(
                                                                        event
                                                                            .id,
                                                                        index,
                                                                      );
                                                                      GoRouter.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                    child:
                                                                        EventHighlightCard(
                                                                      event:
                                                                          event,
                                                                      index:
                                                                          index,
                                                                      isExperience:
                                                                          isExperience,
                                                                      isInHighlightOrder:
                                                                          false,
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child:
                                              const Text('Selecionar destaque'),
                                        ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(24),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        const Text(
                          'Todos os eventos',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        if (viewmodel.fetchingEvents == ApiState.pending)
                          const Center(
                            child: CircularProgressIndicator(),
                          ),
                        if (viewmodel.fetchingEvents != ApiState.pending)
                          Expanded(
                            child: ListView.builder(
                              itemCount: viewmodel.events.length,
                              itemBuilder: (context, index) {
                                var event = viewmodel.events[index];
                                return Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      GoRouter.of(context).goNamed(
                                        'create-event',
                                        extra: {
                                          'id': event.id,
                                          'isExperience': event.isExperience,
                                        },
                                      );
                                    },
                                    child: EventHighlightCard(
                                      event: event,
                                      index: index,
                                      isInHighlightOrder: false,
                                      isExperience: isExperience,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventHighlightCard extends ConsumerWidget {
  const EventHighlightCard({
    super.key,
    required this.event,
    required this.index,
    required this.isInHighlightOrder,
    required this.isExperience,
  });

  final Event event;
  final int index;
  final bool isInHighlightOrder;
  final bool isExperience;

  @override
  Widget build(BuildContext context, ref) {
    var notifier = ref.read(highlightsViewmodelProvider(isExperience).notifier);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Stack(
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: SizedBox(
                width: 800,
                height: 120,
                child: Image.network(
                  event.cardImageUrl,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 12,
                  ),
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                      event.photoUrl,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isInHighlightOrder)
                        Text(
                          '#${index + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      Text(
                        '${event.name}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${event.creatorName}',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                ],
              ),
            ),
          ),
          if (isInHighlightOrder)
            Positioned(
              bottom: 10,
              right: 10,
              child: ElevatedButton(
                onPressed: () {
                  notifier.removeEventHighlight(event.id);
                },
                child: const Text('Remover destaque'),
              ),
            ),
        ],
      ),
    );
  }
}
