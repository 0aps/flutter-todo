import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../actions/profile_action.dart';
import '../../models/user_profile_vm.dart';
import '../../screens/profile_screen.dart';
import '../../../../shared/app_state.dart';

class ProfileScreenContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, UserProfileViewModel>(
      distinct: true,
      converter: (store) => UserProfileViewModel(
        authState: store.state.auth,
        profile: UserProfile(
          user: store.state.auth.user,
          userImage: store.state.auth.userImage,
        ),
        onSaveProfile: (profile) =>
            store.dispatch(startSaveProfileAction(profile)),
      ),
      builder: (context, vm) {
        if (vm.authState.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return ProfileScreen(
          profile: vm.profile,
          onSave: vm.onSaveProfile,
          message: vm.authState.message,
        );
      },
    );
  }
}
