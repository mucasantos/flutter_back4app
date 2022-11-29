import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:proj4bimga/constants.dart';
import 'package:proj4bimga/second.screen.dart';
import 'package:proj4bimga/third.screen.dart';
import 'package:proj4bimga/widgets/mycard.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  Future<List<ParseObject>> getExercices() async {
    QueryBuilder<ParseObject> queryTodo =
        QueryBuilder<ParseObject>(ParseObject('Exercicio'));
    final ParseResponse apiResponse = await queryTodo.query();

    if (apiResponse.success && apiResponse.results != null) {
      AppData.user = User(
          nome: 'Samuel Santos', id: '001', tarefas: ['escola', 'trabalho']);
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 2,
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
                                final varTitle = varTodo.get<String>('title')!;
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
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SecondScreen(
                            //   nomes: ['Sam', 'Maria', 'Joana', 'Rogerio'],
                            )),
                  );
                },
                child: const Text('Segunda Tela')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ThirdScreen(
                            //   nomes: ['Sam', 'Maria', 'Joana', 'Rogerio'],
                            )),
                  );
                },
                child: const Text('Terceira Tela')),
            Expanded(
                flex: 3,
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
                                      backgroundColor:
                                          varDone ? Colors.green : Colors.blue,
                                      foregroundColor: Colors.white,
                                      child: Icon(
                                          varDone ? Icons.check : Icons.error),
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
    );
  }
}
