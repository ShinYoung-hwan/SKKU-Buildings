class Building_Info {
  final String building_id;
  final String building_name;
  final String building_image;
  final String building_info;
  final double building_latitude;
  final double building_longitude;
  final String campus;

  Building_Info({
    required this.building_id,
    required this.building_name,
    required this.building_image,
    required this.building_info,
    required this.building_latitude,
    required this.building_longitude,
    required this.campus,
  });

  factory Building_Info.fromJson(Map<String, dynamic> json) {
    return Building_Info(
      building_id: json["building_id"],
      building_name: json["building_name"],
      building_image: json["building_image"],
      building_info: json["building_info"],
      building_latitude: json["building_latitude"],
      building_longitude: json["building_longitude"],
      campus: json["campus"],
    );
  }

  @override
  String toString() {
    return "{ building_id: ${this.building_id}, building_name: ${this.building_name} }";
  }
}