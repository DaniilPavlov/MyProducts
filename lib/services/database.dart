import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:products_control/models/data.dart';
import 'package:products_control/models/user.dart';

class DatabaseService {
  final CollectionReference _checkListCollection =
      Firestore.instance.collection('checkLists');
  final CollectionReference _boxItemCollection =
      Firestore.instance.collection('boxItems');
  final CollectionReference _userDataCollection =
      Firestore.instance.collection("userData");

  Future addOrUpdateBoxItem(BoxItem boxItem) async {
    DocumentReference boxItemRef = _boxItemCollection.document(boxItem.id);

// Берем ссылку на документ по schedule.id. Она позволит потом достать кусочек данных без неделей
// Кусочек будет хранить название, описание, автора, доступность и дату создания (показывается в меню)
    return boxItemRef.setData(boxItem.toBoxItemMap());

    // Сохраняем кусочек по ссылке в коллекцию workouts.
    // var docId = boxItemRef.documentID;

    // Теперь достаем айди этого воркаута ( .then((_)) )
    // После этого сохраняем в коллекцию workoutSchedules по этому айди (там будут полные данные)
    // await _boxItemCollection
    //     .document(docId)
    //     .setData(boxItem.toMap());
  }

  // Возвращает список воркаутов в меню. Есть поддержка фильтрации (уровень и автор)
  Stream<List<BoxItem>> getBoxItems({String author, String category}) {
    // Query - запрос о данных в конкретном месте
    Query query;
    if (author != null)
      query = _boxItemCollection.where('author', isEqualTo: author);
    if (category != null) query = query.where('category', isEqualTo: category);

// Метод snapshots() позволяет вернуть данные в конкретный момент как они есть в базе
// Перемепиваем их на наши воркауты
// Параметр doc будет содержать данные о конкретном воркауте. У него есть id и data
    return query.snapshots().map((QuerySnapshot data) => data.documents
        .map((DocumentSnapshot doc) =>
            BoxItem.fromJson(doc.documentID, doc.data))
        .toList());
  }

  Future<BoxItem> getBoxItem(String id) async {
    var doc = await _boxItemCollection.document(id).get();
    return BoxItem.fromJson(doc.documentID, doc.data);
  }

// User Data

//Обновление профиля
  Future updateUserData(User user) async {
    //берем весь текущий объект userData
    final userData = user.userData.toMap();
    //сериализуем (перевода структуры данных в последовательность битов) и сохраняем
    await _userDataCollection.document(user.id).setData(userData);
  }
//
//   Future addUserBoxItem(User user, BoxItem boxItem) async {
//     //описание методов fromWorkout/addUserWorkout смотреть через ctrl
//     var userBoxItem = BoxItem.fromBoxItem(workout);
//     user.userData.addUserBoxItem(userBoxItem);
//     await updateUserData(user);
//   }
//
//   Stream<List<BoxItem>> getUserBoxItems(User user) {
//     var query = _boxItemCollection.where(FieldPath.documentId,
//         whereIn: user);
//
//     return query.snapshots().map((QuerySnapshot data) => data.documents
//         .map((DocumentSnapshot doc) =>
//         BoxItem.fromJson(doc.data, id: doc.documentID))
//         .toList());
//   }
}
