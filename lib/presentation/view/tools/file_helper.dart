import 'package:dairo/domain/model/publication/publication.dart';
import 'package:firebase_storage/firebase_storage.dart';

late final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

String getAttachedFileName(Publication publication) =>
    _firebaseStorage.refFromURL(publication.attachedFileUrl!).name;
