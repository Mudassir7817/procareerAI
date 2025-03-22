import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

class SkillsGapScreen extends StatefulWidget {
  const SkillsGapScreen({super.key});

  @override
  _SkillsGapScreenState createState() => _SkillsGapScreenState();
}

class _SkillsGapScreenState extends State<SkillsGapScreen> {
  // Displayed name of the selected PDF file
  String selectedFileName = "No file selected";

  // Lists to display in the skill cards
  List<String> skillsYouHave = [];
  List<String> skillsYouNeedToLearn = [];

  // 1) Let user pick a PDF file
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        selectedFileName = result.files.single.name;
      });

      // 2) Upload the selected PDF to the backend for analysis
      final filePath = result.files.single.path;
      await _uploadFileToBackend(filePath);
    }
  }

  // 2) Upload PDF to Flask /analyzeCV
  Future<void> _uploadFileToBackend(String? filePath) async {
    if (filePath == null) return;

    try {
      // For Android emulator, use 10.0.2.2. Otherwise, 127.0.0.1 or your machine's IP.
      final uri = Uri.parse("http://10.0.2.2/analyzeCV");
      var request = http.MultipartRequest("POST", uri);

      // Attach the PDF file
      request.files.add(
        await http.MultipartFile.fromPath("file", filePath),
      );

      // Send the request
      var response = await request.send();

      if (response.statusCode == 200) {
        // Parse JSON response
        String responseBody = await response.stream.bytesToString();
        final data = jsonDecode(responseBody);

        // Update state with the skills from backend
        setState(() {
          skillsYouHave = List<String>.from(data["skills_you_have"] ?? []);
          skillsYouNeedToLearn =
              List<String>.from(data["skills_you_need_to_learn"] ?? []);
        });
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception uploading file: $e");
    }
  }

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
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/skillgapidentifierbg.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          // Main content
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // CV Upload Section
                  DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(10),
                    dashPattern: const [6, 4],
                    color: Colors.black,
                    strokeWidth: 1.5,
                    child: Container(
                      width: 300,
                      height: 200,
                      color: Colors.white.withOpacity(0.8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Drop your CV here:",
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: _pickFile,
                            child: const Text("Upload CV (PDF)"),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            selectedFileName,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Skills You Have
                  _buildSkillCard("Skills You Have", skillsYouHave),
                  const SizedBox(height: 20),
                  // Skills You Need to Learn
                  _buildSkillCard(
                      "Skills You Need To Learn", skillsYouNeedToLearn),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Builds a skill card with dynamic skill list
  Widget _buildSkillCard(String title, List<String> skills) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          // Display the skill list
          if (skills.isEmpty)
            const Text("No skills found.", style: TextStyle(fontSize: 16))
          else
            Column(
              children: skills.map((skill) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Text("- $skill", style: const TextStyle(fontSize: 16)),
                );
              }).toList(),
            ),
        ],
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
