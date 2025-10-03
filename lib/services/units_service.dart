import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/unit.dart';
import 'firebase_service.dart';

class UnitsService {
  static bool _hasMigrated = false;

  static Future<List<Unit>> loadUnits() async {
    // Por enquanto, carregar apenas do JSON para resolver o problema
    return await _loadUnitsFromJson();
  }

  // Versão futura com Firebase (desabilitada temporariamente)
  static Future<List<Unit>> loadUnitsWithFirebase() async {
    try {
      // Sempre carregar do JSON primeiro para garantir que a aplicação funcione
      final List<Unit> jsonUnits = await _loadUnitsFromJson();

      // Tentar migrar para Firebase em background (não bloquear a UI)
      _migrateToFirebaseInBackground(jsonUnits);

      return jsonUnits;
    } catch (e) {
      throw Exception('Erro ao carregar unidades do JSON: $e');
    }
  }

  // Migração em background para não bloquear a interface
  static void _migrateToFirebaseInBackground(List<Unit> jsonUnits) {
    if (_hasMigrated || jsonUnits.isEmpty) return;

    // Executar em background
    Future(() async {
      try {
        final bool hasFirebaseData = await FirebaseService.hasData();

        if (!hasFirebaseData) {
          await FirebaseService.migrateJsonDataToFirestore(jsonUnits);
          _hasMigrated = true;
          print('✅ Dados migrados para Firebase com sucesso!');
        }
      } catch (e) {
        print('⚠️ Erro na migração para Firebase: $e');
        // Continuar funcionando mesmo se o Firebase falhar
      }
    });
  }

  static Future<List<Unit>> _loadUnitsFromJson() async {
    try {
      print('🔄 Carregando unidades do JSON...');
      final String jsonString = await rootBundle.loadString('lib/data/units.json');
      print('✅ JSON carregado com sucesso. Tamanho: ${jsonString.length} caracteres');

      final dynamic decodedJson = json.decode(jsonString);
      final List<dynamic> jsonList = decodedJson as List<dynamic>;
      print('✅ JSON decodificado. ${jsonList.length} unidades encontradas');

      final List<Unit> units = jsonList.map((json) => Unit.fromJson(json as Map<String, dynamic>)).toList();
      print('✅ Unidades processadas com sucesso: ${units.map((u) => u.unitTitle).join(", ")}');

      return units;
    } catch (e) {
      print('❌ Erro ao carregar unidades do JSON: $e');
      throw Exception('Erro ao carregar unidades do JSON: $e');
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
