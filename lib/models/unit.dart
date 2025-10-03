class Unit {
  Unit({this.id, required this.unitCode, required this.unitTitle, required this.unitAirbnbCode, required this.tags});

  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(
      id: json['id'] as String?,
      unitCode: json['unitCode'] as String,
      unitTitle: json['unitTitle'] as String,
      unitAirbnbCode: json['unitAirbnbCode'] as String,
      tags: List<String>.from(json['tags'] as List),
    );
  }

  final String? id; // ID do documento no Firestore (opcional para compatibilidade com JSON)
  final String unitCode;
  final String unitTitle;
  final String unitAirbnbCode;
  final List<String> tags;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'unitCode': unitCode,
      'unitTitle': unitTitle,
      'unitAirbnbCode': unitAirbnbCode,
      'tags': tags,
    };

    // Não incluir ID no JSON para Firestore (é gerado automaticamente)
    if (id != null) {
      data['id'] = id;
    }

    return data;
  }
}
