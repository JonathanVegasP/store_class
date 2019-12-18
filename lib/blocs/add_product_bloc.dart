import 'dart:convert' show base64;
import 'dart:convert';
import 'dart:io' show File;

import 'package:flutter/material.dart' show FocusNode, Colors;
import 'package:image_cropper/image_cropper.dart'
    show ImageCropper, ImageCompressFormat, AndroidUiSettings;
import 'package:image_picker/image_picker.dart' show ImagePicker, ImageSource;
import 'package:rxdart/rxdart.dart' show Observable, BehaviorSubject;
import 'package:store/data/product_data.dart';
import 'package:store/database/database.dart';
import 'package:store/validators/add_product_validator.dart';

enum AddProductState { IDLE, LOADING }

class AddProductBloc with AddProductValidator {
  final _image = BehaviorSubject<File>();
  final _title = BehaviorSubject<String>();
  final _quantity = BehaviorSubject<String>();
  final _price = BehaviorSubject<String>();
  final _barcode = BehaviorSubject<String>();
  final _error = BehaviorSubject<String>();
  final _state = BehaviorSubject<AddProductState>();

  final quantityFN = FocusNode();
  final priceFN = FocusNode();
  final barcodeFN = FocusNode();

  Stream<File> get outImage => _image.stream.transform(imageValidator);

  Stream<String> get outTitle => _title.stream.transform(titleValidator);

  Stream<String> get outQuantity =>
      _quantity.stream.transform(quantityValidator);

  Stream<String> get outPrice => _price.stream.transform(priceValidator);

  Stream<String> get outBarcode => _barcode.stream.transform(barcodeValidator);

  Stream<String> get outError => _error.stream;

  Stream<AddProductState> get outState => _state.stream;

  Stream<bool> get outValidate => Observable.combineLatest(
      [outTitle, outImage, outQuantity, outPrice, outBarcode], (_) => true);

  Function(String) get inTitle => _title.add;

  Function(String) get inQuantity => _quantity.add;

  Function(String) get inPrice => _price.add;

  Function(String) get inBarcode => _barcode.add;

  Future<void> getImageFromGallery() async {
    try {
      File image = await ImagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      final response = await ImagePicker.retrieveLostData();
      if (response != null && response.file != null) {
        image = response.file;
      }
      final cropped = await ImageCropper.cropImage(
        sourcePath: image.path,
        compressQuality: 100,
        maxHeight: 360,
        maxWidth: 640,
        compressFormat: ImageCompressFormat.png,
        androidUiSettings: AndroidUiSettings(
          toolbarWidgetColor: Colors.white,
          toolbarColor: Colors.black,
          toolbarTitle: "Cortar Imagem",
        ),
      );
      _image.add(cropped);
    } catch (e) {
      print(e);
    }
  }

  Future<void> getImageFromCamera() async {
    try {
      File image = await ImagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );
      final response = await ImagePicker.retrieveLostData();
      if (response != null && response.file != null) {
        image = response.file;
      }
      final cropped = await ImageCropper.cropImage(
        sourcePath: image.path,
        compressQuality: 100,
        maxHeight: 360,
        maxWidth: 640,
        compressFormat: ImageCompressFormat.png,
        androidUiSettings: AndroidUiSettings(
          toolbarWidgetColor: Colors.white,
          toolbarColor: Colors.black,
          toolbarTitle: "Cortar Imagem",
        ),
      );
      _image.add(cropped);
    } catch (e) {
      print(e);
    }
  }

  void validateFields() {
    if (_image.value == null) _image.add(null);
    if (_title.value == null) _title.add("");
    if (_quantity.value == null) _quantity.add("");
    if (_price.value == null) _price.add("");
    if (_barcode.value == null) _barcode.add("");
  }

  Future<bool> addProduct() async {
    try {
      _error.add("");
      _state.add(AddProductState.LOADING);
      final price =
          double.parse(_price.value.replaceAll(".", "").replaceAll(",", "."));
      final product = ProductData(
        base64.encode(await _image.value.readAsBytes()),
        _title.value,
        int.parse(_quantity.value),
        price,
        _barcode.value,
      );
      final map = await Database().createTable("products", product.toJson());
      _state.add(AddProductState.IDLE);
      if (map["products"] == null &&
          map["error"] != "Bad state: Too many elements") {
        _error.add("Erro, tente novamente mais tarde");
        return false;
      } else
        return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  void dispose() {
    _title.close();
    _quantity.close();
    _price.close();
    _barcode.close();
    _image.close();
    _error.close();
    _state.close();
    quantityFN.dispose();
    priceFN.dispose();
    barcodeFN.dispose();
  }
}
