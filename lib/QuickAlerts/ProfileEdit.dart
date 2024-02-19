import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class ProfileEdit {
  static openUserNameEditor(BuildContext context, bool DisableBackBtn) {
    var message = '';
    User? user = FirebaseAuth.instance.currentUser;

    QuickAlert.show(
        context: context,
        type: QuickAlertType.custom,
        title: 'Username',
        text: 'Bestimme deinen Username',
        barrierDismissible: true,
        confirmBtnText: 'Save',
        disableBackBtn: DisableBackBtn,
        widget: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: TextFormField(
              decoration: const InputDecoration(
                  alignLabelWithHint: true,
                  hintText: "Enter Username",
                  prefixIcon: Icon(Icons.drive_file_rename_outline)),
              initialValue: user?.displayName,
              textInputAction: TextInputAction.done,
              onChanged: (value) => message = value,
            )),
        onConfirmBtnTap: () async {
          if (message.isEmpty) {
            await QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              text: 'Username is required',
            );
            return;
          }

          try {
            user
                ?.updateDisplayName(message)
                .then((value) => Navigator.pop(context));
          } catch (error) {
            if (context.mounted) {
              await QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                text: 'An unknown error has occurred',
              );
            }
          }
        });
  }
}
