import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:products_control/models/user.dart';

class AuthService {
  final FirebaseAuth _fAuth = FirebaseAuth.instance;
  // final CollectionReference _userDataCollection =
  //     Firestore.instance.collection("userData");


  Future<User> emailAndPasswordLogIn(String email, String password) async {
    try {
      AuthResult authResult = await _fAuth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = authResult.user;
      return User.fromFirebase(user);
    } catch (e) {
      return null;
    }
  }

  Future<User> emailAndPasswordReg(String email, String password) async {
    try {
      AuthResult authResult = await _fAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = authResult.user;
      return User.fromFirebase(user);
    } catch (e) {
      return null;
    }
  }

  Future<User> logOut() async {
    await _fAuth.signOut();
  }

  Stream<User> get currentUser {

    return _fAuth.onAuthStateChanged.map(
        (FirebaseUser user) => user != null ? User.fromFirebase(user) : null);
  }
}
//   Stream<User> getCurrentUserWithData(User user) {
//     //когда юзер делаег логаут, он становится null. Поэтому у user?.id стоит ?(проверка на null)
//     //в этом случае будут возвращены пустые данные (null) (в случае логаута)
//     return _userDataCollection.document(user?.id).snapshots().map((snapshot) {
//       if (snapshot?.data == null) return null;
//
//       var userData = UserData.fromJson(snapshot.documentID, snapshot.data);
//       user.setUserData(userData);
//       return user;
//     });
//   }
// }
