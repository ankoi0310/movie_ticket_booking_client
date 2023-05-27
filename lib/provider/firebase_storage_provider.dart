import 'package:movie_ticket_booking_flutter_nlu/core.dart';

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

  Future<String?> getImage(String path) async {
    return await storageRef.child(path).getDownloadURL();
  }

  Future<String> uploadImage(String path, Uint8List imageBytes) async {
    TaskSnapshot taskSnapshot = await storageRef.child(path).putData(imageBytes);
    return await taskSnapshot.ref.getDownloadURL();
  }
}
