import 'dart:ui';

import 'package:bmi_weight/Result_brain.dart';
import 'package:bmi_weight/Result_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/animation.dart';
import 'containercontent.dart';
import 'customcontainer.dart';

const inactivecardcolor = Color(0xFF1D1E33);
const activecardcolor = Color(0xFFEB1555);
const buttonColor = Color(0xFFEB1555);
const overlayColor = Color(0x29EB1555);

enum gender {
  male,
  female,
}

enum Operation {
  add,
  sub,
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  gender? selectedgender;
  int height = 180;
  int weight = 60;
  int age = 20;

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _slideAnimation;

  void changeweight(Operation opp) {
    if (opp == Operation.add) {
      weight++;
    } else
      weight--;
  }

  void changeage(Operation opp) {
    if (opp == Operation.add) {
      age++;
    } else
      age--;
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _slideAnimation = Tween<double>(begin: 50, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0A0E21),
        title: Text(
          'BMI CALCULATOR',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _slideAnimation.value),
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                      child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedgender = gender.male;
                            });
                          },
                          child: CustomContainer(
                            colour: selectedgender == gender.male
                                ? activecardcolor
                                : inactivecardcolor,
                            Customchild: containercontent(
                              iconsss: FontAwesomeIcons.mars,
                              labeltext: 'MALE',
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedgender = gender.female;
                            });
                          },
                          child: CustomContainer(
                            colour: selectedgender == gender.female
                                ? activecardcolor
                                : inactivecardcolor,
                            Customchild: containercontent(
                              iconsss: FontAwesomeIcons.venus,
                              labeltext: 'FEMALE',
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
                  Expanded(
                    child: CustomContainer(
                      Customchild: Column(
                        children: [
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            'HEIGHT',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.grey),
                          ),
                          Row(
                            textBaseline: TextBaseline.alphabetic,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                height.toString(),
                                style: TextStyle(
                                    fontSize: 50, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'cm',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 17.0),
                              overlayShape:
                                  RoundSliderOverlayShape(overlayRadius: 40.0),
                            ),
                            child: Slider(
                              value: height.toDouble(),
                              min: 120,
                              max: 250,
                              activeColor: Colors.deepPurpleAccent,
                              inactiveColor: Colors.purple,
                              onChanged: (double newvalue) {
                                setState(() {
                                  height = newvalue.round();
                                });
                              },
                            ),
                          )
                        ],
                      ),
                      colour: inactivecardcolor,
                    ),
                  ),
                  Expanded(
                      child: Row(
                    children: [
                      Expanded(
                        child: CustomContainer(
                          colour: inactivecardcolor,
                          Customchild: Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'WEIGHT',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                              Text(
                                weight.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 50),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FloatingActionButton(
                                    backgroundColor: Colors.red,
                                    shape: CircleBorder(),
                                    onPressed: () {
                                      setState(() {
                                        changeweight(Operation.add);
                                      });
                                    },
                                    child: Icon(FontAwesomeIcons.add),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  FloatingActionButton(
                                    backgroundColor: Colors.red,
                                    shape: CircleBorder(),
                                    onPressed: () {
                                      setState(() {
                                        changeweight(Operation.sub);
                                      });
                                    },
                                    child: Icon(FontAwesomeIcons.minus),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: CustomContainer(
                          colour: inactivecardcolor,
                          Customchild: Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'AGE',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                              Text(
                                age.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 50),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FloatingActionButton(
                                    backgroundColor: Colors.red,
                                    shape: CircleBorder(),
                                    onPressed: () {
                                      setState(() {
                                        changeage(Operation.add);
                                      });
                                    },
                                    child: Icon(FontAwesomeIcons.add),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  FloatingActionButton(
                                    backgroundColor: Colors.red,
                                    shape: CircleBorder(),
                                    onPressed: () {
                                      setState(() {
                                        changeage(Operation.sub);
                                      });
                                    },
                                    child: Icon(FontAwesomeIcons.minus),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _scaleAnimation.value,
                        child: GestureDetector(
                          onTap: () {
                            _controller.reverse().then((_) {
                              _controller.forward();
                              CalculatorBrain calc = CalculatorBrain(
                                  height: height, weight: weight);
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      ResultScreen(
                                    bmiResult: calc.calculateBMI(),
                                    resultText: calc.getResult(),
                                    interpretation: calc.getInterpretation(),
                                  ),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    var begin = Offset(1.0, 0.0);
                                    var end = Offset.zero;
                                    var curve = Curves.easeInOutCubic;
                                    var tween = Tween(begin: begin, end: end)
                                        .chain(CurveTween(curve: curve));
                                    return SlideTransition(
                                      position: animation.drive(tween),
                                      child: child,
                                    );
                                  },
                                  transitionDuration:
                                      Duration(milliseconds: 500),
                                ),
                              );
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                              'CALCULATE',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            margin: EdgeInsets.only(top: 15),
                            height: 60,
                            color: Colors.red,
                            width: double.infinity,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
