import 'package:flutter/material.dart';
import 'package:proj4bimga/constants.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({
    Key? key,
  }) : super(key: key);
//  final List<String> nomes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SEgunda tela'),
      ),
      body: Column(
        children: [
          Text(AppData.nomes[0]),
          Text(AppData.nomes[1]),
          Text(AppData.nomes[2]),
          Text(AppData.nomes[3]),
        ],
      ),
    );
  }
}
