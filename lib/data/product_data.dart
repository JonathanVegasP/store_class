class ProductData {
  String image;
  String title;
  int quantity;
  double price;
  String barcode;

  ProductData(this.image, this.title, this.quantity, this.price, this.barcode);

  ProductData.fromJson(Map<String, dynamic> map) {
    image = map["image"];
    title = map["title"];
    quantity = map["quantity"];
    price = map["price"] + 0.0;
    barcode = map["barcode"];
  }

  Map<String, dynamic> toJson() {
    return {
      "image": image,
      "title": title,
      "quantity": quantity,
      "price": price,
      "barcode": barcode,
    };
  }
}
