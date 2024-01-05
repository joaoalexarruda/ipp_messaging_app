import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthGoogle {
  // Sign in with Google
  signInWithGoogle() async {
    // Sign in process
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Get authentication details from request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create credentials
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    String? email = googleUser.email;
    String? id = googleUser.id;

    Future<void> createUserDocument(UserCredential? userCredential) async {
      if (userCredential != null && userCredential.user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.email)
            .set({
          'email': email,
          'uid': id,
        });
      }
    }

    createUserDocument(
      await FirebaseAuth.instance.signInWithCredential(credential),
    );
  }
}
