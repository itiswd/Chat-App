import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:himochat/helper/snackBar.dart';
import 'package:himochat/pages/signup.dart';
import 'package:himochat/widgets/constant.dart';
import 'package:himochat/widgets/containerbutton.dart';
import 'package:himochat/widgets/textfield.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      progressIndicator: CircularProgressIndicator(
        color: primaryColor,
      ),
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/chat.png',
                  ),
                  const Text(
                    'Himo Chat',
                    style: TextStyle(
                      fontSize: 32,
                      fontFamily: 'Pacifico',
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  MainTextField(
                    obscure: false,
                    onChanged: (data) {
                      email = data;
                    },
                    hintText: 'Email',
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  MainTextField(
                    obscure: true,
                    onChanged: (data) {
                      password = data;
                    },
                    hintText: 'Password',
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ContainerButton(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        try {
                          // await loginUser();
                          // ignore: use_build_context_synchronously
                          Navigator.pushNamed(
                            context,
                            'chatPage',
                            arguments: email,
                          );
                        } on FirebaseAuthException catch (ex) {
                          if (ex.code == 'user-not-found') {
                            snackBar(context, 'User not found.');
                          } else if (ex.code == 'wrong-password') {
                            snackBar(context, 'Wrong password');
                          }
                        } catch (ex) {
                          snackBar(context, 'There is something wrong!');
                        }
                      }
                      isLoading = false;
                      setState(() {});
                    },
                    buttonText: 'Log In',
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Dont have an account ?..',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const SignUp();
                              },
                            ),
                          );
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
