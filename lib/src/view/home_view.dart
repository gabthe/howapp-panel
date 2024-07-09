import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const Text(
              'Gerenciar',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            HomeDrawerButtonWidget(
              onTap: () {
                context.goNamed(
                  "create-event",
                  extra: {
                    'id': null,
                    'isExperience': false,
                  },
                );
              },
              buttonTitle: 'Criar Evento',
            ),
            HomeDrawerButtonWidget(
              onTap: () {
                context.goNamed(
                  "create-event",
                  extra: {
                    'id': null,
                    'isExperience': true,
                  },
                );
              },
              buttonTitle: 'Criar Experiencia',
            ),
            HomeDrawerButtonWidget(
              onTap: () {
                context.goNamed("create-tag");
              },
              buttonTitle: 'Criar Tag',
            ),
            HomeDrawerButtonWidget(
              onTap: () {
                context.goNamed("create-type-of-place");
              },
              buttonTitle: 'Criar Tipo de Estabelecimento',
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Painel Putão'),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 600,
            color: Colors.grey[200],
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 100,
              ),
              children: [
                HomeBigButtonWidget(
                  buttonText: 'Criar novo evento',
                  onPressed: () {
                    context.goNamed("create-event", extra: {
                      'id': null,
                      'isExperience': false,
                    });
                  },
                ),
                HomeBigButtonWidget(
                  buttonText: 'Criar nova experiencia',
                  onPressed: () {
                    context.goNamed("create-event", extra: {
                      'id': null,
                      'isExperience': true,
                    });
                  },
                ),
                HomeBigButtonWidget(
                  buttonText: 'Eventos',
                  onPressed: () {
                    context.goNamed("events", extra: false);
                  },
                ),
                HomeBigButtonWidget(
                  buttonText: 'Experiencias',
                  onPressed: () {
                    context.goNamed("events", extra: true);
                  },
                ),
                HomeBigButtonWidget(
                  buttonText: 'Usuarios',
                  onPressed: () {},
                ),
                HomeBigButtonWidget(
                  buttonText: 'Destaques (Eventos)',
                  onPressed: () {
                    context.goNamed("highlight", extra: false);
                  },
                ),
                HomeBigButtonWidget(
                  buttonText: 'Destaques (Experiencias)',
                  onPressed: () {
                    context.goNamed("highlight", extra: true);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeBigButtonWidget extends StatelessWidget {
  final String buttonText;
  final Function()? onPressed;
  const HomeBigButtonWidget({
    required this.buttonText,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          backgroundColor: Colors.white,
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

class HomeDrawerButtonWidget extends StatelessWidget {
  const HomeDrawerButtonWidget({
    super.key,
    required this.onTap,
    required this.buttonTitle,
  });
  final void Function()? onTap;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 40,
        child: Row(
          children: [
            const Icon(Icons.create),
            const SizedBox(width: 4),
            Text(buttonTitle),
          ],
        ),
      ),
    );
  }
}
