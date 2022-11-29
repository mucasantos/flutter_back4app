import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final String myImageUrl =
      "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bf/Bucephala-albeola-010.jpg/220px-Bucephala-albeola-010.jpg";

  final imageUrl;

  const MyCard({Key? key, required this.imageUrl}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
        height: 200,
        width: screenSize.width * 0.9,
        color: Colors.blue,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child:
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
              ),
              Expanded(
                flex: 1,
                child: Image.network(imageUrl, fit: BoxFit.cover),
              ),
            ]));
  }
}
