import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:howapp_panel/src/model/event_tag.dart';
import 'package:howapp_panel/src/viewmodel/create_event_viewmodel.dart';

final _isMouseOverEventTagsBigButton = StateProvider<bool>((ref) {
  return false;
});

class EventTagsBigButtonWidget extends ConsumerWidget {
  final String? id;
  final bool isExperience;
  const EventTagsBigButtonWidget({
    super.key,
    required this.id,
    required this.isExperience,
  });

  @override
  Widget build(BuildContext context, ref) {
    var params =
        CreateEventViewmodelParams(eventId: id, isExperience: isExperience);
    var viewmodel = ref.watch(createEventViewmodelProvider(params));
    var notifier = ref.read(createEventViewmodelProvider(params).notifier);
    return MouseRegion(
      onEnter: (event) {
        ref.read(_isMouseOverEventTagsBigButton.notifier).state = true;
      },
      onExit: (event) {
        ref.read(_isMouseOverEventTagsBigButton.notifier).state = false;
      },
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return Consumer(builder: (context, ref, child) {
                var currentViewmodel =
                    ref.watch(createEventViewmodelProvider(params));
                var currentNotifier =
                    ref.read(createEventViewmodelProvider(params).notifier);
                return Dialog(
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      return Container(
                        padding: const EdgeInsets.all(8),
                        width: 300,
                        height: 600,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    GoRouter.of(context).pop();
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back_ios,
                                  ),
                                ),
                                const Text(
                                  'Selecionar tags do evento',
                                ),
                              ],
                            ),
                            Expanded(
                              flex: 2,
                              child: ListView.builder(
                                itemCount: currentViewmodel.allEventTags.length,
                                itemBuilder: (context, index) {
                                  EventTag eventTag =
                                      currentViewmodel.allEventTags[index];
                                  return Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: Row(
                                        children: [
                                          Text(
                                            eventTag.tagName,
                                          ),
                                          const Spacer(),
                                          TextButton(
                                            onPressed: () {
                                              // Atualize o estado do viewmodel
                                              currentNotifier.addNewTagToEvent(
                                                eventTag,
                                              );
                                            },
                                            child: const Text(
                                              'Adicionar',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const Text('Tags adicionadas'),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: ListView.builder(
                                  itemCount:
                                      currentViewmodel.selectedEventTags.length,
                                  itemBuilder: (context, index) {
                                    var selectedTag = currentViewmodel
                                        .selectedEventTags[index];
                                    return Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              selectedTag.tagName,
                                            ),
                                            const Spacer(),
                                            TextButton(
                                              onPressed: () {
                                                currentNotifier
                                                    .removeTagFromEvent(
                                                        selectedTag);
                                              },
                                              child: const Text('Remover'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              });
            },
          );
        },
        child: Container(
          width: 600,
          height: 150,
          decoration: BoxDecoration(
            color: ref.watch(_isMouseOverEventTagsBigButton)
                ? Colors.grey[400]
                : Colors.grey[300],
            borderRadius: BorderRadius.circular(24),
          ),
          child: viewmodel.selectedEventTags.isNotEmpty
              ? ListView.builder(
                  itemCount: viewmodel.selectedEventTags.length,
                  itemBuilder: (context, index) {
                    var selectedTag = viewmodel.selectedEventTags[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            Text(
                              selectedTag.tagName,
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                notifier.removeTagFromEvent(selectedTag);
                              },
                              child: const Text('Remover'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Text(
                    'Tags do evento',
                    style: TextStyle(
                      color: ref.watch(_isMouseOverEventTagsBigButton)
                          ? Colors.blueGrey[100]
                          : Colors.blueGrey[200],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
