class BoxItem {
  String id;
  String title;
  String author;
  String category;
  String amount;
  String expirationDate;

  BoxItem(
      {this.id,
      this.title,
      this.author,
      this.category,
      this.amount,
      this.expirationDate});

  BoxItem copy() {
    return BoxItem(
        id: this.id,
        title: this.title,
        author: this.author,
        category: this.category,
        amount: this.amount,
        expirationDate: this.expirationDate);
  }

  // Эти значения забираются из базы и по ним мы заполняем поля в меню
  BoxItem.fromJson(String id, Map<String, dynamic> data) {
    this.id = id;
    title = data['title'];
    author = data['author'];
    category = data['category'];
    amount = data['amount'];
    expirationDate = data['expirationDate'];
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "author": author,
      "category": category,
      "amount": amount,
      "expirationDate": expirationDate,
    };
  }

  // Эти значения забираются в базу
  Map<String, dynamic> toBoxItemMap() {
    return {
      "title": title,
      "author": author,
      "category": category,
      "amount": amount,
      "expirationDate": expirationDate,
    };
  }
}
