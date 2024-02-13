import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_riverpod/providers.dart';

class GridCard extends StatelessWidget {
  const GridCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, bottom: 15),
      child: Container(
        width: 200,
        height: 150,
        // padding: const EdgeInsets.only(left: 35.0, right: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.5),
          boxShadow: [
            BoxShadow(
                offset: const Offset(10, 20),
                blurRadius: 10,
                spreadRadius: 0,
                color: Colors.grey.withOpacity(.05)),
          ],
        ),
        child: Consumer(
          builder: (context, ref, child) {
            final password = ref.watch(passwordProvider);
            return Center(
              child: Text(password),
            );
          },
        ),
      ),
    );
  }
}
