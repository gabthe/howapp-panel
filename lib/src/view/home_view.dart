import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                context.goNamed("create-event");
              },
              buttonTitle: 'Criar Evento',
            ),
            HomeDrawerButtonWidget(
              onTap: () {
                context.goNamed("create-tag");
              },
              buttonTitle: 'Criar Tag',
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
            height: 200,
            color: Colors.grey,
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 100,
              ),
              children: [
                Container(
                  height: 5,
                  width: 5,
                  color: Colors.red,
                  child: const Text('Ola'),
                ),
                Container(
                  height: 5,
                  width: 5,
                  color: Colors.yellow,
                ),
                Container(
                  height: 5,
                  width: 5,
                  color: Colors.green,
                ),
                Container(
                  height: 5,
                  width: 5,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ],
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
