import 'package:flutter/material.dart';

class InfoSpecificIcon extends StatelessWidget {
  final Function ontap;

  const InfoSpecificIcon({ Key? key, required this.ontap }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => { ontap() },
        child: const Icon(
        Icons.info,
        size: 30,
        color: Colors.white,
      ),
    );
  }
}