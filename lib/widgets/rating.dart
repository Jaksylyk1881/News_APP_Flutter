import 'package:flutter/material.dart';
class RoundedRating extends StatelessWidget {
  final String movieRating;
double? height=60;
double? width=60;
double? fontSize = 35;
   RoundedRating({
    Key? key,
    required this.movieRating,this.height,this.width,this.fontSize
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        width: width,
        height: height,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Text(
          movieRating,
          style:  TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
              color: Colors.black),
          textAlign: TextAlign.center,
        ));
  }
}
