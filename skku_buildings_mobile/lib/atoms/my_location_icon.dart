import 'package:flutter/material.dart';

class MyLocationIcon extends StatelessWidget {
  final Function ontap;

  const MyLocationIcon({ Key? key, required this.ontap }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => { ontap() },
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
            color: Color.fromRGBO(14, 52, 27, 1), // 배경색
            shape: BoxShape.circle, // 원형 모양
          ),
          child: const Icon(
            Icons.my_location,
            size: 30,
            color: Color.fromRGBO(215, 200, 130, 1),
          ),
        )
    );
  }
}