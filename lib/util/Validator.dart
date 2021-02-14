/// Esta clase es usada para validar que los campos de texto cumplan ciertas
/// especificaciones, como en campo de email o password
class Validator {
  static const String _emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  /// Verifica que el campo no esté vacío
  String requiredField(String value) {
    String error;
    if (value?.isEmpty ?? true) {
      error = "Este campo es obligatorio";
    }
    return error;
  }

  /// Verifica el que el código postal tenga la longitud correcta
  String codePostal(String value) {
    String error;
    if (value.length > 5 || value.length < 5) {
      error = "Deben ser siempre 5 digitos";
    }
    return error;
  }

  /// Verifica el número de teléfono
  String phoneNumbre(String value) {
    if (value == null || (value?.isEmpty ?? true)) return null;

    try {
      int.parse(value);
    } catch (e) {
      return "Ingresa solo números";
    }

    String error;
    if (value.length < 10 || value.length > 10) {
      error = "Ingresa tu número a 10 digitos";
    }
    return error;
  }

  /// Verifica que el campo no este vácio y que sea un correo válido
  String validateEmail(String value) {
    String error = requiredField(value);
    RegExp regExp = new RegExp(_emailPattern);

    if (!regExp.hasMatch(value)) {
      error = "Ingresa un correo valido";
    }

    return error;
  }

  /// Verifica que la longuitud para la contraseña sea correcta
  String validatePassword(String value) {
    String error = requiredField(value);

    if (value.length < 6) {
      error = "Tu contraseña debe de contener un mínimo de 6 caracteres.";
    }
    return error;
  }
}
