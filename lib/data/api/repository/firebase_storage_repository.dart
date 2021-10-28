import 'dart:io';

import 'package:dairo/data/api/firebase_storage_folder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';

@lazySingleton
class FirebaseStorageRepository {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<String>> uploadMultipleFiles(List<File> files, String folder) =>
      Future.wait(
        files.map(
          (file) => uploadFile(
            file: file,
            folder: folder,
          ),
        ),
      );

  Future<String> uploadFile({required File file, required String folder}) {
    final String? userId = _auth.currentUser?.uid;
    if (userId == null) throw UnauthorizedException();
    return _storage
        .ref(
            '${FirebaseStorageFolders.users}/$userId/$folder/${basename(file.path)}')
        .putFile(file)
        .then((snapshot) => snapshot.ref.getDownloadURL());
  }
}
