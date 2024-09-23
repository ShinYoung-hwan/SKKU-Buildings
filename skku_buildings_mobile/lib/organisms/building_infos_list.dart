import 'package:flutter/material.dart';
import 'package:skku_buildings_mobile/dataframes/building_info.dart';
import 'package:skku_buildings_mobile/molecules/building_list_item.dart';

class BuildingInfoList extends StatelessWidget {

  final List<Building_Info> building_infos;
  final String text;

  BuildingInfoList({required this.building_infos, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.builder(
          itemCount: building_infos.length,
          itemBuilder: (context, index) {
            if (text.length != "" && !(building_infos[index].building_id.contains(text) || building_infos[index].building_name.contains(text))) return SizedBox();
            return BuildingListItem(building_info: building_infos[index]);
          }
        )
    );
  }
}