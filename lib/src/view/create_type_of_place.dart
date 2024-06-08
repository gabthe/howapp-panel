import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howapp_panel/src/model/commerce_type.dart';
import 'package:howapp_panel/src/repository/event_repo.dart';

final _textControllerProvider = StateProvider<TextEditingController>((ref) {
  return TextEditingController();
});

class CreateTypeOfPlace extends ConsumerWidget {
  const CreateTypeOfPlace({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Form(
        child: Column(
          children: [
            Center(
              child: SizedBox(
                width: 500,
                child: TextFormField(
                  controller: ref.watch(_textControllerProvider),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Tipo de estabelecimento',
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                ref.watch(eventRepoProvider).addTypeOfPlace(
                      commerceType: CommerceType(
                        commerceTypeName:
                            ref.watch(_textControllerProvider).text,
                      ),
                    );
              },
              child: const Text('Criar'),
            )
          ],
        ),
      ),
    );
  }
}
