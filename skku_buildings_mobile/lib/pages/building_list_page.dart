import "package:flutter/material.dart";
import "package:skku_buildings_mobile/dataframes/building_info.dart";
import "package:skku_buildings_mobile/organisms/header.dart";
import "package:skku_buildings_mobile/templates/building_list_template.dart";
import "package:skku_buildings_mobile/utils.dart";

class BuildingListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<List<Building_Info>> building_infos = loadJsonData("assets/building_infos.json");

    return MaterialApp(
      home: Scaffold(
        appBar: Header(), // Header

        body: FutureBuilder<List<Building_Info>>(
          future: building_infos,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No buildings found.'));
            }

            return BuildingListTemplate(building_infos: snapshot.data!);
          },
        )
      ),
    );
  }
}

