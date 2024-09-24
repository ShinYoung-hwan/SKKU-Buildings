import 'package:flutter/material.dart';
import 'package:skku_buildings_mobile/atoms/title_atom.dart';
import 'package:skku_buildings_mobile/dataframes/building_info.dart';
import 'package:skku_buildings_mobile/pages/building_map_page.dart';

class BuildingSpecificTemplate extends StatelessWidget {
  final Building_Info building_info;

  BuildingSpecificTemplate({required this.building_info});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      child: Column(
        children: [
          TitleAtom(text: "${building_info.building_id}: ${building_info.building_name}", fontSize: screenWidth * 0.09,),
          TitleAtom(text: "${building_info.campus}", fontSize: screenWidth * 0.05,),
          Image.asset("assets/${building_info.building_image}", width: screenWidth),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(" ${building_info.building_info}"),
          ),
          Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            width: screenWidth,
            height: screenHeight * 0.15,
            child: ElevatedButton(
              onPressed: () {
                // 버튼 클릭 시 SecondPage로 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BuildingMapPage(building_info: building_info)),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(14, 52, 27, 1), // 배경색
                foregroundColor: const Color.fromRGBO(215, 200, 130, 1), // 텍스트 색상
                textStyle: TextStyle(
                  fontSize: screenWidth * 0.07, // 텍스트 크기 설정
                  fontWeight: FontWeight.bold, // 텍스트 두께 설정
                ),
              ),
              child: const Text("Show in Map"),
            ),
          ),
        ],
      ),
    ) ;
  }
}