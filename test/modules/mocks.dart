import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';

class MockUserCredential extends Mock implements UserCredential {
  final MockUser user;

  MockUserCredential(this.user) : super();
}

class MockUser extends Mock implements User {
  final String email, password;
  final bool emailVerified;

  MockUser({this.email, this.password, this.emailVerified}) : super();
}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}
