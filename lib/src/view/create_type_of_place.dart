import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Tipo de estabelecimento',
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Criar'),
            )
          ],
        ),
      ),
    );
  }
}
