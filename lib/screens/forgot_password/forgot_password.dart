import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:store/components/custom_button.dart';
import '../../routes.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (bool didPop) {
        if (didPop) {
          // Navigate back to the login screen after a short delay
          Future.delayed(Duration.zero, () {
            Navigator.pushReplacementNamed(context, AppRoutes.login);
          });
        }
      },
      child: Scaffold(
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
              ForgotPasswordForm(),
            ],
          ),
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
  String? _statusMessage;
  Color? _statusColor;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_updateButtonState);
  }

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
            autovalidateMode: AutovalidateMode.disabled,
          ),
          const SizedBox(height: 20),
          CustomButton(
            text: 'Submit',
            onPressed: _isButtonDisabled ? null : _submitForm,
          ),
          const SizedBox(height: 20),
          if (_statusMessage != null)
            Text(
              _statusMessage!,
              style: TextStyle(
                color: _statusColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
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

  void _updateButtonState() {
    setState(() {
      _isButtonDisabled = _validateEmail(_emailController.text) != null;
      _statusMessage = null;
      _statusColor = null;
    });
  }

  void _submitForm() async {
    final email = _emailController.text.trim();

    if (_formKey.currentState!.validate()) {
      await _resetPassword(email);
      setState(() {
        _emailController.clear();
        _isButtonDisabled = true;
      });
    }
  }

  Future<void> _resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      showSnackBar('Password reset instructions sent to your email');
    } on FirebaseAuthException catch (e) {
      showSnackBar('Failed to send reset email. Please try again later.');
      if (kDebugMode) {
        print('Failed to send reset email: $e');
      }
    } catch (e) {
      showSnackBar('Failed to send reset email. Please try again later.');
      if (kDebugMode) {
        print('Failed to send reset email: $e');
      }
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}