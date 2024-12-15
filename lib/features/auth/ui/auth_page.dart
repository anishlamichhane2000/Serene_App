import 'package:flutter/material.dart';
import 'package:serene_app/features/auth/bloc/auth_bloc.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String fName = '';
  String lName = '';
  bool isLogin = true;

  changeIsLoginValue() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  AuthBloc authBloc = AuthBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login/SignUp'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            children: [
              if (!isLogin)
                TextFormField(
                  key: const ValueKey('first_name'),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: 'Enter First Name'),
                  validator: (val) {
                    if (val == null || val.isEmpty || val.length < 2) {
                      return 'Please Enter a Valid First Name';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    setState(() {
                      fName = val ?? '';
                    });
                  },
                ),
              if (!isLogin)
                TextFormField(
                  key: const ValueKey('last_name'),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: 'Enter Last Name'),
                  validator: (val) {
                    if (val == null || val.isEmpty || val.length < 2) {
                      return 'Please Enter a Valid Last Name';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    setState(() {
                      lName = val ?? '';
                    });
                  },
                ),
              TextFormField(
                key: const ValueKey('email'),
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email), hintText: 'Enter Email'),
                validator: (val) {
                  if (val == null || val.isEmpty || !val.contains('@')) {
                    return 'Please Enter a Valid Email';
                  }
                  return null;
                },
                onSaved: (val) {
                  setState(() {
                    email = val ?? '';
                  });
                },
              ),
              TextFormField(
                key: const ValueKey('password'),
                obscureText: true,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.security),
                    hintText: 'Enter Password'),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Password cannot be empty';
                  }
                  if (val.length < 8) {
                    return 'Password must be at least 8 characters long';
                  }
                  if (!RegExp(r'[A-Z]').hasMatch(val)) {
                    return 'Password must contain at least one uppercase letter';
                  }
                  if (!RegExp(r'[a-z]').hasMatch(val)) {
                    return 'Password must contain at least one lowercase letter';
                  }
                  if (!RegExp(r'\d').hasMatch(val)) {
                    return 'Password must contain at least one number';
                  }
                  if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(val)) {
                    return 'Password must contain at least one special character (!@#\$%^&*(),.?":{}|<>)';
                  }
                  return null;
                },
                onSaved: (val) {
                  setState(() {
                    password = val ?? '';
                  });
                },
              ),
              const SizedBox(height: 40),
              SizedBox(
                  width: double.maxFinite,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          isLogin
                              ? authBloc.add(AuthSignInEvent(
                                  email: email, password: password))
                              : authBloc.add(AuthSignUpEvent(
                                  email: email,
                                  password: password,
                                  fName: fName,
                                  lastName: lName));
                        }
                      },
                      child: Text(isLogin ? "Login" : "SignUp"))),
              TextButton(
                  onPressed: () => changeIsLoginValue(),
                  child: isLogin
                      ? const Text("Don't have an account? SignUp")
                      : const Text('Already have an account? Login'))
            ],
          ),
        ),
      ),
    );
  }
}
