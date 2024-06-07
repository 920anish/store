import 'package:flutter/material.dart';
import 'package:store/components/custom_button.dart';
import 'package:store/routes.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {});
  }

  void _validateAndSubmit() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(context, AppRoutes.home);
      // Implement login functionality
    } else {
      if (_emailController.text.isEmpty || !_isEmailValid(_emailController.text)) {
        FocusScope.of(context).requestFocus(_emailFocusNode);
      } else if (_passwordController.text.isEmpty) {
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      }
    }
  }

  bool _isEmailValid(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    bool isFormValid = _isEmailValid(_emailController.text) && _passwordController.text.isNotEmpty;

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _emailController,
            focusNode: _emailFocusNode,
            decoration: InputDecoration(
              labelText: 'Email',
              hintText: 'Enter your email',
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.email),
              errorText: !_isEmailValid(_emailController.text) && _emailController.text.isNotEmpty
                  ? 'Please enter a valid email'
                  : null,
            ),
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              } else if (!_isEmailValid(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_passwordFocusNode);
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _passwordController,
            focusNode: _passwordFocusNode,
            obscureText: _obscureText,
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'Enter your password',
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.password),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
              errorText: _passwordController.text.isEmpty && _passwordController.text.isNotEmpty
                  ? 'Please enter your password'
                  : null,
            ),
            textInputAction: TextInputAction.done,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
            onFieldSubmitted: (_) {
              _validateAndSubmit();
            },
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // Implement "Forgot Password?" functionality
              },
              child: const Text('Forgot Password?'),
            ),
          ),
          const SizedBox(height: 20),
          CustomButton(
            onPressed: isFormValid ? _validateAndSubmit : null,
            text: 'Login',
          ),
        ],
      ),
    );
  }
}
