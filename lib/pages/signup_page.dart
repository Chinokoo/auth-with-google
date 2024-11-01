import 'package:auth_with_google/components/input_field.dart';
import 'package:auth_with_google/components/login_button.dart';
import 'package:auth_with_google/pages/home_page.dart';
import 'package:auth_with_google/pages/login_page.dart';
import 'package:auth_with_google/services/aunthentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  //name controller
  TextEditingController nameController = TextEditingController();
  //email controller
  TextEditingController emailController = TextEditingController();
  //password controller
  TextEditingController passwordController = TextEditingController();
  //isLoading
  bool isLoading = false;

  //sign up function
  void signUp() async {
    try {
      isLoading = true;
      await AuthService().signUpWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
          name: nameController.text);
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
        msg: "Account created successfully",
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
      );
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()));
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
                height: height / 2.1,
                child: SvgPicture.asset(
                  'assets/svg/sign_up.svg',
                ),
              ),
              //login form
              //name
              InputField(
                hintText: "Name",
                textEditingController: nameController,
                obscureText: false,
                iconData: Icons.person,
              ),
              //size box for spacing
              const SizedBox(
                height: 20,
              ),
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
              //size box for spacing
              const SizedBox(
                height: 20,
              ),
              //login button
              LoginButton(
                  buttonText: isLoading ? "Signing Up..." : "Sign Up",
                  onTap: signUp),
              //sized box for spacing
              SizedBox(
                height: height / 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    },
                    child: const Text(
                      "log in",
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
