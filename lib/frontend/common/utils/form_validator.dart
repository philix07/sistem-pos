import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class AppFormValidator {
  final formState = GlobalKey<FormState>();

  String? validateNotNull(String? value) {
    return value == '' ? 'Cannot Null' : null;
  }

  String? validateEmail(String? value) {
    if (value == '' || value == null) {
      return 'Please input your email';
    } else {
      return RegExp(
        r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$',
      ).hasMatch(value)
          ? null
          : 'Invalid email format';
    }
  }

  TextInputFormatter acceptAll() {
    return FilteringTextInputFormatter.allow(
      RegExp(r'.*'),
    );
  }

  TextInputFormatter wordAndNumber() {
    return FilteringTextInputFormatter.allow(
      RegExp(r'^[A-Za-z0-9\s]+$'),
    );
  }

  TextInputFormatter numberOnly() {
    return FilteringTextInputFormatter.digitsOnly;
  }

  TextInputFormatter textOnly() {
    return FilteringTextInputFormatter.allow(
      RegExp(r'^[a-zA-Z\s]+$'),
    );
  }
}
