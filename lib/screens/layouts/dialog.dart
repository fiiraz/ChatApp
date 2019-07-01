import 'package:flutter/material.dart';

Widget showDialogBuilder(controller, BuildContext context, text, buttonText,
    {value}) {
  return AlertDialog(
    title: new Text("Are you sure?"),
    content: new Text(text),
    actions: <Widget>[
      new FlatButton(
        child: new Text("Close"),
        onPressed: () => Navigator.pop(context),
      ),
      new FlatButton(
        child: new Text(buttonText),
        onPressed: () {
          controller.dialogBoxSubmit(value);
          Navigator.pop(context);
        },
      ),
    ],
  );
}

Widget showReview(
  title,
  comment,
  BuildContext context,
  image,
) {
  return (Card(
    elevation: 3.0,
    margin: EdgeInsets.fromLTRB(80, 230, 80, 380),
    child: Column(
      children: <Widget>[
        ListTile(
          leading: new CircleAvatar(
              backgroundImage: new NetworkImage(image),
              backgroundColor: Colors.transparent),
          title: Text(title),
          subtitle: Text(comment),
        ),
        ButtonTheme.bar(
          // make buttons use the appropriate styles for cards
          child: ButtonBar(
            children: <Widget>[
              FlatButton(
                child: const Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ],
    ),
  ));
}
