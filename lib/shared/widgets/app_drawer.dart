import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../app_state.dart';
import '../../modules/auth/actions/auth_action.dart';
import '../../modules/auth/auth_routes.dart';
import '../../modules/auth/models/user_profile_vm.dart';
import '../../modules/auth/screens/widgets/profile_image.dart';

class AppDrawerContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, UserProfileViewModel>(
      distinct: true,
      converter: (store) {
        return UserProfileViewModel(
          onLogout: () => store.dispatch(startLogoutAction),
          profile: UserProfile(
            user: store.state.auth.user,
            userImage: store.state.auth.userImage,
          ),
          authState: store.state.auth,
        );
      },
      builder: (context, UserProfileViewModel vm) {
        return AppDrawer(
          onLogout: vm.onLogout,
          userProfile: vm.profile,
        );
      },
    );
  }
}

class AppDrawer extends StatelessWidget {
  final Function onLogout;
  final UserProfile userProfile;

  const AppDrawer({Key key, this.onLogout, this.userProfile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _ = AppLocalizations.of(context);

    final avatar = ProfileImage(
      image: userProfile.userImage,
      radius: 55,
      height: 100,
      width: 100,
    );
    final displayName = Text(userProfile.user.email);

    final home = ListTile(
      dense: true,
      title: Text(
        _.home,
        style: TextStyle(color: Colors.black),
      ),
      leading: Icon(Icons.home),
      onTap: () => Navigator.pushNamed(context, AuthRoutes.home),
    );

    final profile = ListTile(
      dense: true,
      title: Text(
        _.profile,
        style: TextStyle(color: Colors.black),
      ),
      leading: Icon(Icons.person),
      onTap: () => Navigator.pushNamed(context, AuthRoutes.profile),
    );

    final logOut = ListTile(
      dense: true,
      title: Text(
        _.logOut,
        style: TextStyle(color: Colors.black),
      ),
      leading: Icon(Icons.logout),
      onTap: onLogout,
    );

    return SizedBox(
      width: 250,
      child: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: [avatar, displayName],
              ),
            ),
            home,
            profile,
            logOut,
          ],
        ),
      ),
    );
  }
}
