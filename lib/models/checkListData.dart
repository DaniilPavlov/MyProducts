import 'package:flutter/material.dart';

class CheckList {
  String id;
  String title;
  String author;
  String description;
  List<CheckListItem> items;

  CheckList({this.id, this.author, this.title, this.description, this.items});

  CheckList copy() {
    var copiedItems = items.map((w) => w.copy()).toList();
    return CheckList(
        id: this.id,
        author: this.author,
        title: this.title,
        description: this.description,
        items: copiedItems);
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "description": description,
      "author": author,
      "items": items.map((w) => w.toMap()).toList()
    };
  }

  // Эти значения забираются в базу
  Map<String, dynamic> toCheckListMap() {
    return {
      "title": title,
      "description": description,
      "author": author,
      "items": items.map((w) => w.toMap()).toList()
    };
  }

  //метод fromJson забирает значения из базы
  CheckList.fromJson(String id, Map<String, dynamic> data) {
    this.id = id;
    title = data['title'];
    author = data['author'];
    description = data['description'];
    items =
        (data['items'] as List).map((w) => CheckListItem.fromJson(w)).toList();
  }
}

class CheckListItem {
  String title;
  String amount;

  CheckListItem({this.title, this.amount});

  CheckListItem copy() {
    return CheckListItem(title: title, amount: amount);
  }

  // Эти значения забираются в базу
  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "amount": amount,
    };
  }

  //метод fromJson забирает значения из базы
  CheckListItem.fromJson(Map<String, dynamic> value) {
    title = value['title'];
    amount = value['amount'];
  }
}
