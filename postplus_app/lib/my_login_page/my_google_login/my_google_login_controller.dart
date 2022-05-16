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
          "first_name": authenticatedUser.user!.displayName!.split(' ')[0],
          "last_name": authenticatedUser.user!.displayName!.split(' ')[1],
          "token": "",
          "profile_picture": "https://scontent.fbfh3-3.fna.fbcdn.net/v/t1.18169-9/10401972_472787482918821_4958068379902033714_n.jpg?_nc_cat=100&ccb=1-6&_nc_sid=09cbfe&_nc_eui2=AeFnl0sjJ1Zde5ZGN7xtgP5dR-_BvQwHR7tH78G9DAdHu0G17qPMMRQMZec8NNt8GbGYgIc2uG1iS2WVdI_QC1yF&_nc_ohc=PjNjg4QP1D0AX8xqrxL&_nc_ht=scontent.fbfh3-3.fna&oh=00_AT-zvWpoFdWWLt3d4OA2URUDUiXrwppc4U1iPyBvYpF6Wg&oe=62A1207A",
          "biography": "",
          "followers": [],
          "following": [],
          "username": authenticatedUser.user!.displayName!.toLowerCase().replaceAll(' ', '')
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
