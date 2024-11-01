import 'package:auth_with_google/components/login_button.dart';
import 'package:auth_with_google/pages/login_page.dart';
import 'package:auth_with_google/services/aunthentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //sign out function
  void _signOut() async {
    await AuthService().signOut();
    await AuthService().signOutWithGoogle();
    if (!mounted) return;
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: SvgPicture.asset('assets/svg/welcome.svg'),
          ),
          const Text(
            "Successfully Logged In!",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Image.network("${snapshot.data?.photoURL}");
                  Text("${snapshot.data?.displayName}");
                }
                if (snapshot.hasError) {
                  Text("${snapshot.error}");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Text("${snapshot.data?.email}");
              }),

          //sized box for spacingh
          const SizedBox(height: 20),
          //logout button
          LoginButton(buttonText: "Log Out", onTap: _signOut)
        ],
      ),
    ));
  }
}
