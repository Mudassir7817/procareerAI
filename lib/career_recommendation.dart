import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:procareer_ai/career_recommendation_lvl_01.dart';

// for chrome: 127.0.0.1
// for emulator: 10.0.2.2
const String backendUrl = "http://10.0.2.2:5000/recommend";

class CareerRecommendationScreen extends StatefulWidget {
  const CareerRecommendationScreen({super.key});

  @override
  State<CareerRecommendationScreen> createState() =>
      _CareerRecommendationScreenState();
}

class _CareerRecommendationScreenState
    extends State<CareerRecommendationScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _qualificationController = TextEditingController();

  // Checkboxes
  bool _softwareEngineering = false;
  bool _artificialIntelligence = false;
  bool _dataScience = false;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _qualificationController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final String name = _nameController.text.trim();
      final String age = _ageController.text.trim();
      final String qualification = _qualificationController.text.trim();

      // Gather interests
      List<String> interests = [];
      if (_softwareEngineering) interests.add("Software Engineering");
      if (_artificialIntelligence) interests.add("Artificial Intelligence");
      if (_dataScience) interests.add("Data Science");

      // Build request body
      final Map<String, dynamic> requestBody = {
        "name": name,
        "age": age,
        "qualification": qualification,
        "interests": interests,
      };

      try {
        final response = await http.post(
          Uri.parse(backendUrl),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(requestBody),
        );

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);

          // Extract recommended careers using the new dataset.
          // We expect each career object to have a "career_name" key.
          List<dynamic> rawCareers = responseData["recommended_careers"] ?? [];
          List<String> recommendedCareers = rawCareers.map((item) {
            if (item is Map<String, dynamic>) {
              return item["career_name"]?.toString() ?? "Unknown";
            } else {
              return item.toString();
            }
          }).toList();

          // Extract recommended courses (using "course_name" key)
          List<dynamic> rawCourses = responseData["recommended_courses"] ?? [];
          List<String> recommendedCourses = rawCourses.map((item) {
            if (item is Map<String, dynamic>) {
              return item["course_name"]?.toString() ?? "Unknown";
            } else {
              return item.toString();
            }
          }).toList();

          if (context.mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RecommendationScreen01(
                  careers: recommendedCareers,
                  courses: recommendedCourses,
                ),
              ),
            );
          }
        } else {
          debugPrint("Error: ${response.statusCode} => ${response.body}");
        }
      } catch (e) {
        debugPrint("Exception: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color topBarColor = Color(0xFF9BB9F3);
    const Color footerColor = Color(0xFF9BB9F3);
    const Color formCardColor = Colors.white;
    const Color submitButtonColor = Color(0xFFFFFF66);
    const double cardWidth = 400;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: topBarColor,
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/images/procareerlogo.png',
              height: 40,
            ),
            const SizedBox(width: 10),
          ],
        ),
        actions: [
          _buildNavTextButton('Home', onPressed: () {}),
          _buildNavTextButton('Features', onPressed: () {}),
          _buildNavTextButton('Contact Us', onPressed: () {}),
          const SizedBox(width: 10),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/careerrecomendationbg.png'),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 80, horizontal: 20),
                    padding: const EdgeInsets.all(16),
                    width: cardWidth,
                    decoration: BoxDecoration(
                      color: formCardColor.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              'Career Recommendation',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFFFF00),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildLabel('Name:'),
                          const SizedBox(height: 4),
                          _buildTextField(
                            controller: _nameController,
                            hint: 'Enter Your Name',
                          ),
                          const SizedBox(height: 16),
                          _buildLabel('Age:'),
                          const SizedBox(height: 4),
                          _buildTextField(
                            controller: _ageController,
                            hint: 'Enter Your age',
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 16),
                          _buildLabel('Qualification:'),
                          const SizedBox(height: 4),
                          _buildTextField(
                            controller: _qualificationController,
                            hint: 'Enter Your qualification',
                          ),
                          const SizedBox(height: 16),
                          _buildLabel('Area Of Interest:'),
                          const SizedBox(height: 8),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              _buildCheckBox(
                                label: 'Software Engineering',
                                value: _softwareEngineering,
                                onChanged: (val) {
                                  setState(() {
                                    _softwareEngineering = val ?? false;
                                  });
                                },
                              ),
                              _buildCheckBox(
                                label: 'Artificial Intelligence',
                                value: _artificialIntelligence,
                                onChanged: (val) {
                                  setState(() {
                                    _artificialIntelligence = val ?? false;
                                  });
                                },
                              ),
                              _buildCheckBox(
                                label: 'Data Science',
                                value: _dataScience,
                                onChanged: (val) {
                                  setState(() {
                                    _dataScience = val ?? false;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: submitButtonColor,
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 50,
                                  vertical: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: _submitForm,
                              child: const Text('Submit'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  color: footerColor,
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  child: const Center(
                    child: Text(
                      '© 2024 ProCareerAI. All rights reserved.',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: (val) {
        if (val == null || val.trim().isEmpty) {
          return 'This field cannot be empty';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildCheckBox({
    required String label,
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          value: value,
          onChanged: onChanged,
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 14),
        ),
      ],
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
