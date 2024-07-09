import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howapp_panel/src/utils/get_16x9_proportion.dart';
import 'package:howapp_panel/src/viewmodel/create_event_viewmodel.dart';
import 'package:howapp_panel/src/widgets/select_commercial_profile_dialog_widget.dart';

final _isMouseOverEventCreatorBigButton = StateProvider<bool>((ref) {
  return false;
});

class EventCreatorWidget extends ConsumerWidget {
  const EventCreatorWidget({
    super.key,
    required this.id,
    required this.isExperience,
  });

  final String? id;
  final bool isExperience;

  @override
  Widget build(BuildContext context, ref) {
    var params =
        CreateEventViewmodelParams(eventId: id, isExperience: isExperience);
    var viewmodel = ref.watch(createEventViewmodelProvider(params));
    return MouseRegion(
      onEnter: (event) {
        ref.read(_isMouseOverEventCreatorBigButton.notifier).state = true;
      },
      onExit: (event) {
        ref.read(_isMouseOverEventCreatorBigButton.notifier).state = false;
      },
      child: InkWell(
        onTap: () {
          showDialog<void>(
            context: context,
            barrierDismissible: true, // user must tap button for close dialog!
            builder: (BuildContext context) {
              return SelectComercialProfileDialog(
                isExperience: isExperience,
              );
            },
          );
        },
        child: SizedBox(
          height: viewmodel.selectedEventCreator == null
              ? getProportion(600)
              : getProportion(600) + 40,
          child: Stack(
            children: [
              Container(
                width: 600,
                height: getProportion(600),
                decoration: BoxDecoration(
                  color: ref.watch(_isMouseOverEventCreatorBigButton)
                      ? Colors.grey[400]
                      : Colors.grey[300],
                  borderRadius: BorderRadius.circular(24),
                ),
                child: viewmodel.selectedEventCreator != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Image.network(
                          viewmodel.selectedEventCreator!.bannerPictureUrl,
                          fit: BoxFit.contain,
                        ),
                      )
                    : Center(
                        child: Text(
                          'Criador do evento',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ref.watch(_isMouseOverEventCreatorBigButton)
                                ? Colors.blueGrey[100]
                                : Colors.blueGrey[200],
                          ),
                        ),
                      ),
              ),
              if (viewmodel.selectedEventCreator != null)
                Positioned(
                  bottom: 0,
                  left: 10,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                          viewmodel.selectedEventCreator!.profilePictureUrl,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        color: Colors.black54,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              viewmodel.selectedEventCreator!.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              viewmodel.selectedEventCreator!.username,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
