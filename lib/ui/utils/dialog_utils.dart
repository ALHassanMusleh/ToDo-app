import 'dart:async';

import 'package:flutter/material.dart';

Future<void> showLoading(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return const AlertDialog(
        content: Row(
          children: [
            Text(
              'Loading',
            ),
            Spacer(),
            CircularProgressIndicator(),
          ],
        ),
      );
    },
  );
}

void hideDialog(BuildContext context) {
    Navigator.pop(context);
}

Future<void> showMessage(
  BuildContext context, {
  String? title,
  String? body,
  String? posButtonTitle,
  String? negButtonTitle,
  Function? onPosButtonClick,
  Function? onNegButtonClick,
  bool isDismissible = true,
}) {
  return showDialog(
    context: context,
    barrierDismissible: isDismissible,
    builder: (context) {
      return AlertDialog(
        title: title != null ? Text(title) : null,
        content: body != null ? Text(body) : null,
        actions: [
          if (posButtonTitle != null)
            ElevatedButton(
              onPressed: () {
                onPosButtonClick?.call();
                hideDialog(context);
              },
              child: Text(posButtonTitle),
            ),
          if (negButtonTitle != null)
            ElevatedButton(
              onPressed: () {
                onNegButtonClick?.call();
                hideDialog(context);
              },
              child: Text(negButtonTitle),
            ),
        ],
      );
    },
  );
}
