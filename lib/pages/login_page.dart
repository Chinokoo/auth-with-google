import 'package:auth_with_google/components/forgot_password.dart';
import 'package:auth_with_google/components/input_field.dart';
import 'package:auth_with_google/components/login_button.dart';
import 'package:auth_with_google/pages/forgot_password.dart';
import 'package:auth_with_google/pages/home_page.dart';
import 'package:auth_with_google/pages/signup_page.dart';
import 'package:auth_with_google/services/aunthentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //email controller
  TextEditingController emailController = TextEditingController();
  //password controller
  TextEditingController passwordController = TextEditingController();
  //is loading
  bool isLoading = false;

  //login function
  void login() async {
    try {
      isLoading = true;
      await AuthService()
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((value) {
        //push to home page
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomePage()));
        setState(() {
          isLoading = false;
        });
        if (!mounted) return;
        //show message
        Fluttertoast.showToast(
          msg: "logged in successfully",
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM,
        );
      }).onError((error, StackTrace) {
        Fluttertoast.showToast(
          msg: "$error",
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM,
        );
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
        msg: "$e",
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  //sign with google function
  void signInWithGoogle() async {
    try {
      isLoading = true;
      final result = await AuthService().signInWithGoogle();
      if (result != null) {
        Fluttertoast.showToast(
          msg: "log in with Google is successful",
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM,
        );
        if (!mounted) return;
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const HomePage(),
        ));
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      Fluttertoast.showToast(
        msg: "$e",
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            children: [
              //log in image
              SizedBox(
                height: height / 2.5,
                child: SvgPicture.asset(
                  'assets/svg/login.svg',
                ),
              ),
              //login form
              //email
              InputField(
                  textEditingController: emailController,
                  obscureText: false,
                  hintText: 'Email',
                  iconData: Icons.mail),
              //size box for spacing
              const SizedBox(
                height: 20,
              ),
              //password
              InputField(
                  textEditingController: passwordController,
                  obscureText: true,
                  hintText: "Password",
                  iconData: Icons.lock),
              //forgot password button
              ForgotPassword(
                textInput: "Forgot Password?",
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ForgotPasswordPage())),
              ),
              //login button
              LoginButton(
                  buttonText: isLoading ? "Logging In..." : "Log In",
                  onTap: login),
              //sized box for spacing
              const SizedBox(
                height: 20,
              ),
              //or text
              const Align(
                alignment: Alignment.center,
                child: Text(" or "),
              ),
              // divider
              const Divider(),
              //dont have an account text
              //sized box for spacing
              const SizedBox(
                height: 20,
              ),
              //continue with google
              LoginButton(
                  buttonText: "Continue with Google", onTap: signInWithGoogle),
              //sized box for spacing
              const SizedBox(
                height: 20,
              ),

              //sized box for spacing
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignupPage()));
                    },
                    child: const Text(
                      "sign up",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
