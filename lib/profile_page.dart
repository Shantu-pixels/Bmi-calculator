import 'package:flutter/material.dart';
import 'customcontainer.dart';
import 'tips_screen.dart';

class ProfilePage extends StatefulWidget {
  final String bmiResult;
  final int height;
  final int weight;

  const ProfilePage({
    Key? key,
    required this.bmiResult,
    required this.height,
    required this.weight,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

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
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile Picture
                Hero(
                  tag: 'profile_picture',
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.red,
                    child: Icon(
                      Icons.person,
                      size: 80,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 24),

                // Name
                Text(
                  'John Doe',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),

                Text(
                  'Fitness Enthusiast',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 24),

                // Stats Cards
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard('Height', '${widget.height} cm'),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _buildStatCard('Weight', '${widget.weight} kg'),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard('BMI', widget.bmiResult),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _buildStatCard('Age', '25 yrs'),
                    ),
                  ],
                ),
                SizedBox(height: 24),

                // Add this button just before the Additional Information section
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TipsScreen(),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 16),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.lightbulb, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'View Health Tips',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Additional Information
                CustomContainer(
                  colour: Color(0xFF1D1E33),
                  Customchild: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoRow(Icons.favorite, 'Goal', 'Weight Loss'),
                        SizedBox(height: 16),
                        _buildInfoRow(
                            Icons.fitness_center, 'Activity Level', 'Moderate'),
                        SizedBox(height: 16),
                        _buildInfoRow(Icons.local_fire_department,
                            'Daily Calories', '2000 kcal'),
                        SizedBox(height: 16),
                        _buildInfoRow(
                            Icons.water_drop, 'Water Intake', '2.5 L'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value) {
    return CustomContainer(
      colour: Color(0xFF1D1E33),
      Customchild: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.red),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
