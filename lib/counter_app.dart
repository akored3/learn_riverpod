import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_riverpod/counter_notifier.dart';

final counterProvider = ChangeNotifierProvider((ref) => CounterNotifier());

class CounterApp extends StatefulWidget {
  const CounterApp({
    super.key,
  });
  @override
  State<CounterApp> createState() => _CounterAppState();
}

CounterNotifier counterFunction = CounterNotifier();

class _CounterAppState extends State<CounterApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Consumer(
              builder: (context, ref, child) {
                final counterNotifier = ref.watch(counterProvider);
                return Text('${counterNotifier.value}');
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => counterFunction.incrementValue(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), //
    );
  }
}
