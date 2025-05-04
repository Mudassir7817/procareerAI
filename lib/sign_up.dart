import 'package:flutter/material.dart';
import 'package:procareer_ai/login.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  Widget _buildTextField({
    required IconData icon,
    required String hint,
    bool obscure = false,
  }) {
    return TextField(
      obscureText: obscure,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.grey[700]),
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required String asset,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(asset, width: 24, height: 24),
            const SizedBox(width: 12),
            Text(text, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/loginPage_bg.png',
              fit: BoxFit.fill,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: FractionallySizedBox(
                widthFactor: size.width < 600 ? 0.9 : 0.5,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo & Title
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/images/procareerlogo.png',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 24,
                              color: Color(0xFF00AEEF),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Input fields
                      _buildTextField(
                          icon: Icons.person, hint: 'Enter Your Full Name'),
                      const SizedBox(height: 16),
                      _buildTextField(icon: Icons.email, hint: 'Email'),
                      const SizedBox(height: 16),
                      _buildTextField(
                          icon: Icons.lock, hint: 'Password', obscure: true),
                      const SizedBox(height: 16),
                      _buildTextField(
                          icon: Icons.school, hint: 'Education level'),
                      const SizedBox(height: 16),
                      _buildTextField(
                          icon: Icons.work,
                          hint: 'Describe your work Experience'),
                      const SizedBox(height: 16),
                      _buildTextField(
                          icon: Icons.lightbulb_outline,
                          hint: 'Select your field of interest'),
                      const SizedBox(height: 32),

                      // Sign Up button
                      GestureDetector(
                        onTap: () {
                          // TODO: handle sign-up logic
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF00E4FF),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Center(
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Already have account
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => LoginPage()));
                        },
                        child: const Text(
                          'Already have an account? Sign In',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Divider
                      const Divider(thickness: 1),
                      const SizedBox(height: 16),

                      // Social buttons
                      _buildSocialButton(
                        asset: 'assets/images/googlelogo.png',
                        text: 'Sign In with Google',
                        onTap: () {
                          // TODO: google auth
                        },
                      ),
                      _buildSocialButton(
                        asset: 'assets/images/linkedinlogo.png',
                        text: 'Sign In with LinkedIn',
                        onTap: () {
                          // TODO: linkedin auth
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
