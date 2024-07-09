import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:howapp_panel/src/viewmodel/create_event_viewmodel.dart';

final _isMouseOverMapBigButton = StateProvider<bool>((ref) {
  return false;
});

class EmptyLocalizationWidget extends ConsumerWidget {
  const EmptyLocalizationWidget({
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
    var notifier = ref.read(createEventViewmodelProvider(params).notifier);
    return MouseRegion(
      onEnter: (event) {
        ref.read(_isMouseOverMapBigButton.notifier).state = true;
      },
      onExit: (event) {
        ref.read(_isMouseOverMapBigButton.notifier).state = false;
      },
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  width: 600,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                GoRouter.of(context).pop();
                              },
                              icon: const Icon(Icons.arrow_back_ios),
                            ),
                            const Text('Selecionar localização do evento'),
                          ],
                        ),
                        SizedBox(
                          width: 500,
                          child: TextFormField(
                            controller: viewmodel.searchInputController,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                onPressed: () async {
                                  notifier.findPlaceFromInput();
                                },
                                icon: const Icon(Icons.search),
                              ),
                              labelText: 'Pesquisar localização',
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: SizedBox(
                            width: 500,
                            height: 500,
                            child: GoogleMap(
                              onTap: (argument) {
                                notifier.createNewMarkerInMap(
                                  argument,
                                );
                                GoRouter.of(context).pop();
                              },
                              markers: viewmodel.googleMapMarker,
                              onMapCreated: (controller) {
                                notifier.setMapController(controller);
                              },
                              initialCameraPosition: const CameraPosition(
                                zoom: 15,
                                target: LatLng(
                                  -20.815353910716716,
                                  -49.38264553344107,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: Container(
          height: 150,
          width: 600,
          decoration: BoxDecoration(
            color: ref.watch(_isMouseOverMapBigButton)
                ? Colors.grey[400]
                : Colors.grey[300],
            borderRadius: BorderRadius.circular(24),
          ),
          child: Center(
            child: Text(
              'Local do evento',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: ref.watch(_isMouseOverMapBigButton)
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
