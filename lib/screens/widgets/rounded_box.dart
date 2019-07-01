import 'package:flutter/material.dart';

class RoundedBox extends StatelessWidget {
  var component, height, title;

  RoundedBox(component, {title: null}) {
    this.component = component;
    this.title = title;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 24.0),
              child: Material(
                  elevation: 14.0,
                  borderRadius: BorderRadius.circular(12.0),
                  shadowColor: Color(0x802196F3),
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Column(children: <Widget>[
                      _buildTitle(),
                      component,
                    ]),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    if (title != null) {
      return Text(
        title,
        style: TextStyle(fontSize: 20.0),
      );
    } else {
      return Container();
    }
  }
}
