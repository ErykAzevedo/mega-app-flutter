import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/unit.dart';

class FirebaseService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _unitsCollection = 'units';

  // Carregar unidades do Firestore
  static Future<List<Unit>> loadUnitsFromFirestore() async {
    try {
      final QuerySnapshot snapshot = await _firestore.collection(_unitsCollection).orderBy('unitTitle').get();

      return snapshot.docs.map((doc) => Unit.fromJson({...doc.data() as Map<String, dynamic>, 'id': doc.id})).toList();
    } catch (e) {
      throw Exception('Erro ao carregar unidades do Firebase: $e');
    }
  }

  // Adicionar nova unidade
  static Future<void> addUnit(Unit unit) async {
    try {
      await _firestore.collection(_unitsCollection).add(unit.toJson());
    } catch (e) {
      throw Exception('Erro ao adicionar unidade: $e');
    }
  }

  // Atualizar unidade existente
  static Future<void> updateUnit(String unitId, Unit unit) async {
    try {
      await _firestore.collection(_unitsCollection).doc(unitId).update(unit.toJson());
    } catch (e) {
      throw Exception('Erro ao atualizar unidade: $e');
    }
  }

  // Deletar unidade
  static Future<void> deleteUnit(String unitId) async {
    try {
      await _firestore.collection(_unitsCollection).doc(unitId).delete();
    } catch (e) {
      throw Exception('Erro ao deletar unidade: $e');
    }
  }

  // Inicializar com dados do JSON (migração inicial)
  static Future<void> migrateJsonDataToFirestore(List<Unit> units) async {
    try {
      final batch = _firestore.batch();

      for (final unit in units) {
        final docRef = _firestore.collection(_unitsCollection).doc();
        batch.set(docRef, unit.toJson());
      }

      await batch.commit();
    } catch (e) {
      throw Exception('Erro na migração dos dados: $e');
    }
  }

  // Verificar se já existem dados no Firestore
  static Future<bool> hasData() async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection(_unitsCollection)
          .limit(1)
          .get()
          .timeout(const Duration(seconds: 5)); // Timeout para evitar travamento

      return snapshot.docs.isNotEmpty;
    } catch (e) {
      print('⚠️ Erro ao verificar dados no Firebase: $e');
      return false;
    }
  }
}
