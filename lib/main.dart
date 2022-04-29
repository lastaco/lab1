import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool timeEnd = false;
  int score = 0;
  Color _color = Colors.black;
  Color _color2 = Colors.black;
  String textColor = '';
  String textColor2 = '';
  String textColor3 = '';

  List<Color> colorsList = [
    Colors.purple,
    Colors.grey,
    Colors.black,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.pink,
    Colors.brown,
  ];

  List<String> colorsName = [
    'Фиолетовый',
    'Серый',
    'Черный',
    'Синий',
    'Зеленый',
    'Желтый',
    'Оранжевый',
    'Коричневый',
    'Розовый',
  ];

  Map<int, Map<String, Color>> colors = {
    0: {'Фиолетовый': Colors.purple},
    1: {'Серый': Colors.grey},
    2: {'Черный': Colors.black},
    3: {'Синий': Colors.blue},
    4: {'Зеленый': Colors.green},
    5: {'Желтый': Colors.yellow},
    6: {'Оранжевый': Colors.orange},
    7: {'Розовый': Colors.pink},
    8: {'Коричневый': Colors.brown},
  };
  Timer? _timer;

  int retryTimer = 60;

  void stopTimer() {
    if (_timer != null) {
      try {
        _timer!.cancel();
      } catch (e) {}
    }
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (retryTimer == 0) {
          setState(() {
            stopTimer();
            timeEnd = true;
          });
        } else {
          setState(() {
            retryTimer--;
          });
        }
      },
    );
  }

  void yes() {
    if (textColor == textColor3) {
      score++;
    }
  }

  void no() {
    if (textColor != textColor3) {
      score++;
    }
  }

  void changeColor() {
    var rng = Random();
    int index = rng.nextInt(9);
    int index2 = rng.nextInt(9);
    int index3 = rng.nextInt(9);
    int index4 = rng.nextInt(9);
    setState(() {
      textColor = '${colors[index]?.keys}'.replaceAll('(', '');
      textColor = textColor.replaceAll(')', '');

      _color = colors[index]?[textColor] as Color;
      _color2 = colorsList[index2];
      textColor2 = colorsName[index3];
      textColor3 = colorsName[index4];
    });
  }

  @override
  void initState() {
    changeColor();
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: const Text(
            'Лаборотна робота №2',
          ),
          centerTitle: true,
        ),
        body: timeEnd == false
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Совпадает ли название цвета слева с цветом текста справа?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        textColor3,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _color2,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        textColor2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _color,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          yes();
                          changeColor();
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.grey),
                        ),
                        child: const Text(
                          'Да',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          no();
                          changeColor();
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.grey),
                        ),
                        child: const Text(
                          'Нет',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Text(
                    'Осталось: $retryTimer',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Center(
                    child: Text(
                      'Вас счет: $score',
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        retryTimer = 60;
                        timeEnd = false;
                      });
                      changeColor();
                      startTimer();
                    },
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all<Size>(
                          const Size(250, 50),),

                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.grey),
                    ),
                    child: const Text(
                      'Попробовать еще раз',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50,),
                ],
              ),
      ),
    );
  }
}
