import 'dart:async';

class AddProductValidator {
  final titleValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (event, sink) {
    if (event.isEmpty)
      sink.addError("Digite o título do produto");
    else
      sink.add(event);
  });

  final descriptionValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (event, sink) {
    if (event.isEmpty)
      sink.addError("Digite a descrição do produto");
    else
      sink.add(event);
  });
}
