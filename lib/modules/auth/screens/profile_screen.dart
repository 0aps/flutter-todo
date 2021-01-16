import 'dart:io';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'widgets/email_field.dart';
import 'widgets/password_field.dart';
import 'widgets/profile_alert_dialog.dart';
import 'widgets/profile_image.dart';
import 'widgets/standard_button.dart';
import '../models/user_profile_vm.dart';
import '../../../shared/widgets/app_drawer.dart';
import '../../../shared/widgets/message_snackbar.dart';
import '../../../shared/models/message.dart';

class ProfileScreen extends StatefulWidget {
  final Function(UserProfile) onSave;
  final UserProfile profile;
  final Message message;

  const ProfileScreen({Key key, this.onSave, this.profile, this.message})
      : super(key: key);

  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController newPasswordController = TextEditingController();
  final picker = ImagePicker();

  _onEditEmail(context, value) async {
    final _ = AppLocalizations.of(context);
    final userProfile = widget.profile;

    await showDialog<void>(
      context: context,
      child: ProfileAlertDialog(
        formKey: _formKey,
        title: _.email,
        child: Wrap(
          children: [
            Text(
              _.emailChangeWarning,
              style: TextStyle(color: Colors.redAccent),
            ),
            EmailField(
              initialValue: value,
              onSaved: (value) => userProfile.email = value,
            )
          ],
        ),
      ),
    );
    setState(() {});
  }

  _onEditPassword(context) async {
    final _ = AppLocalizations.of(context);
    final userProfile = widget.profile;

    await showDialog<void>(
      context: context,
      child: ProfileAlertDialog(
        formKey: _formKey,
        title: _.changePassword,
        child: Wrap(
          children: [
            PasswordField(
              name: _.password,
              onSaved: (value) => userProfile.currentPassword = value,
            ),
            PasswordField(
              name: _.newPassword,
              controller: newPasswordController,
              onSaved: (value) {
                userProfile.newPassword = value;
                newPasswordController.clear();
              },
            ),
            PasswordField(
              name: _.newPasswordConfirmed,
              onValidate: (newPassword) {
                return newPassword != newPasswordController.text
                    ? _.passwordMismatchError
                    : null;
              },
            )
          ],
        ),
      ),
    );
    setState(() {});
  }

  _onEditImage(context) {
    final _ = AppLocalizations.of(context);
    final userProfile = widget.profile;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text(_.gallery),
              onTap: () async {
                final pickedFile =
                    await picker.getImage(source: ImageSource.gallery);
                setState(
                  () {
                    if (pickedFile != null) {
                      userProfile.image = File(pickedFile.path);
                    }
                  },
                );
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_camera),
              title: Text(_.camera),
              onTap: () async {
                final pickedFile =
                    await picker.getImage(source: ImageSource.camera);
                setState(
                  () {
                    if (pickedFile != null) {
                      userProfile.image = File(pickedFile.path);
                    }
                  },
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _ = AppLocalizations.of(context);
    final userProfile = widget.profile;

    final String email = userProfile.emailChanged
        ? userProfile.email
        : widget.profile.user != null
            ? widget.profile.user.email
            : "";

    return Scaffold(
      appBar: AppBar(
        title: Text(_.profile),
      ),
      drawer: AppDrawerContainer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => _onEditImage(context),
            child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: ProfileImage(image: userProfile.currentImage)),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text(email),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => _onEditEmail(
                context,
                email,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('*' * 10),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => _onEditPassword(context),
            ),
          ),
          Spacer(),
          StandardButton(
            name: _.save,
            onPressed: userProfile.hasUnsaveData()
                ? () {
                    widget.onSave(userProfile.copy());
                    userProfile.clear();
                  }
                : null,
          ),
          MessageSnackBar(message: widget.message)
        ],
      ),
    );
  }
}
