import 'dart:async' show StreamTransformer;

class LoginValidators {
  final emailValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (data, sink) {
    if (data.isEmpty)
      sink.addError("Digite o seu usuário");
    else
      sink.add(data);
  });
  final passwordValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (data, sink) {
    if (data.isEmpty)
      sink.addError("Digite a sua senha");
    else
      sink.add(data);
  });
}
