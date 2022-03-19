import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/app_preferences.dart';

const String kUSERS = "users";


class FirebaseHelper with _FireStorage, _FireStore, _FirebaseAuth {
  @override
  Future<UserCredential> createUser(String email, String password) {
    return super.createUser(email, password);
  }

  @override
  Future<String?> getImageUrl(String path) {
    return super.getImageUrl(path);
  }

  @override
  fs.UploadTask? uploadImage(String path, uploadFile) {
    return super.uploadImage(path, uploadFile);
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
      "AdminId": AppPreferences.getUserCredentialsId,
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


}

class _FireStorage {
  final _firebaseStorage = fs.FirebaseStorage.instance;

  Future<String?> getImageUrl(String path) async {
    try {
      return await _firebaseStorage.ref('images/$path').getDownloadURL();
    } on firebase_core.FirebaseException catch (e) {
      Get.log(e.toString(), isError: true);

      return null;
    }
  }

  fs.UploadTask? uploadImage(String path, uploadFile) {
    try {
      fs.Reference ref = _firebaseStorage.ref('images/').child(path);


        return ref.putData(uploadFile);

    } on firebase_core.FirebaseException catch (e) {
      Get.log(e.toString(), isError: true);

      return null;
    }
  }
}

class _FireStore {
  final firebaseFirestore = FirebaseFirestore.instance;

  Future<List<QueryDocumentSnapshot>> getDocsList(String collectionPath) async {
    QuerySnapshot? querySnapshot = await firebaseFirestore
        .collection(collectionPath)
        .where('AdminId', isEqualTo: AppPreferences.getUserCredentialsId)
        .get();

    return querySnapshot.docs;
  }

  Future<DocumentSnapshot> getDoc(String collectionPath, String uid) async {

    return await firebaseFirestore.collection(collectionPath).doc(uid).get();
  }

  Future<bool> saveDocument(String collectionPath, Map<String, dynamic> data) async {

    Get.log("Save $collectionPath $data",);

    return firebaseFirestore
        .collection(collectionPath)
        .doc(data["Id"])
        .set(data)
        .then((value) => true);
  }

  Future<bool> updateDocument(
      String collectionPath, Map<String, dynamic> data) async {

    data.addAll({"UpdatedAt": DateTime.now()});

    Get.log("Update $collectionPath $data",);

    return firebaseFirestore
        .collection(collectionPath)
        .doc(data["Id"])
        .update(data)
        .then((value) => true);
  }

  Future<bool> deleteDocument(
      String collectionPath, Map<String, dynamic> data) async {
    return firebaseFirestore
        .collection(collectionPath)
        .doc(data["Id"])
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
