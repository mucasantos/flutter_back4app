import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:proj4bimga/constants.dart';

import 'home.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const keyApplicationId = 'unwnviubnkP4GEptRisvPzV1TGUvh8829ZutU6nE';
  const keyClientKey = 'EUMx94lQKImRsORPerSTQTCNpxaOuMjdrDpBHG2E';
  const keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppData.nomes = ['Sam', 'Maria', 'Joana', 'Rogerio'];

    return MaterialApp(
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: darkBlue,
        ),
        debugShowCheckedModeBanner: false,
        home: const Home());
  }
}
