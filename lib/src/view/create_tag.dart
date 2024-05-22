import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
                const SizedBox(
                  width: 250,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Nome da tag",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
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
