import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:meta/meta.dart';
import 'services/authentication_service.dart';
import '../../shared/models/message.dart';

@immutable
class AuthState {
  final User user;
  final bool isLoading;
  final AuthenticationService api;
  final Message message;
  final File userImage;

  AuthState({
    this.user,
    this.isLoading,
    this.api,
    this.message,
    this.userImage,
  });

  static AuthState initialState({api}) => AuthState(
        user: null,
        isLoading: false,
        api: api ??
            AuthenticationService(
              FirebaseAuth.instance,
              FirebaseStorage.instance,
            ),
        message: Message(),
      );

  AuthState copy({
    User user,
    bool isLoading,
    AuthenticationService api,
    Message message,
    File userImage,
  }) =>
      AuthState(
        user: user ?? this.user,
        isLoading: isLoading ?? this.isLoading,
        api: api ?? this.api,
        message: message ?? this.message,
        userImage: userImage ?? this.userImage,
      );
}
