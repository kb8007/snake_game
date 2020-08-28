import 'package:custom_radio_grouped_button/CustomButtons/ButtonTextStyle.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:snake_game/data/data.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
    List<String> textBestScore = [
        'Best score ${Data.bestScore}',
        'Meilleur score ${Data.bestScore}',
        'أفضل نتيجة ${Data.bestScore}'
    ];
    Map<int, List<String>> levels = {
        0: ['Low', 'Medium', 'High'],
        1: ['Faible', 'Moyen', 'Elevé'],
        2: ['ضعيف', 'متوسط', 'عالي']
    };
    List<int> levelValues = [250, 150, 50];

    void setNumberOfCellsY() {
        double height = MediaQuery.of(context).size.height;
        double width = MediaQuery.of(context).size.width;
        double numberOfCellsYMax = height*width/496.0;
        int i;

        for(i = 20;i < numberOfCellsYMax.toInt();i += 20) {}
        Data.numberOfCellsY = i - 20;
    }

    @override
  Widget build(BuildContext context) {
        setNumberOfCellsY();

    return Scaffold(
        backgroundColor: Data.firstColor,
        floatingActionButton: FloatingActionButton(
            onPressed: () {
                setState(() {
                    Data.currentLanguageIndex++;
                    Data.currentLanguageIndex = Data.currentLanguageIndex % Data.languages.length;
                });
            },
            backgroundColor: Data.secondColor,
            child: Text(
                Data.languages[Data.currentLanguageIndex],
                style: TextStyle(
                    color: Data.firstColor
                ),
            ),
        ),
        body: Center(
//            padding: const EdgeInsets.only(top: 280.0, left: 0.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    RawMaterialButton(
                        onPressed: () {
                            Data.currentScore = 0;
                            Navigator.of(context).pushReplacementNamed('/game');
                        },
                        elevation: 2.0,
                        fillColor: Data.secondColor,
                        child: Icon(
                            Icons.play_arrow,
                            size: 70.0,
                            color: Data.firstColor,
                        ),
                        padding: EdgeInsets.all(15.0),
                        shape: CircleBorder(),
                    ),
                    SizedBox(height: 30.0,),
                    Text(
                        textBestScore[Data.currentLanguageIndex],
                        style: TextStyle(
                            color: Data.secondColor,
                            decoration: TextDecoration.none,
                            fontSize: 24.0
                        ),
                    ),
                    SizedBox(height: 100.0,),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                            SizedBox(
                                width: MediaQuery.of(context).size.width - 90.0,
                              child: CustomRadioButton(
                                  defaultSelected: Data.level,
                                  elevation: 5,
                                  absoluteZeroSpacing: false,
                                  unSelectedColor: Theme.of(context).canvasColor,
                                  buttonLables: levels[Data.currentLanguageIndex],
                                  buttonValues: levelValues,
                                  buttonTextStyle: ButtonTextStyle(
                                      selectedColor: Data.firstColor,
                                      unSelectedColor: Data.isDarkMode? Colors.black : Data.secondColor,
                                      textStyle: TextStyle(fontSize: 16)),
                                  radioButtonValue: (level) {
                                      Data.level = level;
                                  },
                                  selectedColor: Theme.of(context).accentColor,
                              ),
                            ),
                        ],
                    ),
                    SizedBox(height: 50.0,),
                    Transform.scale(
                        scale: 1.5,
                        child: Switch(
                            onChanged: (value) {
                                setState(() {
                                    Data.isDarkMode = value;
                                    if(Data.isDarkMode) {
                                        Data.firstColor = Colors.black;
                                        Data.secondColor = Colors.white;
                                    }
                                    else {
                                        Data.firstColor = Colors.white;
                                        Data.secondColor = Colors.black;
                                    }
                                });
                            },
                            value: Data.isDarkMode,
                            activeTrackColor: Data.secondColor,
                            activeColor: Data.secondColor,
                        ),
                    )
                ],
            ),
        ),
    );
  }
}
