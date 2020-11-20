import 'package:firebase_auth/firebase_auth.dart';

import 'data.dart';

class User {
  String id;

  // UserData userData;

  User.fromFirebase(FirebaseUser fUser) {
    id = fUser.uid;
    print(id);
  }
}
//   void setUserData(UserData userData) {
//     this.userData = userData;
//   }
//
//   List<String> get workoutIds => userData != null && userData.boxItems != null
//       ? userData.boxItems.map((e) => e.boxItemId).toList()
//       : List<String>();
// }
//
// //так как работаем с firebase, нам нужны методы конвертации ИЗ (fromJson) и В (toMap) во всех классах
// class UserData {
//   String uid;
//   List<UserBoxItems> boxItems;
//
//   Map<String, dynamic> toMap() {
//     return {
//       "boxItems":
//       boxItems == null ? [] : boxItems.map((w) => w.toMap()).toList()
//     };
//   }
//
//   UserData();
//
//   UserData.fromJson(String uid, Map<String, dynamic> data) {
//     this.uid = uid;
//     if (data['boxItems'] == null)
//       boxItems = List<UserBoxItems>();
//     else
//       boxItems = (data['boxItems'] as List)
//           .map((w) => UserBoxItems.fromJson(w))
//           .toList();
//   }
//
// //в коллекцию воркаутов добавляем новую запись
//   void addUserWorkout(UserBoxItems userWorkout) {
//     if (boxItems == null) boxItems = List<UserBoxItems>();
//
//     boxItems.add(userWorkout);
//   }
// }
//
// class UserBoxItems {
//   String boxItemId;
//
//   Map<String, dynamic> toMap() {
//     return {
//       "boxItemId": boxItemId,
//     };
//   }
//
//   UserBoxItems.fromJson(Map<String, dynamic> value) {
//     boxItemId = value['boxItemId'];
//   }
//
//   UserBoxItems.fromWorkout(BoxItem boxItem) {
//     boxItemId = boxItem.id;
//
//   }
// }
