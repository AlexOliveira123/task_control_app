import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:email_validator/email_validator.dart';

class Validators {
  static isEmail(String value, String msg) {
    var isValid = EmailValidator.validate(value);

    if (!isValid) {
      return msg;
    }
  }

  static isCPF(String value, String msg) {
    if (value.isEmpty) {
      return;
    }

    var isValid = CPFValidator.isValid(value);

    if (!isValid) {
      return msg;
    }
  }

  static isRequired(value, String msg) {
    if (value == null || value.trim().length == 0) {
      return msg;
    }
  }

  static hasMinLen(value, String msg, int min) {
    if (value == null || value.trim().length < min) {
      return msg;
    }
  }

  static hasMaxLen(value, String msg, int max) {
    if (value == null || value.trim().length < max) {
      return msg;
    }
  }

  static hasSpecialCharacter(String value, String msg) {
    RegExp regExp = RegExp(r'^[a-zA-Z0-9]+$');

    if (regExp.hasMatch(value)) {
      return msg;
    }
  }

  static multiValidators(List validators) {
    for (String res in validators) {
      if (res != null && res != "") {
        return res;
      }
    }
  }
}
