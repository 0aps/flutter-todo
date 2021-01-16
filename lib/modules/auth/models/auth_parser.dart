class AuthParser {
  //messages
  static const String remindConfirmEmail = 'remind-confirm-email';
  static const String sentResetPasswordEmail = 'sent-reset-password-email';

  //errors
  static const String userNotFound = 'user-not-found';
  static const String wrongPassword = 'wrong-password';
  static const String emailNotVerified = 'email-not-verified';

  static parse(_, code) {
    String message;
    switch (code) {
      case userNotFound:
        message = _.userNotFound;
        break;
      case wrongPassword:
        message = _.wrongPassword;
        break;
      case emailNotVerified:
        message = _.emailNotVerified;
        break;
      case remindConfirmEmail:
        message = _.remindConfirmEmail;
        break;
      case sentResetPasswordEmail:
        message = _.sentResetPasswordEmail;
        break;
    }

    return message;
  }
}
