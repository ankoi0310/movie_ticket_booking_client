import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

Reference get storageRef => FirebaseStorage.instance.ref();

class FirebaseStorageProvider extends ChangeNotifier {
  final Map<String, Uint8List> _mapImage = {};
  Uint8List? _image;

  Map<String, Uint8List> get mapImage => _mapImage;

  Uint8List? get image => _image;

  Future<Uint8List?> getImages(List<String> paths) async {
    try {
      if (paths.isEmpty) return null;

      for (final path in paths) {
        if (_mapImage.containsKey(path)) {
          _image = _mapImage[path];
        } else {
          _image = await storageRef.child(path).getData();
          _mapImage[path] = _image!;
        }
      }
      return _image;

    } catch (e) {
      print(e);
    }
    return null;
  }
}
