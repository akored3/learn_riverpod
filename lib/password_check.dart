import 'package:flutter/material.dart';
import 'package:learn_riverpod/utils/button.dart';
import 'package:learn_riverpod/utils/card.dart';

class PasswordCheck extends StatelessWidget {
  const PasswordCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          const Center(child: GridCard()),
          const SizedBox(
            height: 200,
          ),
          BouncingButton(
            onTap: () {},
            label: 'Generate',
          )
        ],
      ),
    );
  }
}
