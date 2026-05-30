import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  final stateController = TextEditingController();
  final districtController = TextEditingController();

  final cropController = TextEditingController();
  final farmSizeController = TextEditingController();

  final languageController = TextEditingController();

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    stateController.dispose();
    districtController.dispose();
    cropController.dispose();
    farmSizeController.dispose();
    languageController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> registerUser() async {
    if (nameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        phoneController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all required fields"),
        ),
      );
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Passwords do not match"),
        ),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      'name',
      nameController.text.trim(),
    );

    await prefs.setString(
      'email',
      emailController.text.trim(),
    );

    await prefs.setString(
      'phone',
      phoneController.text.trim(),
    );

    await prefs.setString(
      'state',
      stateController.text.trim(),
    );

    await prefs.setString(
      'district',
      districtController.text.trim(),
    );

    await prefs.setString(
      'crop',
      cropController.text.trim(),
    );

    await prefs.setString(
      'farmSize',
      farmSizeController.text.trim(),
    );

    await prefs.setString(
      'language',
      languageController.text.trim(),
    );

    await prefs.setString(
      'password',
      passwordController.text.trim(),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Registered Successfully"),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8F3),
      appBar: AppBar(
        title: const Text("Create Account"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            buildField(
              nameController,
              "Full Name",
              Icons.person,
            ),
            buildField(
              emailController,
              "Email",
              Icons.email,
            ),
            buildField(
              phoneController,
              "Phone Number",
              Icons.phone,
            ),
            buildField(
              stateController,
              "State",
              Icons.map,
            ),
            buildField(
              districtController,
              "District",
              Icons.location_city,
            ),
            buildField(
              cropController,
              "Primary Crop",
              Icons.grass,
            ),
            buildField(
              farmSizeController,
              "Farm Size (Acres)",
              Icons.agriculture,
            ),
            buildField(
              languageController,
              "Preferred Language",
              Icons.language,
            ),
            buildField(
              passwordController,
              "Password",
              Icons.lock,
              obscure: true,
            ),
            buildField(
              confirmPasswordController,
              "Confirm Password",
              Icons.lock_outline,
              obscure: true,
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: registerUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Already have an account? Login",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildField(
    TextEditingController controller,
    String label,
    IconData icon, {
    bool obscure = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
