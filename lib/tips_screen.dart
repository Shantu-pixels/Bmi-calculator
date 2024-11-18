import 'package:flutter/material.dart';
import 'customcontainer.dart';

class TipsScreen extends StatefulWidget {
  @override
  _TipsScreenState createState() => _TipsScreenState();
}

class _TipsScreenState extends State<TipsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  final List<Map<String, dynamic>> tips = [
    {
      'category': 'BMI Categories',
      'icon': Icons.scale,
      'items': [
        'Underweight: BMI less than 18.5',
        'Normal weight: BMI 18.5-24.9',
        'Overweight: BMI 25-29.9',
        'Obesity: BMI 30 or greater'
      ]
    },
    {
      'category': 'Healthy Eating Tips',
      'icon': Icons.restaurant,
      'items': [
        'Eat plenty of fruits and vegetables',
        'Choose whole grains over refined grains',
        'Limit processed foods and sugary drinks',
        'Control portion sizes',
        'Stay hydrated with water'
      ]
    },
    {
      'category': 'Exercise Recommendations',
      'icon': Icons.fitness_center,
      'items': [
        '150 minutes of moderate aerobic activity weekly',
        'Strength training 2-3 times per week',
        'Include flexibility and balance exercises',
        'Start slowly and gradually increase intensity',
        'Find activities you enjoy'
      ]
    },
    {
      'category': 'Lifestyle Changes',
      'icon': Icons.psychology,
      'items': [
        'Get adequate sleep (7-9 hours)',
        'Manage stress through relaxation techniques',
        'Keep a food and exercise diary',
        'Set realistic goals',
        'Seek support from friends and family'
      ]
    },
    {
      'category': 'Weight Management',
      'icon': Icons.monitor_weight,
      'items': [
        'Aim for 1-2 pounds weight loss per week',
        'Create a sustainable calorie deficit',
        'Combine diet and exercise',
        'Monitor progress regularly',
        'Focus on long-term habits'
      ]
    }
  ];

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
        curve: Curves.easeIn,
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
        title: Text('Health Tips & Information'),
        centerTitle: true,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF0A0E21),
                Color(0xFF1D1E33),
              ],
            ),
          ),
          child: ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: tips.length,
            itemBuilder: (context, index) {
              return TweenAnimationBuilder(
                duration: Duration(milliseconds: 800 + (index * 100)),
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
                child: _buildTipCard(tips[index]),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add functionality to save or bookmark tips
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Tips saved to favorites!'),
              backgroundColor: Colors.green,
            ),
          );
        },
        label: Text('Save Tips'),
        icon: Icon(Icons.bookmark),
        backgroundColor: Colors.red,
      ),
    );
  }

  Widget _buildTipCard(Map<String, dynamic> tipData) {
    return CustomContainer(
      colour: Color(0xFF1D1E33).withOpacity(0.7),
      Customchild: ExpansionTile(
        leading: Icon(
          tipData['icon'] as IconData,
          color: Colors.red,
          size: 30,
        ),
        title: Text(
          tipData['category'],
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: (tipData['items'] as List<String>).map((tip) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          tip,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
