import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:store/components/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
            Navigator.pushNamed(context, AppRoutes.login);
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
  DateTime? _lastEmailSentTime;
  Timer? _timer;
  String? _statusMessage;
  Color? _statusColor;

  @override
  void dispose() {
    _emailController.dispose();
    _timer?.cancel();
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

  void _updateButtonState(String value) {
    if (_lastEmailSentTime == null || DateTime.now().difference(_lastEmailSentTime!).inMinutes >= 1) {
      setState(() {
        _isButtonDisabled = _validateEmail(value) != null;
      });
    }
  }

  void _submitForm() {
    final email = _emailController.text.trim();
    final currentContext = context;

    if (_formKey.currentState!.validate()) {
      if (_lastEmailSentTime == null || DateTime.now().difference(_lastEmailSentTime!).inMinutes >= 1) {
        try {
          FirebaseAuth.instance.sendPasswordResetEmail(email: email)
              .then((_) {
            _lastEmailSentTime = DateTime.now();
            _startTimer();
            ScaffoldMessenger.of(currentContext).showSnackBar(
              const SnackBar(content: Text(
                  'Password reset instructions sent to your email')),
            );
            setState(() {
              _statusMessage = 'Please wait 60 seconds before trying again.';
              _statusColor = Colors.blueGrey;
              _isButtonDisabled = true;
            });
          }).catchError((error) {
            if (kDebugMode) {
              print('Failed to send reset email: $error');
            }
            setState(() {
              _statusMessage = 'Failed to send reset email. Please try again later.';
              _statusColor = Colors.red;
            });
          });
        } catch (e) {
          if (kDebugMode) {
            print('Failed to send reset email: $e');
          }
          setState(() {
            _statusMessage = 'Failed to send reset email. Please try again later.';
            _statusColor = Colors.red;
          });
        }
      } else {
        final secondsLeft = 60 - DateTime.now().difference(_lastEmailSentTime!).inSeconds;
        setState(() {
          _statusMessage = 'Please wait $secondsLeft seconds before trying again.';
          _statusColor = Colors.orange;
        });
      }
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final secondsLeft = 60 - DateTime.now().difference(_lastEmailSentTime!).inSeconds;
      if (secondsLeft <= 0) {
        setState(() {
          _isButtonDisabled = _validateEmail(_emailController.text) != null;
          _statusMessage = null;
        });
        _timer?.cancel();
      } else {
        setState(() {
          _statusMessage = 'Please wait $secondsLeft seconds before trying again.';
        });
      }
    });
  }
}
