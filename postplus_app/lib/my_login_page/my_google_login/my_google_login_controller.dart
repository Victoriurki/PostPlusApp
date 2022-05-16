import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInController {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future<String> googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();

      if (googleUser == null) return "";

      _user = googleUser;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      final authenticatedUser =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final userId = authenticatedUser.user!.uid;

      final userDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .get();

      final doesExists = userDoc.exists;

      if (!doesExists) {
        FirebaseFirestore.instance
            .collection("users")
            .doc(authenticatedUser.user!.uid)
            .set({
          "_id": authenticatedUser.user!.uid,
          "email": authenticatedUser.user!.email,
          "firstname": authenticatedUser.user!.displayName!.split(' ')[0],
          "lastname": authenticatedUser.user!.displayName!.split(' ')[1],
          "token": "",
          "profile_picture": "",
          "biography": "",
          "pictures": [],
          "followers": [],
          "following": [],
        });
      }

      return authenticatedUser.user!.uid;
    } catch (e) {
      return "";
    }
  }

  Future logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
