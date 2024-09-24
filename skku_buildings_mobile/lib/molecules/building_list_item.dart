import 'package:flutter/material.dart';
import 'package:skku_buildings_mobile/dataframes/building_info.dart';
import 'package:skku_buildings_mobile/pages/building_map_page.dart';
import 'package:skku_buildings_mobile/pages/building_specific_page.dart';

class BuildingListItem extends StatelessWidget {
  final Building_Info building_info;

  BuildingListItem({ required this.building_info });

  @override
  Widget build(BuildContext context) {
    return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white, // 외곽선 색상
              width: 2.0, // 외곽선 두께
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),

      child: Card(
        color: Color.fromRGBO(14, 52, 27, 1),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => { Navigator.push(context, MaterialPageRoute(builder: (context) => BuildingMapPage(building_info: building_info,))) },
                child: Text("${building_info.building_name} (${building_info.building_id})",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () => { Navigator.push(context, MaterialPageRoute(builder: (context) => BuildingSpecificPage(building_info: building_info))) },
                child: Icon(Icons.info,
                  color: Colors.white,
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}