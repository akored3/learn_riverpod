import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:learn_riverpod/example4.dart';
import 'package:learn_riverpod/movie.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

// extension OptionalInfixAddition<T extends num> on T? {
//   T? operator +(T? other) {
//     final shadow = this;
//     if (shadow != null) {
//       return shadow + (other ?? 0) as T;
//     } else {
//       return null;
//     }
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Riverpod Sample',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.dark,
        home: const HomePageFive());
  }
}

enum City {
  stockHolm,
  paris,
  tokyo,
  newYork,
}

typedef WeatherEmoji = String;

Future<WeatherEmoji> getWeather(City city) {
  return Future.delayed(
    const Duration(seconds: 1),
    () => {
      City.stockHolm: '❄️',
      City.paris: '🌧️',
      City.tokyo: '💨',
    }[city]!,
  );
}

//UI writes  this reads from this
final currentCityProvider = StateProvider<City?>(
  (ref) => null,
);
const unKnownWeatherEmoji = '🤷🏿‍♂️';

//UI reads this
final weatherProvider = FutureProvider<WeatherEmoji>((ref) {
  final city = ref.watch(currentCityProvider);
  if (city != null) {
    return getWeather(city);
  } else {
    return unKnownWeatherEmoji;
  }
});

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentWeather = ref.watch(weatherProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
      ),
      body: Column(
        children: [
          currentWeather.when(
            data: (data) => Text(data,
                style: const TextStyle(
                  fontSize: 40,
                )),
            error: (_, __) => const Text('Error 😭'),
            loading: () => const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: City.values.length,
                  itemBuilder: (contex, index) {
                    final city = City.values[index];
                    final isSelected = city == ref.watch(currentCityProvider);
                    return ListTile(
                      title: Text(
                        city.toString(),
                      ),
                      trailing: isSelected ? const Icon(Icons.check) : null,
                      onTap: () =>
                          ref.read(currentCityProvider.notifier).state = city,
                    );
                  }))
        ],
      ),
    );
  }
}
