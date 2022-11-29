import 'package:flutter/material.dart';
import 'package:proj4bimga/constants.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({
    Key? key,
  }) : super(key: key);
//  final List<String> nomes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text('SEgunda tela'),
      ),
      body: Column(
        children: [
          Text('${AppData.user!.nome}'),
          Text(AppData.user!.tarefas.toString()),
          Text(AppData.nomes[2]),
          Text(AppData.nomes[3]),
        ],
      ),
    );
  }
}
