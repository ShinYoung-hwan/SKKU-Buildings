import 'package:flutter/material.dart';
import 'package:skku_buildings_mobile/dataframes/building_info.dart';
import 'package:skku_buildings_mobile/organisms/header.dart';
import 'package:skku_buildings_mobile/templates/building_map_template.dart';

class BuildingMapPage extends StatelessWidget {
  final Building_Info building_info;

  BuildingMapPage({ required this.building_info });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: Header(),
        body: BuildingMapTemplate(dst_lat: building_info.building_latitude, dst_lng: building_info.building_longitude,),
      ),
    );
  }
}