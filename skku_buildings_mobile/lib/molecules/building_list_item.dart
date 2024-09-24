import 'package:flutter/material.dart';
import 'package:skku_buildings_mobile/atoms/info_specific_icon.dart';
import 'package:skku_buildings_mobile/dataframes/building_info.dart';
import 'package:skku_buildings_mobile/pages/building_map_page.dart';
import 'package:skku_buildings_mobile/pages/building_specific_page.dart';

class BuildingListItem extends StatelessWidget {
  final Building_Info building_info;

  const BuildingListItem({ Key? key, required this.building_info }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white, // 외곽선 색상
          width: 2.0, // 외곽선 두께
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Card(
        color: const Color.fromRGBO(14, 52, 27, 1),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => { Navigator.push(context, MaterialPageRoute(builder: (context) => BuildingMapPage(building_info: building_info,))) },
                child: Text(
                  "${building_info.building_name} (${building_info.building_id})",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10,),
            InfoSpecificIcon(ontap: () => { Navigator.push(context, MaterialPageRoute(builder: (context) => BuildingSpecificPage(building_info: building_info))) }),
          ],
        )
      ),
    );
  }
}