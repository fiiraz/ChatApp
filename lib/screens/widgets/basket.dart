import 'package:flutter/material.dart';

class BasketActionButton extends StatefulWidget {

  @override
  _BasketActionButtonState createState() => _BasketActionButtonState();
}

class _BasketActionButtonState extends State<BasketActionButton> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () => Navigator.pushReplacementNamed(context, '/card'),
          tooltip: 'Increment',
          child: Icon(Icons.shopping_basket,color: Colors.pinkAccent,),
        ),
        Container(
          height: 35,
          width: 60,
          padding: EdgeInsets.only(right: 10),
          alignment: Alignment.topRight,
          child: Container(
            width: 20,
            height: 20,
            alignment: Alignment.center,
            padding: EdgeInsets.all(2),
            child: Text("3",style: TextStyle(color: Colors.white),),
            decoration: BoxDecoration(
                color: Colors.pinkAccent,
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
        ),
      ],
    );
  }
}
