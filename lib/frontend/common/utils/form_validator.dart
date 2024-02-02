import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class AppFormValidator {
  final formState = GlobalKey<FormState>();

  String? validateNotNull(String? value) {
    return value == '' ? 'Cannot Null' : null;
  }

  TextInputFormatter acceptAll() {
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
