import 'package:flutter/material.dart';
class RoundedStarButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onPressed;
  double? height=60;
  double? width=60;

  RoundedStarButton(
      {Key? key, required this.onPressed, required this.icon,  this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: icon,
      onPressed: onPressed,
      shape: const CircleBorder(),
      fillColor: Colors.white,
      constraints:  BoxConstraints.tightFor(width: width, height: height),
    );
  }
}
