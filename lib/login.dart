import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  Widget _buildGradientField({
    required String hint,
    bool obscure = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF00C6FF), Color(0xFF0072FF)],
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.all(2),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
        ),
        child: TextField(
          obscureText: obscure,
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildGradientButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF00C6FF), Color(0xFF0072FF)],
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
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
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/images/procareerlogo.png',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),

                      // Page title
                      const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00AEEF),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Email field
                      _buildGradientField(hint: 'Enter your email'),
                      const SizedBox(height: 16),

                      // Password field
                      _buildGradientField(
                        hint: 'Enter your password',
                        obscure: true,
                      ),
                      const SizedBox(height: 32),

                      // Login button
                      _buildGradientButton(
                        text: 'Login',
                        onPressed: () {
                          // TODO: handle login
                        },
                      ),
                      const SizedBox(height: 16),

                      // Forgot password
                      GestureDetector(
                        onTap: () {
                          // TODO: navigate to forgot-password flow
                        },
                        child: const Text(
                          'Forget Password?',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
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
