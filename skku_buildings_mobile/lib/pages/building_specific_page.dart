import 'package:flutter/material.dart';
import 'package:skku_buildings_mobile/dataframes/building_info.dart';
import 'package:skku_buildings_mobile/organisms/header.dart';
import 'package:skku_buildings_mobile/templates/building_specific_template.dart';

class BuildingSpecificPage extends StatelessWidget {
  final Building_Info building_info;

  const BuildingSpecificPage({ Key? key, required this.building_info }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: Header(),
        body: BuildingSpecificTemplate(building_info: building_info,),
      ),
    );
  }
}