import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth * 0.1;

    return AppBar(
      title: Padding(
        padding: const EdgeInsets.all(16.0), // 상하 패딩 추가
        child: Text(
          'SKKU Buildings',
          style: TextStyle(
            color: const Color.fromRGBO(215, 200, 130, 1),
            fontSize: fontSize, // 폰트 크기
            fontWeight: FontWeight.bold, // 텍스트 굵게
          ),
        ),
      ),
      centerTitle: true,
      backgroundColor: const Color.fromRGBO(14, 52, 27, 1),
    );
  }
  //
  // AppBar의 크기를 설정하는 getter
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}