import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:products_control/models/boxData.dart';
import 'package:products_control/models/checkListData.dart';

class DatabaseService {
  final CollectionReference _checkListCollection =
      Firestore.instance.collection('checkLists');
  final CollectionReference _checkListItemCollection =
      Firestore.instance.collection('checkListItems');
  final CollectionReference _boxItemCollection =
      Firestore.instance.collection('boxItems');
  final CollectionReference _userDataCollection =
      Firestore.instance.collection("userData");

  Future addOrUpdateBoxItem(BoxItem boxItem) async {
    DocumentReference boxItemRef = _boxItemCollection.document(boxItem.id);

// Берем ссылку на документ по boxItem.id. Она позволит потом достать кусочек данных без товаров
// Кусочек будет хранить название, описание, автора, и дату создания (показывается в меню)
    return boxItemRef.setData(boxItem.toBoxItemMap());
  }

  Future deleteBoxItem(BoxItem boxItem) async {
    print("delete box item");
    DocumentReference boxItemRef = _boxItemCollection.document(boxItem.id);

// Берем ссылку на документ по boxItem.id. Она позволит потом достать кусочек данных без товаров
// Кусочек будет хранить название, описание, автора, и дату создания (показывается в меню)
    return boxItemRef.delete();
  }

  // Возвращает список элементов в коробку. Есть поддержка фильтрации
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

  Future addOrUpdateCheckList(CheckList checkList) async {
    DocumentReference checkListRef =
        _checkListCollection.document(checkList.id);
    checkListRef.setData(checkList.toCheckListMap());
    return checkList.id = checkListRef.documentID;
  }

  Future deleteCheckList(CheckList checkList) async {
    print("delete check list");
    DocumentReference checkListRef =
        _checkListCollection.document(checkList.id);
    Query query = _checkListItemCollection.where('listId',
        isEqualTo: checkList.id);
    query.getDocuments().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.documents) {
        print(ds.reference);
        ds.reference.delete();
      }
    });
    return checkListRef.delete();
  }


  // Возвращает список списков
  Stream<List<CheckList>> getCheckLists({String author}) {
    Query query;
    if (author != null)
      query = _checkListCollection.where('author', isEqualTo: author);

    return query.snapshots().map((QuerySnapshot data) => data.documents
        .map((DocumentSnapshot doc) =>
            CheckList.fromJson(doc.documentID, doc.data))
        .toList());
  }

  // // Возвращает список
  // Stream<List<CheckList>> getCheckList({String id}) {
  //   Query query;
  //   if (id != null) query = _checkListCollection.where('id', isEqualTo: id);
  //
  //   return query.snapshots().map((QuerySnapshot data) => data.documents.map(
  //       (DocumentSnapshot doc) =>
  //           CheckList.fromJson(doc.documentID, doc.data)));
  // }

  Future addOrUpdateCheckListItem(CheckListItem checkListItem) async {
    print("update check list item");
    DocumentReference checkListItemRef =
        _checkListItemCollection.document(checkListItem.id);

    checkListItemRef.setData(checkListItem.toCheckListItemMap());
    return checkListItem.id = checkListItemRef.documentID;
  }

  Future deleteCheckListItem(CheckListItem checkListItem) {
    print("delete check list item");
    print(checkListItem.id);
    DocumentReference checkListItemRef =
        _checkListItemCollection.document(checkListItem.id);
    return checkListItemRef.delete();
  }

  // Возвращает список товаров в списке
  Stream<List<CheckListItem>> getCheckListItems({String listId}) {
    Query query;
    if (listId != null)
      query = _checkListItemCollection.where('listId', isEqualTo: listId);

    return query.snapshots().map((QuerySnapshot data) => data.documents
        .map((DocumentSnapshot doc) =>
            CheckListItem.fromJson(doc.documentID, doc.data))
        .toList());
  }

// User Data

//Обновление профиля
//   Future updateUserData(User user) async {
//     //берем весь текущий объект userData
//     final userData = user.userData.toMap();
//     //сериализуем (перевода структуры данных в последовательность битов) и сохраняем
//     await _userDataCollection.document(user.id).setData(userData);
//   }
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
