import 'package:flutter/material.dart';

class TrendingJobsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const Color appBarColor = Color(0xFF9BB9F3);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/images/procareerlogo.png',
              height: 80,
              width: 80,
            ),
          ],
        ),
        actions: [
          _buildNavTextButton('Home', onPressed: () {}),
          _buildNavTextButton('Features', onPressed: () {}),
          _buildNavTextButton('Contact Us', onPressed: () {}),
        ],
      ),
      backgroundColor: Colors.blue[200],
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Trending Jobs',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    JobCard(
                        title: 'AI Developer',
                        skills:
                            'Python, Machine Learning Frameworks, Cloud Platforms'),
                    JobCard(
                        title: 'AI Developer',
                        skills:
                            'Python, Machine Learning Frameworks, Cloud Platforms'),
                    JobCard(
                        title: 'AI Developer',
                        skills:
                            'Python, Machine Learning Frameworks, Cloud Platforms'),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.blue[300],
            child: Center(
              child: Text(
                '© 2024 ProCareerAI. All rights reserved.',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class JobCard extends StatelessWidget {
  final String title;
  final String skills;

  JobCard({required this.title, required this.skills});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              'skills: $skills',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildNavTextButton(String label, {required VoidCallback onPressed}) {
  return TextButton(
    onPressed: onPressed,
    child: Text(
      label,
      style: const TextStyle(color: Colors.white),
    ),
  );
}
