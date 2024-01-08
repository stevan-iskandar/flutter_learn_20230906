import 'dart:io';

import 'package:flutter_learn_20230906/src/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

const tableUserPlaces = 'user_places';

Future<Database> _getDatabase() async {
  return openDatabase(
    join(await getDatabasesPath(), 'places.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE $tableUserPlaces(id TEXT PRIMARY KEY, title TEXT, image TEXT)',
      );
    },
    version: 1,
  );
}

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super(const []);

  Future<void> loadPlaces() async {
    final db = await _getDatabase();
    final data = await db.query(tableUserPlaces);
    state = data
        .map(
          (item) => Place(
            id: item['id'] as String,
            title: item['title'] as String,
            image: File(item['image'] as String),
          ),
        )
        .toList();
  }

  void addPlace(String title, File image) async {
    final appDir = await getApplicationDocumentsDirectory();
    final filename = basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$filename');

    final newPlace = Place(title: title, image: copiedImage);

    final db = await _getDatabase();
    db.insert(tableUserPlaces, {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
    });

    state = [newPlace, ...state];
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
  (ref) => UserPlacesNotifier(),
);
