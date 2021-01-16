import 'auth_parser.dart';

class EmailNotVerifiedException implements Exception {
  String code = AuthParser.emailNotVerified;
}
