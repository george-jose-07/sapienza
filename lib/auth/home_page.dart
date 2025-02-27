import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title, required this.apiKey});

  final String title;
  final String apiKey;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _form = GlobalKey<FormState>();
  var _isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Animate(
                    child: Text(
                      "SAPIENZA AI",
                      style: TextStyle(
                          fontSize: 55,
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.bold),
                    )
                        .animate(onPlay: (controller) => controller.repeat())
                        .shimmer(
                            duration: 3.seconds,
                            delay: 2000.ms,
                            color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 30,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2.5,
                            color:
                                Theme.of(context).colorScheme.primaryContainer),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2.5,
                            color:
                                Theme.of(context).colorScheme.primaryContainer),
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty ||
                          !value.contains('@')) {
                        return 'Please enter a valid email address.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                    },
                  ),
                ),
                if (!_isLogin)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.trim().length < 4) {
                          return 'Please enter a valid username.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Username',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 2.5,
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 2.5,
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer),
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      enableSuggestions: false,
                      onSaved: (value) {
                      },
                    ),
                  ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2.5,
                            color:
                                Theme.of(context).colorScheme.primaryContainer),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2.5,
                            color:
                                Theme.of(context).colorScheme.primaryContainer),
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.trim().length < 6) {
                        return 'Password must be at least 6 characters long.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                    },
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: Text(
                    _isLogin ? 'Log in' : 'Sign Up',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isLogin = !_isLogin;
                    });
                  },
                  child: Text(_isLogin
                      ? 'Create an Account'
                      : 'already have an account'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
