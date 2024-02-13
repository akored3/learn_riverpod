import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_riverpod/riverpod_class.dart';

final welcomeProvider = Provider((ref) => 'Welcome to Riverpod');

class WelcomePage extends StatelessWidget {
  WelcomePage({super.key});

  RiverpodX riverpodX = RiverpodX();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer(
          builder: (context, ref, child) {
            String anotherWelcomeText = ref.watch(riverpodX.welcomeRiverpod);
            return Text(
              anotherWelcomeText,
              style: const TextStyle(
                fontSize: 24.4,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      ),
    );
  }
}
