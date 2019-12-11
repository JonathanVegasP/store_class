import 'dart:async' show StreamTransformer;

import 'dart:io' show File;

class AddProductValidator {
  final imageValidator = StreamTransformer<File, File>.fromHandlers(
    handleData: (event, sink) {
      if (event == null)
        sink.addError("Adicione uma foto relacionado ao produto");
      else
        sink.add(event);
    },
  );

  final titleValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (event, sink) {
      if (event.isEmpty)
        sink.addError("Digite o título do produto");
      else
        sink.add(event);
    },
  );

  final quantityValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (event, sink) {
      if (event.isEmpty) {
        sink.addError("Digite a quantidade do produto");
      } else {
        sink.add(event);
      }
    },
  );

  final priceValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (event, sink) {
      if (event.isEmpty) {
        sink.addError("Digite o preço do produto");
      } else {
        sink.add(event);
      }
    },
  );

  final barcodeValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (event, sink) {
      if (event.isEmpty) {
        sink.addError("Digite o código de barras do produto");
      } else {
        sink.add(event);
      }
    },
  );
}
