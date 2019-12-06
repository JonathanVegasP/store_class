import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';
import 'package:store/data/product_data.dart';
import 'package:store/database/database.dart';

class AddProductBloc {
  final _image = BehaviorSubject<File>();
  final _title = BehaviorSubject<String>();
  final _quantity = BehaviorSubject<String>();
  final _price = BehaviorSubject<String>();
  final _barcode = BehaviorSubject<String>();

  final descriptionFN = FocusNode();
  final barcodeFN = FocusNode();

  Stream<File> get outImage => _image.stream;

  Stream<String> get outTitle => _title.stream;

  Stream<String> get outQuantity => _quantity.stream;

  Stream<String> get outPrice => _price.stream;

  Stream<String> get outBarcode => _barcode.stream;

  Stream<bool> get outValidator => Observable.combineLatest(
      [outTitle, outImage, outQuantity, outPrice, outBarcode], (_) => true);

  Function(String) get inTitle => _title.add;

  Function(String) get inQuantity => _quantity.add;

  Function(String) get inPrice => _price.add;

  Function(String) get inBarcode => _barcode.add;

  Future<void> getImageFromGallery() async {
    final image = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    final cropped = await ImageCropper.cropImage(
        sourcePath: image.path,
        compressQuality: 100,
        maxHeight: 720,
        maxWidth: 1280,
        compressFormat: ImageCompressFormat.png,
        androidUiSettings: AndroidUiSettings(
          toolbarWidgetColor: Colors.white,
          toolbarColor: Colors.black,
          toolbarTitle: "Cortar Imagem",
        ));
    _image.add(cropped);
  }

  Future<void> getImageFromCamera() async {
    final image = await ImagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );
    final cropped = await ImageCropper.cropImage(
        sourcePath: image.path,
        compressQuality: 100,
        maxHeight: 720,
        maxWidth: 1280,
        compressFormat: ImageCompressFormat.png,
        androidUiSettings: AndroidUiSettings(
          toolbarWidgetColor: Colors.white,
          toolbarColor: Colors.black,
          toolbarTitle: "Cortar Imagem",
        ));
    _image.add(cropped);
  }

  Future<bool> addProduct() async {
    final price =
        double.parse(_price.value.replaceAll(".", "").replaceAll(",", "."));
    final product = ProductData(
        _title.value, int.parse(_quantity.value), price, _barcode.value);
    final map = await Database().createTable("users", product.toJson());
    if (map["data"] == null)
      return false;
    else
      return true;
  }

  void dispose() {
    _title.close();
    _quantity.close();
    _price.close();
    _barcode.close();
    _image.close();
    descriptionFN.dispose();
    barcodeFN.dispose();
  }
}
