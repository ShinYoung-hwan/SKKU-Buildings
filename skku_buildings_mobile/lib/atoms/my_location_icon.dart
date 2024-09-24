import 'package:flutter/material.dart';
import 'package:skku_buildings_mobile/atoms/skku_colors.dart';

class MyLocationIcon extends StatelessWidget {
  final Function ontap;

  MyLocationIcon({ required this.ontap });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => { ontap() },
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: SKKUColors().skku_dark_green, // 배경색
            shape: BoxShape.circle, // 원형 모양
          ),
          child:Icon(
            Icons.my_location,
            size: 30,
            color: SKKUColors().skku_gold,
          ),
        )
    );
  }
}