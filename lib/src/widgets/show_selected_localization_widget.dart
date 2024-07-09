import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:howapp_panel/src/viewmodel/create_event_viewmodel.dart';

class ShowSelectedLocalizationWidget extends ConsumerWidget {
  const ShowSelectedLocalizationWidget({
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Stack(
        children: [
          SizedBox(
            height: 150,
            width: 600,
            child: GoogleMap(
              markers: viewmodel.googleMapMarker,
              initialCameraPosition: const CameraPosition(
                zoom: 9,
                target: LatLng(
                  -20.815353910716716,
                  -49.38264553344107,
                ),
              ),
            ),
          ),
          Positioned(
            top: 5,
            left: 5,
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        width: 600,
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
                    );
                  },
                );
              },
              child: Container(
                height: 20,
                width: 160,
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Center(
                  child: Text(
                    'Alterar localização',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
