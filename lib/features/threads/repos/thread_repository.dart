import 'dart:io';
import 'package:path/path.dart';
import 'package:assign_11/features/threads/models/thread.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Repository는 Data Source에 접근
class ThreadRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Upload a new Thread
  Future<void> postNewThread(Thread thread, List<File> images) async {
    final threadRef = await _db.collection('threads').add(thread.toJson());
    List<String> imageUrls = await _uploadImageFiles(images, threadRef.id);

    _db.runTransaction(
      (transaction) async {
        transaction.set(
          threadRef,
          {'id': threadRef.id, 'imageUrls': imageUrls},
          SetOptions(merge: true),
        );
      },
    ).then(
      (value) => print('Thread Posted!'),
      onError: (e) => print("$e"),
    );
  }

  Future<List<String>> _uploadImageFiles(List<File> images, String uid) async {
    List<String> imageUrls = [];
    for (var image in images) {
      var url = await _uploadImage(image, uid);
      imageUrls.add(url);
    }
    return imageUrls;
  }

  Future<String> _uploadImage(File image, String uid) async {
    final fileRef = _storage.ref('threads').child(
          "/$uid/${basename(image.path)}}",
        );
    try {
      return await fileRef.putFile(image).then(
        (_) async {
          String downloadUrl = await fileRef.getDownloadURL();
          return downloadUrl;
        },
        onError: (error, stackTrace) => print('$error'),
      );
    } catch (error) {
      print('$error');
      rethrow;
    }
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getThreads(
      String? creatorUid) async {
    final threadsRef = _db.collection('threads').where(
          "creatorUid",
          isEqualTo: creatorUid ?? true,
        );
    return threadsRef.get().then(
          (snapshot) => snapshot.docs,
          onError: (e) => print("Error completing: $e"),
        );
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchThreads() =>
      _db.collection('threads').orderBy("created", descending: true).limit(10).get();

  Future<void> deleteThread(String id) => _db.collection('threads').doc(id).delete();
}

final threadRepo = Provider((ref) => ThreadRepository());
