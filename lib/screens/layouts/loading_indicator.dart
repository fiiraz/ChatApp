import 'package:flutter/material.dart';

indicatorWidget(context){
  return Stack(
    children: <Widget>[
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: new BoxDecoration(
          color: Colors.black12,
        ),
        child: Center(
          child: new SizedBox(
            height: 50.0,
            width: 50.0,
            child: new CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
              value: null,
              strokeWidth: 7.0,
            ),
          ),
        ),
      )
    ],
  );
}