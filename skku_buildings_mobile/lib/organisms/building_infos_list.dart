import 'package:flutter/material.dart';
import 'package:skku_buildings_mobile/dataframes/building_info.dart';
import 'package:skku_buildings_mobile/molecules/building_list_item.dart';

class BuildingInfoList extends StatelessWidget {

  final List<Building_Info> building_infos;
  final String text;

  const BuildingInfoList({Key? key, required this.building_infos, required this.text}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.builder(
          itemCount: building_infos.length,
          itemBuilder: (context, index) {
            if (text.isNotEmpty && !(building_infos[index].building_id.contains(text) || building_infos[index].building_name.contains(text))) return const SizedBox();
            return BuildingListItem(building_info: building_infos[index]);
          }
        )
    );
  }
}