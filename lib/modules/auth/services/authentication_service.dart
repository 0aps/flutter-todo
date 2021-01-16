import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path/path.dart';

import '../models/user_profile_vm.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  final FirebaseStorage _fireStorage;

  const AuthenticationService(this._firebaseAuth, [this._fireStorage]);

  Stream<User> get authStateChanges => _firebaseAuth.idTokenChanges();

  Future<UserCredential> signIn(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<UserCredential> signUp(String email, String password) {
    return _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> resetPassword(String email) {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> logOut() {
    return _firebaseAuth.signOut();
  }

  Future<void> updateProfile(UserProfile profile) async {
    List<Future<void>> promises = [];

    if (profile.emailChanged) {
      promises.add(profile.user.updateEmail(profile.email));
    }

    if (profile.passwordChanged) {
      final userCredential = await reauthenticate(profile);
      promises.add(userCredential.user.updatePassword(profile.newPassword));
    }

    if (profile.imageChanged) {
      final String url = await uploadProfileImage(profile);
      promises.add(profile.user.updateProfile(photoURL: url));
    }

    return Future.wait(promises);
  }

  Future<UserCredential> reauthenticate(UserProfile profile) {
    AuthCredential credential = EmailAuthProvider.credential(
        email: profile.user.email, password: profile.currentPassword);

    return profile.user.reauthenticateWithCredential(credential);
  }

  //TODO: Move this to another class
  Future<String> uploadProfileImage(profile) {
    final storageRef = _fireStorage.ref(
      profile.user.uid + '/profilePicture/' + basename(profile.image.path),
    );

    UploadTask task = storageRef.putFile(profile.image);

    return task.then(
      (res) {
        return res.ref.getDownloadURL();
      },
    );
  }

  Future<File> loadUserImage(String url) {
    return DefaultCacheManager().getSingleFile(url);
  }
}
