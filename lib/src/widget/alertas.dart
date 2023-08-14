import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:ServiPro/models/user_model.dart';
import 'package:ServiPro/router/routes.dart';
import 'package:ServiPro/src/utils/navigateservice.dart';

CustomAlert(
    BuildContext context, String title, Widget? contents, String router,bool showboton) async {
  await showDialog<String>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      // backgroundColor: color,
      title: Text(title),
      content: contents,
      actions: <Widget>[
        // TextButton(
        //   onPressed: () => Navigator.pop(context, 'Cancelar'),
        //   child: const Text('Cancelar'),
        // ),
        showboton ?
        TextButton(
          onPressed: () {
            if (router != "N/A") NavigationService.moveTo(router);
            else Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ):SizedBox(),
      ],
    ),
  );
}
