import 'package:flutter/material.dart';

class AcceptDeleteDialog extends StatelessWidget {
  const AcceptDeleteDialog({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Подтверждение",
        style: Theme.of(context).textTheme.titleLarge,
      ),
      content: Text(text, style: Theme.of(context).textTheme.bodyLarge),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text("Отмена", style: Theme.of(context).textTheme.titleSmall),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text("Удалить", style: Theme.of(context).textTheme.titleSmall),
        ),
      ],
    );
  }
}
