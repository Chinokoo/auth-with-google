import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final googleSignIn = GoogleSignIn();

  //signing up the user or registering the user
  Future<UserCredential> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String name}) async {
    try {
      // Register the user with email and password
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // Create a user document in Firestore
      await _firestore.collection('users').doc(credential.user!.uid).set({
        'uid': credential.user!.uid,
        'email': email,
        'name': name,
        'createdAt': Timestamp.now(),
      });
      return credential;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          throw 'The password provided is too weak.';
        case 'email-already-in-use':
          throw 'The account already exists for that email.';
        case 'invalid-email':
          throw 'The email address is invalid.';
        default:
          throw e.message ?? 'An undefined error occurred during sign up.';
      }
    }
  }

  //login with email and password
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          throw 'The email address is invalid.';
        case 'user-not-found':
          throw 'No user found for that email.';
        case 'wrong-password':
          throw 'The password is incorrect.';
        default:
          throw e.message ?? 'An undefined error occurred during sign in.';
      }
    }
  }

  //sign in with google
  Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      // User clicked back/canceled the sign-in flow
      if (googleSignInAccount == null) {
        return;
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);
      await _auth.signInWithCredential(authCredential);
    } on FirebaseAuthException catch (e) {
      throw e.message ??
          'An undefined error occurred during sign in with google.';
    }
  }

  //signing out with google
  Future<void> signOutWithGoogle() async {
    try {
      await googleSignIn.signOut();
    } on FirebaseAuthException catch (e) {
      throw e.message ??
          'An undefined error occurred during sign out with google.';
    }
  }

  //forgot password
  Future<void> forgotPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          throw 'The email address is invalid.';
        case 'user-not-found':
          throw 'No user found for that email.';
        default:
          throw e.message ??
              'An undefined error occurred while resetting your forgot password.';
      }
    }
  }

  //logout or sign out
  Future<void> signOut() async {
    //Sign out the user
    await _auth.signOut();
  }
}
