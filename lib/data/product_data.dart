class ProductData {
  String title;
  int quantity;
  double price;
  String barcode;

  ProductData(this.title, this.quantity, this.price, this.barcode);

  ProductData.fromJson(Map<String, dynamic> map) {
    title = map["title"];
    quantity = map["quantity"];
    price = map["price"] + 0.0;
    barcode = map["barcode"];
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "quantity": quantity,
      "price": price,
      "barcode": barcode,
    };
  }
}
