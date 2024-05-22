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
            InkWell(
              onTap: () {
                GoRouter.of(context).goNamed('create-event');
              },
              child: Container(
                width: double.infinity,
                height: 40,
                child: const Row(
                  children: [
                    Icon(Icons.create),
                    SizedBox(width: 4),
                    Text('Criar novo evento'),
                  ],
                ),
              ),
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
                  child: Text('Ola'),
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
