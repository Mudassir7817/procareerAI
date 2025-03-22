import 'dart:developer';
import 'package:flutter/material.dart';

class RecommendationScreen01 extends StatelessWidget {
  final List<String> careers;
  final List<String> courses;

  const RecommendationScreen01({
    super.key,
    required this.careers,
    required this.courses,
  });

  @override
  Widget build(BuildContext context) {
    log("Careers received: $careers");
    log("Courses received: $courses");

    const Color topBarColor = Color(0xFF9BB9F3);
    const Color bodyBgColor = Color(0xFFAEC8FF);
    const Color footerColor = Color(0xFF5C82FF);
    const Color listContainerColor = Colors.white;
    const Color tileBgColor = Color(0xFFE8E8E8);
    const Color buttonBgColor = Color(0xFFFFFF66);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: topBarColor,
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/images/procareerlogo.png',
              height: 60,
              width: 130,
            ),
            const SizedBox(width: 8),
          ],
        ),
        actions: [
          _buildNavButton('Home', onPressed: () {}),
          _buildNavButton('Features', onPressed: () {}),
          _buildNavButton('Contact Us', onPressed: () {}),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section
            Stack(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/recommendationpage01bg.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'RECOMMENDATION',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Text(
                            'Discover the best career paths, courses, and universities tailored to your interests and skills',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 14, color: Colors.black87),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttonBgColor,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text('Get Recommendation'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Body
            Container(
              width: double.infinity,
              color: bodyBgColor,
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Column(
                children: [
                  // Careers
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: listContainerColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'List of Careers:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (careers.isEmpty)
                          const Text("No careers found.")
                        else
                          for (String c in careers) _careerTile(c),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Courses
                  Container(
                    width: double.infinity,
                    color: topBarColor,
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Suggested Courses',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back_ios),
                              color: Colors.white,
                              onPressed: () {},
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: courses.isNotEmpty
                                      ? courses
                                          .map(
                                              (course) => _carouselCard(course))
                                          .toList()
                                      : [_carouselCard("No Courses Found")],
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.arrow_forward_ios),
                              color: Colors.white,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Footer
            Container(
              width: double.infinity,
              color: const Color(0xFF5C82FF),
              padding: const EdgeInsets.all(12),
              child: const Center(
                child: Text(
                  '© 2024 ProCareerAI. All rights reserved.',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavButton(String text, {required VoidCallback onPressed}) {
    return TextButton(
      onPressed: onPressed,
      child:
          Text(text, style: const TextStyle(color: Colors.black, fontSize: 16)),
    );
  }

  Widget _careerTile(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFE8E8E8),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          title,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ),
    );
  }

  Widget _carouselCard(String text) {
    return Container(
      width: 120,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 4)),
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
