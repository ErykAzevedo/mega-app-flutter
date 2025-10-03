import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/unit.dart';

class UnitsService {
  static Future<List<Unit>> loadUnits() async {
    try {
      final String jsonString = await rootBundle.loadString('lib/data/units.json');
      final dynamic decodedJson = json.decode(jsonString);
      final List<dynamic> jsonList = decodedJson as List<dynamic>;
      return jsonList.map((json) => Unit.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Erro ao carregar unidades: $e');
    }
  }

  static Set<String> getAllTags(List<Unit> units) {
    final Set<String> allTags = <String>{};
    for (final unit in units) {
      allTags.addAll(unit.tags);
    }
    return allTags;
  }

  static List<Unit> filterUnitsByTags(List<Unit> units, Set<String> selectedTags) {
    if (selectedTags.isEmpty) {
      return units;
    }

    return units.where((unit) {
      return selectedTags.any((tag) => unit.tags.contains(tag));
    }).toList();
  }
}
