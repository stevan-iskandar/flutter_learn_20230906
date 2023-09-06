import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_learn_20230906/src/providers/user_places.dart';
import 'package:flutter_learn_20230906/src/widgets/image_input.dart';
import 'package:flutter_learn_20230906/src/widgets/location_input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaceAddScreen extends ConsumerStatefulWidget {
  const PlaceAddScreen({super.key});

  @override
  ConsumerState<PlaceAddScreen> createState() => _PlaceAddScreenState();
}

class _PlaceAddScreenState extends ConsumerState<PlaceAddScreen> {
  final _titleController = TextEditingController();
  File? _selectedImage;

  void _savePlace() {
    final title = _titleController.text;

    if (title.isEmpty || _selectedImage == null) {
      return;
    }

    ref.read(userPlacesProvider.notifier).addPlace(title, _selectedImage!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            const SizedBox(height: 16),
            ImageInput(
              onPickImage: (image) {
                _selectedImage = image;
              },
            ),
            const SizedBox(height: 16),
            const LocationInput(),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _savePlace,
              icon: const Icon(Icons.add),
              label: const Text('Add place'),
            ),
          ],
        ),
      ),
    );
  }
}
