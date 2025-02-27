import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sapienza1/auth/signup_screen.dart';

final _firebase = FirebaseAuth.instance;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final form = GlobalKey<FormState>();
    var enteredEmail = '';
    var enteredPassword = '';
    var _isAuthenticating = false;

    void _submit() async {
      final isValid = form.currentState!.validate();
      if (!isValid) {
        //show error
        return;
      }
      form.currentState!.save();
      try {
        setState(() {
          _isAuthenticating = true;
        });
        final userCredentials = await _firebase.signInWithEmailAndPassword(
          email: enteredEmail,
          password: enteredPassword,
        );
        print(userCredentials);
      } on FirebaseAuthException catch (error) {
        if (error.code == 'email-already-in-use') {
          //....
        }
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message ?? 'Authentication failed'),
          ),
        );
        setState(() {
          _isAuthenticating = false;
        });
      }
    }

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage(
            'assets/images/dark.jpg',
          ),
          fit: BoxFit.cover,
          //invertColors: isDarkMode ? false : true,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            /////////// ******* BackGround Section ****** //////////
            Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(30)),
                          gradient: LinearGradient(colors: [
                            Color(0xff48c6f9),
                            Color(0xff58e0aa),
                          ]),
                        ),
                      ),
                      Positioned(
                        left: -100,
                        top: -50,
                        child: Container(
                          height: MediaQuery.sizeOf(context).height * 0.55,
                          width: MediaQuery.sizeOf(context).width + 20,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Color(0xff1578f8),
                                Color(0xff44c5ff),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Welcome!",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 400,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white.withOpacity(0.1),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaY: 20, sigmaX: 20),
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: Form(
                          key: form,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Spacer(),
                              const Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      color: Colors.white),
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                "Email",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.white),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                alignment: Alignment.center,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(color: Colors.white)),
                                child: TextFormField(
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                    suffixIcon: Icon(
                                      Icons.mail,
                                      color: Color(0xff4ac8f4),
                                    ),
                                    fillColor: Colors.white,
                                    border: InputBorder.none,
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
                                    enteredEmail = value!;
                                  },
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                "Password",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.white),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                alignment: Alignment.center,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(color: Colors.white)),
                                child: TextFormField(
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                    suffixIcon: Icon(
                                      Icons.lock,
                                      color: Color(0xff4ac8f4),
                                    ),
                                    fillColor: Colors.white,
                                    border: InputBorder.none,
                                  ),
                                  obscureText: true,
                                  validator: (value) {
                                    if (value == null ||
                                        value.trim().length < 6) {
                                      return 'Password must be at least 6 characters long.';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    enteredPassword = value!;
                                  },
                                ),
                              ),
                              const Spacer(),
                              const Spacer(),
                              InkWell(
                                onTap: _submit,
                                child: Container(
                                  height: 40,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: const Color(0xff5bdeac),
                                      borderRadius: BorderRadius.circular(30)),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    "Log In",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Center(
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpScreen(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Create an Account',
                                    style: TextStyle(
                                      color: Color(0xff1576fc),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
