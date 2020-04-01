import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:bonde_do_ru/src/validators/login_validators.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

// import '../login/firebase_login.dart';

// enum LoginState {
//   LOADING,
//   IDLE,
//   SUCCESS,
//   FAILPRIVILEGE,
//   FAILCREDENTIALS,
//   FAILCREATE
// }

class LoginBloc extends BlocBase with LoginValidators {
//   final _emailController = BehaviorSubject<String>();
//   final _passwordController = BehaviorSubject<String>();
//   final _nameController = BehaviorSubject<String>();
//   final _phoneController = BehaviorSubject<String>();
//   final _stateController = BehaviorSubject<LoginState>();

//   Stream<String> get outEmail =>
//       _emailController.stream.transform(validateEmail);
//   Stream<String> get outPassword =>
//       _passwordController.stream.transform(validatePassword);
//   Stream<String> get outName => _nameController.stream.transform(validateName);
//   Stream<String> get outPhone =>
//       _phoneController.stream.transform(validatePhone);
//   Stream<LoginState> get outState => _stateController.stream;

//   Stream<bool> get onSubmitValid =>
//       Observable.combineLatest2(outEmail, outPassword, (a, b) => true);
//   Stream<bool> get onSubmitValidCreate => Observable.combineLatest4(
//       outName, outPhone, outEmail, outPassword, (a, b, c, d) => true);

//   Function(String) get changeEmail => _emailController.sink.add;
//   Function(String) get changePassword => _passwordController.sink.add;
//   Function(String) get changeName => _nameController.sink.add;
//   Function(String) get changePhone => _phoneController.sink.add;

//   StreamSubscription _streamSubscription;

//   LoginBloc() {
//     _streamSubscription =
//         FirebaseAuth.instance.onAuthStateChanged.listen((user) async {
//       if (user != null) {
//         //if (await verifyPrivileges(user)) {
//         // if (await verifyUsers(user)) {
//           setCurrentUser(user);
//           getUsuarioEmail(user.email);
//           _stateController.add(LoginState.SUCCESS);
//         // } else {
//         //   FirebaseAuth.instance.signOut();
//         //   _stateController.add(LoginState.FAILPRIVILEGE);
//         // }
//       } else {
//         _stateController.add(LoginState.IDLE);
//       }
//     });
//   }

//   submitGoogle() async {
//     _stateController.add(LoginState.LOADING);

//     final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
//     final GoogleSignInAuthentication googleAuth =
//         await googleUser.authentication;
//     final AuthCredential credential = GoogleAuthProvider.getCredential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );
//     await FirebaseAuth.instance.signInWithCredential(credential);
//   }

//   submit() {
//     final email = _emailController.value;
//     final password = _passwordController.value;

//     _stateController.add(LoginState.LOADING);

//     FirebaseAuth.instance
//         .signInWithEmailAndPassword(
//           email: email,
//           password: password,
//         )
//         .then((user) {})
//         .catchError((e) {
//       _stateController.add(LoginState.FAILCREDENTIALS);
//     });
//   }

//   Future<bool> verifyPrivileges(FirebaseUser user) async {
//     return await Firestore.instance
//         .collection("admins")
//         .document(user.uid)
//         .get()
//         .then((doc) {
//       if (doc.data != null) {
//         return true;
//       } else {
//         return false;
//       }
//     }).catchError((e) {
//       return false;
//     });
//   }

//   verifyUsers(FirebaseUser user) async {
//     var fire = await Firestore.instance
//         .collection("users")
//         .getDocuments()
//         .catchError((e) {
//       return false;
//     });

//     int i;
//     for (i = 0; i < fire.documents.length; i++) {
//       if (fire.documents[i]["uid"] == user.uid) {
//         return true;
//       }
//     }
//   }

//   submitNewUser() {
//     final email = _emailController.value;
//     final password = _passwordController.value;
//     final name = _nameController.value;
//     final phone = _phoneController.value;

//     _stateController.add(LoginState.LOADING);

//     FirebaseAuth.instance
//         .createUserWithEmailAndPassword(
//       email: email,
//       password: password,
//     )
//         .then((signedInUser) {
//       UserManagement().storeNewUser(signedInUser, name, phone);
//       _stateController.add(LoginState.IDLE);
//     }).catchError((e) {
//       print(e);
//       _stateController.add(LoginState.FAILCREATE);
//     });
//   }

//   @override
//   void dispose() {
//     _emailController.close();
//     _passwordController.close();
//     _nameController.close();
//     _phoneController.close();
//     _stateController.close();
//     _streamSubscription.cancel();
//   }
}
