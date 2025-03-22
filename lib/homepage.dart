import 'package:flutter/material.dart';
import 'package:procareer_ai/career_recommendation.dart';
import 'package:procareer_ai/skillgap_analysis.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color appBarColor = Color(0xFF9BB9F3);
    const Color headerColor = Color(0xFF9BB9F3);
    const Color mainBgColor = Color(0xFFE9ECFF);
    const Color textColor = Colors.white;

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
          _buildNavTextButton('Sign Up', onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: headerColor,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Column(
                children: [
                  const Text(
                    'AI - BOOSTED CAREER COACHING TOOLS',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Experience AI-Driven career counseling with specialist guidance\n'
                    'real-time insights and tools',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: textColor.withOpacity(0.9),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.yellow, // text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                    ),
                    onPressed: () {},
                    child: const Text('Try Now'),
                  ),
                ],
              ),
            ),
            Container(
              color: mainBgColor,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Column(
                children: [
                  const Text(
                    'EXPLORE OUR TOOLS',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    alignment: WrapAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CareerRecommendationScreen()));
                        },
                        child: ToolCard(
                          imageUrl: 'assets/images/careerRecommendation.png',
                          title: 'Career Recommendation',
                          description:
                              'Get Expert career advice instantly with personalized guidance tailored to your goals.',
                        ),
                      ),
                      ToolCard(
                        imageUrl: 'assets/images/careerTest.png',
                        title: 'Career Test',
                        description:
                            'Explore Personalized career paths with AI-Powered quizzes to find the best for you.',
                      ),
                      ToolCard(
                        imageUrl: 'assets/images/TrendingJobs.png',
                        title: 'Trending Jobs',
                        description:
                            'Practice real scenarios with feedback to refine your skills and boost your confidence.',
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SkillsGapScreen()));
                        },
                        child: ToolCard(
                          imageUrl: 'assets/images/skillgapidentifier.png',
                          title: 'Skill Gap Identifier',
                          description:
                              'Bridging the Gap Between Your Skills and Success.',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: headerColor,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: const Center(
                child: Text(
                  '© 2024 ProCareerAI. All rights reserved.',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
}

class ToolCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;

  const ToolCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Image.asset(
                imageUrl,
                height: 100,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
