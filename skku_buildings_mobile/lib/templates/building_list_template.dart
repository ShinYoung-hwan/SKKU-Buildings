import 'package:flutter/material.dart';
import 'package:skku_buildings_mobile/atoms/text_field.dart';
import 'package:skku_buildings_mobile/dataframes/building_info.dart';
import 'package:skku_buildings_mobile/organisms/building_infos_list.dart';

class BuildingListTemplate extends StatefulWidget {
  final List<Building_Info> building_infos;

  BuildingListTemplate({required this.building_infos});

  @override
  State<BuildingListTemplate> createState() => _BuildingListTemplateState();
}

class _BuildingListTemplateState extends State<BuildingListTemplate> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(14, 52, 27, 1),
      child: Column(
        children: [
          CustomTextField(hintText: "Building ID", color: Colors.white, controller: _controller, onChanged: (value) => setState(() {  })),
          Expanded( // BuildingInfoList를 Expanded로 감싸서 공간을 확보
            child: BuildingInfoList(building_infos: widget.building_infos, text: _controller.text),
          ),
        ],
      ),
    );
  }
}