import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const names = [
  'Alice',
  'Bob',
  'Charlie',
  'David',
  'Eve',
  'Fred',
  'Ginny',
  'Harriet',
  'Ileana',
  'Joseph',
  'Kincaid',
  'Larry',
];

final tickerProvider = StreamProvider(
  (ref) => Stream.periodic(
    const Duration(
      seconds: 1,
    ),
    (i) => i + 1,
  ),
);

final namesProvider =
    StreamProvider((ref) => ref.watch(tickerProvider.stream).map(
          (count) => names.getRange(0, count),
        ));

class HomePageTwo extends ConsumerWidget {
  const HomePageTwo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final names = ref.watch(namesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Streams Riverpod'),
      ),
      body: names.when(
          data: (names) {
            return ListView.builder(
                itemCount: names.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(names.elementAt(index)),
                  );
                });
          },
          error: (_, __) => const Text('Reched the end ot the list!'),
          loading: () => const Center(
                child: CircularProgressIndicator(),
              )),
    );
  }
}
