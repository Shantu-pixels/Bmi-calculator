import 'package:flutter/material.dart';
import 'Home_Screen.dart';
import 'customcontainer.dart';
import 'profile_page.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({
    super.key,
    required this.bmiResult,
    required this.resultText,
    required this.interpretation,
  });

  final String bmiResult;
  final String resultText;
  final String interpretation;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.5, curve: Curves.easeIn),
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
        title: Text('BMI CALCULATOR'),
        centerTitle: true,
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _slideAnimation.value),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: TweenAnimationBuilder(
                      duration: Duration(milliseconds: 800),
                      tween: Tween<double>(begin: 0, end: 1),
                      builder: (context, double value, child) {
                        return Opacity(
                          opacity: value,
                          child: Transform.translate(
                            offset: Offset(0, (1 - value) * 20),
                            child: child,
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(15.0),
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Your Result',
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: TweenAnimationBuilder(
                      duration: Duration(milliseconds: 1000),
                      tween: Tween<double>(begin: 0, end: 1),
                      builder: (context, double value, child) {
                        return Transform.scale(
                          scale: value,
                          child: Opacity(
                            opacity: value,
                            child: child,
                          ),
                        );
                      },
                      child: CustomContainer(
                        colour: inactivecardcolor,
                        Customchild: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              widget.resultText.toUpperCase(),
                              style: TextStyle(
                                color: _getResultColor(widget.resultText),
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.bmiResult,
                              style: TextStyle(
                                fontSize: 100,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                widget.interpretation,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  TweenAnimationBuilder(
                    duration: Duration(milliseconds: 800),
                    tween: Tween<double>(begin: 0, end: 1),
                    builder: (context, double value, child) {
                      return Transform.translate(
                        offset: Offset(0, (1 - value) * 50),
                        child: Opacity(
                          opacity: value,
                          child: child,
                        ),
                      );
                    },
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(
                              bmiResult: widget.bmiResult,
                              height: int.parse(widget.bmiResult.split('.')[0]),
                              weight: int.parse(widget.bmiResult.split('.')[0]),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        width: double.infinity,
                        height: 80,
                        color: Colors.deepPurpleAccent,
                        child: Center(
                          child: Text(
                            'VIEW PROFILE',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  TweenAnimationBuilder(
                    duration: Duration(milliseconds: 800),
                    tween: Tween<double>(begin: 0, end: 1),
                    builder: (context, double value, child) {
                      return Transform.translate(
                        offset: Offset(0, (1 - value) * 50),
                        child: Opacity(
                          opacity: value,
                          child: child,
                        ),
                      );
                    },
                    child: GestureDetector(
                      onTap: () {
                        _controller.reverse().then((_) {
                          Navigator.pop(context);
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        width: double.infinity,
                        height: 80,
                        color: buttonColor,
                        child: Center(
                          child: Text(
                            'RE-CALCULATE',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getResultColor(String result) {
    switch (result.toLowerCase()) {
      case 'normal':
        return Colors.green;
      case 'overweight':
        return Colors.orange;
      case 'underweight':
        return Colors.red;
      default:
        return Colors.white;
    }
  }
}
