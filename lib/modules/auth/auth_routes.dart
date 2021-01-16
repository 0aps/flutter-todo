import '../../shared/models/base_routes.dart';

import 'screens/containers/forgotpassword_screen_container.dart';
import 'screens/containers/signup_screen_container.dart';
import 'screens/containers/profile_screen_container.dart';
import 'screens/login_screen.dart';

class AuthRoutes implements BaseRoutes {
  static final home = '/';
  static final login = '/login';
  static final signUp = '/signUp';
  static final forgotPassword = '/forgotPassword';
  static final profile = '/profile';

  getRoutes() {
    return {
      login: (context) => LoginScreen(),
      signUp: (context) => SignUpScreenContainer(),
      forgotPassword: (context) => ForgotPasswordScreenContainer(),
      profile: (context) => ProfileScreenContainer()
    };
  }
}
