import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class StoreService {
  static final _storage = FirebaseStorage.instance.ref();
  static final folder = "post_images";

  static Future<String?> uploadImage(File _image) async {
    String img_name = "image_" + DateTime.now().toString();
    Reference firebaseStorageRef = _storage.child(folder).child(img_name);
    await firebaseStorageRef.putFile(_image);

    final String downloadUrl = await firebaseStorageRef.getDownloadURL();
    return downloadUrl;
  }
}
