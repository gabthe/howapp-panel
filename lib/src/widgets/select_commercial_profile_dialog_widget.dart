import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:howapp_panel/src/model/commercial_profile.dart';
import 'package:howapp_panel/src/utils/get_16x9_proportion.dart';
import 'package:howapp_panel/src/viewmodel/create_event_viewmodel.dart';

class SelectComercialProfileDialog extends ConsumerWidget {
  final bool isExperience;
  const SelectComercialProfileDialog({
    super.key,
    required this.isExperience,
  });

  @override
  Widget build(BuildContext context, ref) {
    var params =
        CreateEventViewmodelParams(eventId: null, isExperience: isExperience);
    var viewmodel = ref.watch(createEventViewmodelProvider(params));
    var notifier = ref.read(createEventViewmodelProvider(params).notifier);
    return AlertDialog(
      title: const Text('Lista de perfis comerciais'),
      content: SizedBox(
        width: 300,
        height: 500,
        child: ListView.builder(
          itemCount: viewmodel.allComercialProfileList.length,
          itemBuilder: (context, index) {
            CommercialProfile commercialProfile =
                viewmodel.allComercialProfileList[index];
            return MouseRegion(
              child: Container(
                width: 300,
                height: getProportion(300) + 50,
                color: Colors.grey[100],
                child: Stack(
                  children: [
                    Container(
                      width: 300,
                      height: getProportion(300),
                      color: Colors.grey[100],
                      child: Image.network(
                        commercialProfile.bannerPictureUrl,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(
                              commercialProfile.profilePictureUrl,
                            ),
                          ),
                          Container(
                            color: Colors.black45,
                            child: Column(
                              children: [
                                Text(
                                  commercialProfile.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  commercialProfile.username,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              notifier.setEventCreator(
                                commercialProfile,
                              );
                              GoRouter.of(context).pop();
                            },
                            child: const Text(
                              'Selecionar',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Voltar'),
          onPressed: () {
            GoRouter.of(context).pop();
          },
        ),
      ],
    );
  }
}
