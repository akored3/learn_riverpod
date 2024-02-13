import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final passwordProvider = StateProvider<String>((ref) => "Generated password..");

class PasswordProvider with ChangeNotifier {
  String _password = 'Generated password..';

  String get password => _password;

  void generateNewPassword() {
    final random = Random();
    // Generate a new random password
    _password =
        String.fromCharCodes(List.generate(8, (_) => random.nextInt(255)));
    notifyListeners();
  }
}
