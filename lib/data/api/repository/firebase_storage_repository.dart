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

  Future<List<String>> uploadMultipleFiles(
    List<File> files,
    String folder,
  ) async {
    final String? userId = _auth.currentUser?.uid;
    if (userId == null) throw UnauthorizedException();

    return Future.wait(
      files.map(
        (file) => uploadFile(
          file: file,
          userId: userId,
          folder: folder,
        ),
      ),
    );
  }

  Future<String> uploadFile({
    required File file,
    required String userId,
    required String folder,
  }) =>
      _storage
          .ref(
              '${FirebaseStorageFolders.users}/$userId/$folder/${basename(file.path)}')
          .putFile(file)
          .then((snapshot) => snapshot.ref.getDownloadURL());
}
