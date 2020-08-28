
import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:snake_game/data/data.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
    List<int> _snakePosition = [225, 226, 227, 228];
    int _food;
    var direction = 'right';
    List<String> textScore = [
        'Score :',
        'Score :',
        'نتيجة :'
    ];

    static var random = Random();

    void startGame() {
        generateFood();
        Duration duration = Duration(milliseconds: Data.level);
        Timer.periodic(duration, (Timer timer) {
           updateSnake();
           if(isGameOver()) {
               timer.cancel();
               Data.bestScore = Data.bestScore < Data.currentScore? Data.currentScore : Data.bestScore;
               Navigator.of(context).pushReplacementNamed('/home');
           }
        });
    }

    void updateSnake() {
        setState(() {
            switch(direction) {
                case 'up':
                    if(_snakePosition.last < 20) {
                        _snakePosition.add(_snakePosition.last - 20 + Data.numberOfCellsY);
                    }
                    else {
                        _snakePosition.add(_snakePosition.last - 20);
                    }
                    break;
                case 'down':
                    if(_snakePosition.last > Data.numberOfCellsY-20) {
                        _snakePosition.add(_snakePosition.last + 20 - Data.numberOfCellsY);
                    }
                    else {
                        _snakePosition.add(_snakePosition.last + 20);
                    }
                    break;
                case 'left':
                    if(_snakePosition.last % 20 == 0) {
                        _snakePosition.add(_snakePosition.last - 1 + 20);
                    }
                    else {
                        _snakePosition.add(_snakePosition.last - 1);
                    }
                    break;
                case 'right':
                    if((_snakePosition.last + 1) % 20 == 0) {
                        _snakePosition.add(_snakePosition.last + 1 - 20);
                    }
                    else {
                        _snakePosition.add(_snakePosition.last + 1);
                    }
                    break;
                default:
            }

            if(_snakePosition.last == _food) {
                generateFood();
                Data.currentScore++;
            }
            else {
                _snakePosition.removeAt(0);
            }
        });
    }

    bool isGameOver() {
        for(int i = 0; i < _snakePosition.length; i++) {
            int count = 0;
            for(int j = 0; j < _snakePosition.length; j++) {
                if(_snakePosition[i] == _snakePosition[j]) {
                    count++;
                }

                if(count == 2) {
                    return true;
                }
            }
        }
        return false;
    }

    void generateFood() {
        _food = random.nextInt(Data.numberOfCellsY);
        while(_snakePosition.contains(_food)) {
            _food = random.nextInt(Data.numberOfCellsY);
        }
    }

    @override
  void initState() {
    // TODO: implement initState
    super.initState();

    startGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Data.firstColor,
        body: Column(
            children: <Widget>[
                SafeArea(
                    maintainBottomViewPadding: false,
                    child: Text(
                        '${textScore[Data.currentLanguageIndex]} ${Data.currentScore}',
                        style: TextStyle(
                            fontSize: 32.0,
                            color: Data.secondColor
                        ),
                    ),
                ),
                Expanded(
                    child: GestureDetector(
                        onVerticalDragUpdate: (details) {
                            if(direction != 'up' && details.delta.dy > 0) {
                                direction = 'down';
                            }
                            else if(direction != 'down' && details.delta.dy < 0){
                                direction = 'up';
                            }
                        },
                        onHorizontalDragUpdate: (details) {
                            if(direction != 'left' && details.delta.dx > 0) {
                                direction = 'right';
                            }
                            else if(direction != 'right' && details.delta.dx < 0) {
                                direction = 'left';
                            }
                        },
                        child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 20
                            ),
                            itemBuilder: (BuildContext context, int index) {
                                Color gridClor = Data.firstColor;

                                if(_snakePosition.contains(index)) {
                                    gridClor = Data.secondColor;
                                }
                                else if(index == _food){
                                    gridClor = Colors.green;
                                }

                                return Center(
                                    child: Container(
                                        padding: const EdgeInsets.all(2),
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Container(
                                                color: gridClor,
                                            ),
                                        ),
                                    ),
                                );
                            }
                        ),
                    ),
                )
            ],
        ),
    );
  }
}
