class Unit {
  Unit({required this.unitCode, required this.unitTitle, required this.unitAirbnbCode, required this.tags});

  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(
      unitCode: json['unitCode'] as String,
      unitTitle: json['unitTitle'] as String,
      unitAirbnbCode: json['unitAirbnbCode'] as int,
      tags: List<String>.from(json['tags'] as List),
    );
  }
  final String unitCode;
  final String unitTitle;
  final int unitAirbnbCode;
  final List<String> tags;

  Map<String, dynamic> toJson() {
    return {'unitCode': unitCode, 'unitTitle': unitTitle, 'unitAirbnbCode': unitAirbnbCode, 'tags': tags};
  }
}
