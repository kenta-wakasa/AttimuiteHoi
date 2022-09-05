import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      home: const AttimuiteHoi(),
    );
  }
}

class AttimuiteHoi extends StatefulWidget {
  const AttimuiteHoi({Key? key}) : super(key: key);

  @override
  State<AttimuiteHoi> createState() => _AttimuiteHoiState();
}

class _AttimuiteHoiState extends State<AttimuiteHoi> {
  int winCounter = 0;

  /// succes　-> success かな?
  /// 5回連勝の達成回数を記録しようとしていてよい！
  int succesCounter = 0;
  int maxCounter = 0;
  String myHand = '👆';
  String computerHand = '👆';
  String result = '';

  /// ゲーム続行中は isPlaying が true となる
  /// このように書くと意味が理解しやすい
  bool get isPlaying => result != 'あかん、、残念！';

  void selectHand(String selectedHand) {
    // ここを result == 'ええ調子や！' || result == '' から変更
    if (isPlaying) {
      myHand = selectedHand;
      generateComputerHand();
      judge();
      setState(() {});
    }
  }

  void generateComputerHand() {
    final randomNumber = Random().nextInt(4);
    computerHand = randomNumberToHand(randomNumber);
  }

  String randomNumberToHand(int randomNumber) {
    switch (randomNumber) {
      case 0:
        return '👆';
      case 1:
        return '👉';
      case 2:
        return '👈';
      case 3:
        return '👇';
      default:
        return '👆';
    }
  }

  void judge() {
    if (myHand == computerHand) {
      result = 'あかん、、残念！';
    } else {
      result = 'ええ調子や！';
      winCounter++;
      if (winCounter == 5) {
        succesCounter++;
      }
      if (maxCounter < winCounter) {
        maxCounter = winCounter;
      }
    }
  }

  void reset() {
    myHand = '👆';
    computerHand = '👆';
    result = '';
    winCounter = 0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'そっち指差しちゃあかんのよ！',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  const Text(
                    '目指せ5連勝！',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '5連勝達成回数：$succesCounter',
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '最大連続回数：$maxCounter',
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    '$winCounter回連勝中',
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Text(
              '相手と違う方向を指そう！',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              computerHand,
              style: const TextStyle(fontSize: 40),
            ),
            const Text(
              '相手',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              result,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              myHand,
              style: const TextStyle(fontSize: 40),
            ),
            const Text(
              '自分',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  // ボタンを押しても意味がない時は非活性にしたほうが良い
                  onPressed: isPlaying
                      ? () {
                          selectHand('👆');
                        }
                      : null,
                  child: const Text(
                    '👆',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                ElevatedButton(
                  // ボタンを押しても意味がない時は非活性にしたほうが良い
                  onPressed: isPlaying
                      ? () {
                          selectHand('👉');
                        }
                      : null,
                  child: const Text(
                    '👉',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                ElevatedButton(
                  // ボタンを押しても意味がない時は非活性にしたほうが良い
                  onPressed: isPlaying
                      ? () {
                          selectHand('👈');
                        }
                      : null,
                  child: const Text(
                    '👈',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                ElevatedButton(
                  // ボタンを押しても意味がない時は非活性にしたほうが良い
                  onPressed: isPlaying
                      ? () {
                          selectHand('👇');
                        }
                      : null,
                  child: const Text(
                    '👇',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ],
            ),
            if (result == 'あかん、、残念！')
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      reset();
                    },
                    child: const Text(
                      'reset',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Text('resetを押してもう一回！',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
