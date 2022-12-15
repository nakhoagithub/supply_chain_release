// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class FirebaseLogin {
//   FirebaseAuth? auth;
//   late GoogleSignIn googleSignIn;

//   FirebaseLogin({this.auth, required this.googleSignIn});

//   User? getCurrentUser() {
//     User? user = FirebaseAuth.instance.currentUser;
//     return user;
//   }

//   static void logout() async {
//     await FirebaseAuth.instance.signOut();
//     GoogleSignIn().signOut();
//   }

//   Future<User?> signup() async {
//     User? user;
//     final GoogleSignInAccount? googleSignInAccount =
//         await googleSignIn.signIn();
//     if (googleSignInAccount != null) {
//       final GoogleSignInAuthentication googleSignInAuthentication =
//           await googleSignInAccount.authentication;
//       final AuthCredential authCredential = GoogleAuthProvider.credential(
//           idToken: googleSignInAuthentication.idToken,
//           accessToken: googleSignInAuthentication.accessToken);

//       // Getting users credential
//       UserCredential result = await auth!.signInWithCredential(authCredential);
//       user = result.user;

//       return user;
//     } else {
//       return user;
//     }
//   }
// }
