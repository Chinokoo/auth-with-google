import 'package:auth_with_google/components/input_field.dart';
import 'package:auth_with_google/components/login_button.dart';
import 'package:auth_with_google/services/aunthentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    //forgot email controller
    TextEditingController forgotEmailController = TextEditingController();

    // forgot password function
    void forgotPassword() async {
      await AuthService()
          .forgotPassword(email: forgotEmailController.text)
          .then((value) {
        Fluttertoast.showToast(
            msg: "Reset link sent to your email",
            textColor: Colors.white,
            backgroundColor: Colors.green);
      }).onError((error, stackTrace) {
        Fluttertoast.showToast(
            msg: "$error",
            textColor: Colors.white,
            backgroundColor: Colors.red);
      });
    }

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: SvgPicture.asset('assets/svg/forgot_password.svg'),
          ),
          const Text(
            "Forgot your Password ?",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          //size box for spacing
          const SizedBox(height: 20),
          //forgot email input field
          InputField(
              obscureText: false,
              hintText: "Enter Your Email",
              textEditingController: forgotEmailController,
              iconData: Icons.mail),
          //size box for spacing
          const SizedBox(height: 20),
          //reset password button
          LoginButton(buttonText: "Send Reset Link", onTap: forgotPassword)
        ]),
      ),
    );
  }
}
