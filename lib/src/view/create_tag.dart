import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howapp_panel/src/model/event_tag.dart';
import 'package:howapp_panel/src/repository/event_repo.dart';

final _textControllerProvider = StateProvider<TextEditingController>((ref) {
  return TextEditingController();
});

class CreateTagView extends ConsumerWidget {
  const CreateTagView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          Form(
            child: Column(
              children: [
                Center(
                  child: SizedBox(
                    width: 400,
                    child: TextField(
                      controller: ref.watch(_textControllerProvider),
                      decoration: const InputDecoration(
                        labelText: "Nome da tag",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    try {
                      await ref.watch(eventRepoProvider).addTag(
                            eventTag: EventTag(
                              tagName: ref.watch(_textControllerProvider).text,
                            ),
                          );
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Tag adicionada"),
                          ),
                        );
                      }
                    } catch (e) {
                      print(e);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Erro ao criar tag"),
                        ),
                      );
                    }
                  },
                  child: const Text("Criar"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
