// Load Json data from path
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:skku_buildings_mobile/dataframes/building_info.dart';

Future<List<Building_Info>> loadJsonData(String path) async {
  final String response = await rootBundle.loadString(path);
  final List<dynamic> data = json.decode(response);
  final List<Building_Info> items = data.map((item) => Building_Info.fromJson(item)).toList();
  return items;
}