import 'dart:async';

class LoginValidators {
  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.contains("@")) {
      sink.add(email);
    } else {
      sink.addError("Insira um e-mail válido!");
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 6) {
      sink.add(password);
    } else {
      sink.addError("Senha inválida, deve conter pelo menos 8 caracteres!");
    }
  });
  final validatePhone = StreamTransformer<String, String>.fromHandlers(
      handleData: (phone, sink) {
    if (phone.length > 10) {
      sink.add(phone);
    } else {
      sink.addError("Número inválido, precisa conter o DDD!");
    }
  });
  final validateName = StreamTransformer<String, String>.fromHandlers(
      handleData: (name, sink) {
    if (name.length > 0) {
      sink.add(name);
    } else {
      sink.addError("Insira um nome!");
    }
  });
}
