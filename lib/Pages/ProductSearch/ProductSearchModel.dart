import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';

import 'ProductSearch.dart';

class ProductSearchModel extends FlutterFlowModel<ProductSearchWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for Searchbar widget.
  FocusNode? searchbarFocusNode;
  TextEditingController? searchbarController;
  String? Function(BuildContext, String?)? searchbarControllerValidator;
  // State field(s) for ProductRating widget.
  double? productRatingValue;
  // State field(s) for RatingBar widget.
  double? ratingBarValue;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    searchbarFocusNode?.dispose();
    searchbarController?.dispose();
  }

/// Action blocks are added here.

/// Additional helper methods are added here.
}
