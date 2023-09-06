import 'package:flutter/material.dart';
import 'package:flutter_learn_20230906/src/providers/user_places.dart';
import 'package:flutter_learn_20230906/src/screens/place_add_screen.dart';
import 'package:flutter_learn_20230906/src/widgets/place_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaceListScreen extends ConsumerWidget {
  const PlaceListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPlaces = ref.watch(userPlacesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const PlaceAddScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PlaceList(
          places: userPlaces,
        ),
      ),
    );
  }
}
