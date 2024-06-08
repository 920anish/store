import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:store/components/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth for authentication

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 40),
            Text(
              'Forgot your password?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Enter your email address and we will send you instructions on how to reset your password.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            ForgotPasswordForm(), // Use the modified form
          ],
        ),
      ),
    );
  }
}

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool _isButtonDisabled = true;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              hintText: 'Enter your email',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email),
            ),
            validator: _validateEmail,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: _updateButtonState,
          ),
          const SizedBox(height: 20),
          CustomButton(
            text: 'Submit',
            onPressed: _isButtonDisabled ? null : _submitForm,
          ),
        ],
      ),
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegExp = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  void _updateButtonState(String value) {
    setState(() {
      _isButtonDisabled = _validateEmail(value) != null;
    });
  }

  void _submitForm() {
    final email = _emailController.text.trim();
    final currentContext = context;

    if (_formKey.currentState!.validate()) {
      try {
        FirebaseAuth.instance.sendPasswordResetEmail(email: email)
            .then((_) {
          ScaffoldMessenger.of(currentContext).showSnackBar(
            const SnackBar(content: Text(
                'Password reset instructions sent to your email')),
          );
        }).catchError((error) {
          if (kDebugMode) {
            print('Failed to send reset email: $error');
          }
          ScaffoldMessenger.of(currentContext).showSnackBar(
            const SnackBar(content: Text(
                'Failed to send reset email. Please try again later')),
          );
        });
      } catch (e) {
        if (kDebugMode) {
          print('Failed to send reset email: $e');
        }
        ScaffoldMessenger.of(currentContext).showSnackBar(
          const SnackBar(content: Text(
              'Failed to send reset email. Please try again later')),
        );
      }
    }
  }
}