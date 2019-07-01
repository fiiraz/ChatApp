import 'package:flutter/material.dart';
import "package:smooth_star_rating/smooth_star_rating.dart";

class StarRate extends StatefulWidget {
  double rating;

  StarRate(this.rating);

  @override
  _StarRateState createState() => _StarRateState();
}

class _StarRateState extends State<StarRate> {
  double rating;
  int starCount = 5;

  @override
  void initState() {
    rating = widget.rating;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SmoothStarRating(
      allowHalfRating: true,
      onRatingChanged: (v) {
        setState(() {});
      },
      starCount: starCount,
      rating: rating,
      color: Colors.pinkAccent,
      borderColor: Color(0xffeaeaea),
    );
  }
}
