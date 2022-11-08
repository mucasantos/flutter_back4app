import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

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
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: darkBlue,
      ),
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: FutureBuilder<List<ParseObject>>(
                    future: getRecipes(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return const Center(
                            child: SizedBox(
                                width: 100,
                                height: 100,
                                child: CircularProgressIndicator()),
                          );
                        default:
                          if (snapshot.hasError) {
                            return const Center(
                              child: Text("Error..."),
                            );
                          }
                          if (!snapshot.hasData) {
                            return const Center(
                              child: Text("No Data..."),
                            );
                          } else {
                            return ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.only(top: 10.0),
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  //*************************************
                                  //Get Parse Object Values
                                  final varTodo = snapshot.data![index];
                                  final varTitle =
                                      varTodo.get<String>('title')!;
                                  final varImage =
                                      varTodo.get<String>('imageFood')!;
                                  const varDone = true;
                                  //*************************************

                                  log(varTodo.toString());

                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: MyCard(
                                      imageUrl: varImage,
                                    ),
                                  );
                                });
                          }
                      }
                    }),
              ),
              ElevatedButton(
                  onPressed: () async {
                    final todo = ParseObject('CardFood')
                      ..set('title', 'Primeira receita')
                      ..set('imageFood',
                          "https://thumbs.dreamstime.com/b/beautiful-rain-forest-ang-ka-nature-trail-doi-inthanon-national-park-thailand-36703721.jpg")
                      ..set('desciption', 'Top demais!')
                      ..set('preparation', '45');
                    await todo.save();
                  },
                  child: const Text("Salvar Info")),
              Expanded(
                  child: FutureBuilder<List<ParseObject>>(
                      future: getExercices(),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return const Center(
                              child: SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: CircularProgressIndicator()),
                            );
                          default:
                            if (snapshot.hasError) {
                              return const Center(
                                child: Text("Error..."),
                              );
                            }
                            if (!snapshot.hasData) {
                              return const Center(
                                child: Text("No Data..."),
                              );
                            } else {
                              return ListView.builder(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    //*************************************
                                    //Get Parse Object Values
                                    final varTodo = snapshot.data![index];
                                    final varTitle =
                                        varTodo.get<String>('title')!;
                                    final varDone = varTodo.get<bool>('done')!;
                                    //*************************************

                                    log(varTodo.toString());

                                    return ListTile(
                                      title: Text(varTitle),
                                      leading: CircleAvatar(
                                        backgroundColor: varDone
                                            ? Colors.green
                                            : Colors.blue,
                                        foregroundColor: Colors.white,
                                        child: Icon(varDone
                                            ? Icons.check
                                            : Icons.error),
                                      ),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Checkbox(
                                              value: varDone,
                                              onChanged: (value) async {}),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.blue,
                                            ),
                                            onPressed: () async {},
                                          )
                                        ],
                                      ),
                                    );
                                  });
                            }
                        }
                      })),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<ParseObject>> getExercices() async {
    QueryBuilder<ParseObject> queryTodo =
        QueryBuilder<ParseObject>(ParseObject('Exercicio'));
    final ParseResponse apiResponse = await queryTodo.query();

    if (apiResponse.success && apiResponse.results != null) {
      return apiResponse.results as List<ParseObject>;
    } else {
      return [];
    }
  }

  Future<List<ParseObject>> getRecipes() async {
    QueryBuilder<ParseObject> queryTodo =
        QueryBuilder<ParseObject>(ParseObject('CardFood'));
    final ParseResponse apiResponse = await queryTodo.query();

    if (apiResponse.success && apiResponse.results != null) {
      log(apiResponse.results.toString());
      return apiResponse.results as List<ParseObject>;
    } else {
      log("Sem dados...");
      return [];
    }
  }
}

class MyCard extends StatelessWidget {
  final String myImageUrl =
      "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bf/Bucephala-albeola-010.jpg/220px-Bucephala-albeola-010.jpg";

  final imageUrl;

  const MyCard({Key? key, required this.imageUrl}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        //height: 150,
        width: 450,
        color: Colors.blue,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                const Text("Patinho do Samuca"),
                const SizedBox(
                  width: 200,
                  child: Text(
                    "Duck is the common name for numerous species of  waterfowl in the family Anatidae.",
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(children: const [
                        Icon(
                          Icons.star,
                          size: 15,
                        ),
                        Icon(
                          Icons.star,
                          size: 15,
                        ),
                        Icon(
                          Icons.star,
                          size: 15,
                        ),
                        Icon(
                          Icons.star,
                          size: 15,
                        ),
                        Icon(
                          Icons.star,
                          size: 15,
                        ),
                      ]),
                      const Text('170 Reviews')
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(children: const [
                        Icon(Icons.close),
                        Text('PREP'),
                        Text('25min')
                      ]),
                      Column(children: const [
                        Icon(Icons.close),
                        Text('PREP'),
                        Text('25min')
                      ]),
                      Column(children: const [
                        Icon(Icons.close),
                        Text('PREP'),
                        Text('25min')
                      ]),
                    ])
              ]),
              Expanded(
                child: Image.network(imageUrl, fit: BoxFit.cover),
              ),
            ]));
  }
}
