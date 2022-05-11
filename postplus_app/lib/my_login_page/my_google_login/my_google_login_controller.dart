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

      final currentUser = FirebaseFirestore.instance
          .collection("users")
          .doc(authenticatedUser.user!.uid)
          .get();

      (currentUser == null)
          ? FirebaseFirestore.instance
              .collection("users")
              .doc(authenticatedUser.user!.uid)
              .set(
              {
                "id": authenticatedUser.user!.uid,
                "email": authenticatedUser.user!.email,
                "firstname": authenticatedUser.user!.displayName!.split(' ')[0],
                "lastname": authenticatedUser.user!.displayName!.split(' ')[1],
                "token": "",
                "profile_picture": "",
                "pictures": [],
                "followers": [],
                "following": [],
              },
            )
          : null;
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
