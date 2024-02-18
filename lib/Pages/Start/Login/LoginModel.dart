import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';

import 'Login.dart';

class LoginModel extends FlutterFlowModel<LoginWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for EmailAdress widget.
  FocusNode? emailAdressFocusNode;
  TextEditingController? emailAdressController;
  String? Function(BuildContext, String?)? emailAdressControllerValidator;
  // State field(s) for Password widget.
  FocusNode? passwordFocusNode;
  TextEditingController? passwordController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordControllerValidator;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    passwordVisibility = false;
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    emailAdressFocusNode?.dispose();
    emailAdressController?.dispose();

    passwordFocusNode?.dispose();
    passwordController?.dispose();
  }

/// Action blocks are added here.

/// Additional helper methods are added here.
}
