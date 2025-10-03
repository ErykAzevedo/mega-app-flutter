import '../models/unit.dart';
import 'firebase_service.dart';

class UnitsService {
  // Carregar unidades diretamente do Firestore
  static Future<List<Unit>> loadUnits() async {
    try {
      print('🔄 Carregando unidades do Firestore...');
      final List<Unit> units = await FirebaseService.loadUnitsFromFirestore();
      print('✅ ${units.length} unidades carregadas do Firestore com sucesso');
      print('📋 Unidades: ${units.map((u) => u.unitTitle).join(", ")}');
      return units;
    } catch (e) {
      print('❌ Erro ao carregar unidades do Firestore: $e');
      throw Exception('Erro ao carregar unidades do Firestore: $e');
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
