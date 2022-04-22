// ignore_for_file: unnecessary_overrides

import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/utils/user_defaults.dart';
import 'package:let_go_gb/modules/drivers/utils/utils.dart';

class FirebaseHelper with _FireStorage, _FireStore, _FirebaseAuth {
  FirebaseHelper._privateConstructor();

  static final FirebaseHelper _instance = FirebaseHelper._privateConstructor();

  factory FirebaseHelper() {
    return _instance;
  }

  @override
  Future<List<QueryDocumentSnapshot<Object?>>> getDocsList(
      String collectionPath) {
    return super.getDocsList(collectionPath);
  }

  @override
  Future<DocumentSnapshot<Object?>> getDoc(String collectionPath, String uid) {
    return super.getDoc(collectionPath, uid);
  }

  @override
  Future<bool> saveDocument(String collectionPath, Map<String, dynamic> data) {
    data.addAll({
      "id": data['id'],
      "CreatedAt": DateTime.now(),
      "UpdatedAt": DateTime.now()
    });

    return super.saveDocument(collectionPath, data);
  }

  @override
  Future<bool> updateDocument(
      String collectionPath, Map<String, dynamic> data) {
    return super.updateDocument(collectionPath, data);
  }

  @override
  Future<String> uploadImage(
      {required File file, required String path, required String fileName}) {
    return super.uploadImage(file: file, path: path, fileName: fileName);
  }

  @override
  Future<String> uploadImageWeb(
      {required Uint8List file,
      required String path,
      required String fileName}) {
    return super.uploadImageWeb(file: file, path: path, fileName: fileName);
  }

  @override
  Future<void> deleteImage({required String id, required String fullPath}) {
    return super.deleteImage(id: id, fullPath: fullPath);
  }
}

class _FireStorage {
  Future<String> uploadImage(
      {required File file,
      required String path,
      required String fileName}) async {
    Reference ref =
        FirebaseStorage.instance.ref(path).child("/" + fileName + ".jpg");
    await ref.putFile(file);
    String url = await ref.getDownloadURL();
    return Future.value(url);
  }

  Future<String> uploadImageWeb(
      {required Uint8List file,
      required String path,
      required String fileName}) async {
    Reference ref =
        FirebaseStorage.instance.ref(path).child("/" + fileName + ".jpg");
    printWrapped(ref.toString());
    await ref.putData(file);
    String url = await ref.getDownloadURL();
    return Future.value(url);
  }

  Future<void> deleteImage(
      {required String id, required String fullPath}) async {
    Reference ref =
        FirebaseStorage.instance.ref(fullPath).child("/" + id + ".jpg");
    printWrapped(ref.toString());
    try {
      ref.delete();
      // ignore: empty_catches
    } catch (e) {}
  }
}

class _FireStore {
  final firebaseFirestore = FirebaseFirestore.instance;

  Future<List<QueryDocumentSnapshot>> getDocsList(String collectionPath) async {
    QuerySnapshot? querySnapshot = await firebaseFirestore
        .collection(collectionPath)
        .where('id', isEqualTo: UserDefaults.getDriverUserSession()?.id ?? '')
        .get();

    return querySnapshot.docs;
  }

  Future<DocumentSnapshot> getDoc(String collectionPath, String uid) async {
    return await firebaseFirestore.collection(collectionPath).doc(uid).get();
  }

  Future<bool> saveDocument(
      String collectionPath, Map<String, dynamic> data) async {
    Get.log(
      "Save $collectionPath $data",
    );

    return firebaseFirestore
        .collection(collectionPath)
        .doc(data["id"])
        .set(data)
        .then((value) => true);
  }

  Future<bool> updateDocument(
      String collectionPath, Map<String, dynamic> data) async {
    data.addAll({"UpdatedAt": DateTime.now()});

    Get.log(
      "Update $collectionPath $data",
    );

    return firebaseFirestore
        .collection(collectionPath)
        .doc(data["id"])
        .update(data)
        .then((value) => true);
  }

  Future<bool> deleteDocument(
      String collectionPath, Map<String, dynamic> data) async {
    return firebaseFirestore
        .collection(collectionPath)
        .doc(data["id"])
        .delete()
        .then((value) => true);
  }
}

class _FirebaseAuth {
  final firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> createUser(String email, String password) async {
    return await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }
}
