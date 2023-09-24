import 'package:flutter/material.dart';
import 'package:test/common/widgets/custom_elevatedbutton.dart';
import 'package:test/common/widgets/custom_textbutton.dart';
import 'package:test/common/widgets/custom_textfield.dart';
// import 'package:test/constants/utils.dart';
import 'package:test/features/auth/screens/sign_up.dart';
import 'package:test/features/auth/services/auth_service.dart';

class MyLogin extends StatefulWidget {
  static const String routeName = '/login';
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() {
    return _MyLoginState();
  }
}

class _MyLoginState extends State<MyLogin> {
  final AuthService authService = AuthService();

  //controller for the textfield
  final TextEditingController _emailContoller = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //form is used to get the current state of the field that is used to validate the input for form validation
  final _signInFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailContoller.dispose();
    _passwordController.dispose();
  }

  void logInUser() {
    //form validation
    if (_signInFormKey.currentState!.validate()) {
      authService.lognInUser(
        context: context,
        email: _emailContoller.text,
        password: _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // we dont get background image properties in the Scaffold() but we do get background properties in the Container()
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/login.png'),
          fit: BoxFit.cover, // to cover the screen
        )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 35, top: 110),
                child: const Text(
                  'Welcome \n to \n Bloodlink',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 33,
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.45,
                    right: 20,
                    left: 20,
                  ),
                  child: Form(
                    key: _signInFormKey,
                    child: Column(
                      children: [
                        // in the CustomTextField we need to pass the hintText and controller
                        CustomTextField(
                          controller: _emailContoller,
                          hintText: "Email",
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        CustomTextField(
                          controller: _passwordController,
                          hintText: "Password",
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        //SIGN IN buttion
                        CustomElevatedButton(
                          onTap: logInUser,
                          hintText: "Log In",
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Have existing account?',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 53, 53, 53),
                              ),
                            ),
                            CustomTextButton(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, MySignUp.routeName);
                              },
                              buttonText: "Sign Up",
                            ),
                            // CustomTextButton(
                            //   onTap: (){
                            //   },
                            //   buttonText:"Forgot Password?",
                            //   ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
