import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../auth_state.dart';

class UserProfileViewModel extends Equatable {
  final UserProfile profile;
  final Function(UserProfile) onSaveProfile;
  final AuthState authState;
  final Function onLogout;

  UserProfileViewModel({
    this.authState,
    this.profile,
    this.onSaveProfile,
    this.onLogout,
  });

  @override
  List<Object> get props =>
      [profile.user, authState.isLoading, authState.message];
}

class UserProfile {
  User user;
  String email;
  String currentPassword;
  String newPassword;
  File image;
  File userImage;

  UserProfile(
      {this.user,
      this.email,
      this.currentPassword,
      this.newPassword,
      this.image,
      this.userImage});

  bool get emailChanged => email != null && user.email.toString() != email;

  bool get passwordChanged => newPassword != null;

  bool get imageChanged => image != null;

  File get currentImage => image ?? (userImage != null ? userImage : null);

  hasUnsaveData() {
    return emailChanged || passwordChanged || imageChanged;
  }

  clear() {
    email = null;
    newPassword = null;
  }

  copy({
    User user,
    String email,
    String currentPassword,
    String newPassword,
    File image,
  }) =>
      UserProfile(
        user: user ?? this.user,
        email: email ?? this.email,
        currentPassword: currentPassword ?? this.currentPassword,
        newPassword: newPassword ?? this.newPassword,
        image: image ?? this.image,
      );
}
