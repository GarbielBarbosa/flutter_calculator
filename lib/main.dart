import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final options = [
    "Back",
    "AC",
    "%",
    "*",
    "7",
    "8",
    "9",
    "/",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "0",
    ".",
    "="
  ];

  var operation = "";
  var result = 0.0;
  var a;
  var b;
  var currentOp;
  final _operationController = new TextEditingController();

  final _lastOperationController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(68, 73, 78, 1),
      body: SafeArea(
        top: true,
        bottom: true,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(right: 24, bottom: 10, left: 24),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      const BoxShadow(
                        color: Color.fromRGBO(68, 73, 78, 1),
                      ),
                      const BoxShadow(
                        color: Color.fromRGBO(220, 225, 230, 0.1),
                        spreadRadius: 0,
                        blurRadius: 12.0,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AutoSizeTextField(
                        controller: _lastOperationController,
                        textInputAction: TextInputAction.next,
                        textAlign: TextAlign.end,
                        decoration: InputDecoration.collapsed(
                          hintText: "",
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          color: Color.fromRGBO(237, 156, 61, 0.8),
                          fontSize: 15,
                        ),
                        minLines: 1,
                        maxLines: 2,
                        enabled: false,
                      ),
                      AutoSizeTextField(
                        controller: _operationController,
                        textInputAction: TextInputAction.next,
                        textAlign: TextAlign.end,
                        decoration: InputDecoration.collapsed(
                          hintText: "",
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          color: Color.fromRGBO(237, 156, 61, 1),
                          fontSize: 50,
                        ),
                        minLines: 1,
                        maxLines: 3,
                        enabled: false,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 4,
                child: StaggeredGridView.countBuilder(
                  padding: EdgeInsets.zero,
                  crossAxisCount: 4,
                  itemCount: 19,
                  itemBuilder: (BuildContext context, int index) =>
                      GestureDetector(
                    onTap: () {
                      final op = options[index];

                      switch (op) {
                        case "AC":
                          {
                            _lastOperationController.text = '';
                            _operationController.text = '';
                            break;
                          }
                        case "Back":
                          {
                            _operationController.text =
                                _operationController.text.substring(
                                    0, _operationController.text.length - 1);
                            break;
                          }
                        case "=":
                          {
                            _lastOperationController.text =
                                _operationController.text;
                            Parser p = new Parser();
                            Expression exp = p.parse(_operationController.text);
                            _operationController.text = exp
                                .evaluate(EvaluationType.REAL, ContextModel())
                                .toString()
                                .replaceAll('.0', '');
                            break;
                          }
                        default:
                          {
                            _operationController.text += options[index];
                          }
                      }
                      setState(() {});
                    },
                    child: buildContainer(index),
                  ),
                  staggeredTileBuilder: (int index) {
                    if (index == 18) {
                      return StaggeredTile.count(2, 1);
                    } else {
                      return StaggeredTile.count(1, 1);
                    }
                  },
                  mainAxisSpacing: 4.0,
                )),
          ],
        ),
      ),
    );
  }

  Container buildContainer(int i) {
    if (i == 2 || i == 3 || i == 7 || i == 11 || i == 15) {
      return Container(
        child: Center(
          child: Stack(
            children: [
              Container(
                height: 65,
                child: Center(
                  child: Text(
                    options[i],
                    style: TextStyle(
                        color: fontColorController(i),
                        fontFamily: 'Fira Code',
                        fontWeight: FontWeight.bold,
                        fontSize: 28),
                  ),
                ),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(237, 156, 61, 0.8)),
              ),
            ],
          ),
        ),
      );
    } else if (i == 0) {
      return Container(
        child: Center(
          child: Stack(
            children: [
              Container(
                height: 80,
                child: Center(
                  child: Icon(
                    Icons.backspace,
                    color: fontColorController(i),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else if (i == 18) {
      return Container(
        child: Center(
          child: Stack(
            children: [
              Center(
                child: Container(
                  height: 80,
                  width: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(100),
                    color: Color.fromRGBO(237, 156, 61, 0.8),
                  ),
                ),
              ),
              Center(
                child: Text(
                  options[i],
                  style: TextStyle(
                      color: fontColorController(i),
                      fontWeight: FontWeight.bold,
                      fontSize: 28),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
        color: Color.fromRGBO(68, 73, 78, 1),
        child: Center(
          child: Text(
            options[i],
            style: TextStyle(
              color: fontColorController(i),
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
        ),
      );
    }
  }

  fontColorController(i) {
    if (i == 15 || i == 2 || i == 3 || i == 7 || i == 11 || i == 18) {
      return Color.fromRGBO(68, 73, 78, 1);
    } else if (i == 0 || i == 1) {
      return Color.fromRGBO(237, 156, 61, 1);
    } else {
      return Color.fromRGBO(177, 181, 182, 1);
    }
  }
}
