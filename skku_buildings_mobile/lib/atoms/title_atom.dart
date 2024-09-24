import 'package:flutter/material.dart';

class TitleAtom extends StatelessWidget {
  final String text;
  final double fontSize;

  const TitleAtom({Key? key, required this.text, required this.fontSize}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity, // 가로를 꽉 채우기
        padding: const EdgeInsets.all(16.0),
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          textAlign: TextAlign.center, // 텍스트 정렬
        ),
      ),
    );
  }
}