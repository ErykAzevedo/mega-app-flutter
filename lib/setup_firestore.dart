import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'models/unit.dart';
import 'services/firebase_service.dart';

// Script para popular o Firestore com dados de exemplo
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Dados de exemplo para popular o Firestore
  final List<Unit> sampleUnits = [
    Unit(
      unitCode: 'fiji',
      unitTitle: 'Apartamento maravilhoso em ubatuba',
      unitAirbnbCode: '745044364291229431',
      tags: ['ubatuba', 'praia-grande'],
    ),
    Unit(
      unitCode: 'setin',
      unitTitle: 'Apartamento maravilhoso no centro de SP',
      unitAirbnbCode: '1196359608063896510',
      tags: ['sao-paulo', 'centro'],
    ),
    Unit(
      unitCode: 'copacabana',
      unitTitle: 'Cobertura com vista para o mar em Copacabana',
      unitAirbnbCode: '123456789012345678',
      tags: ['rio-de-janeiro', 'copacabana', 'praia', 'cobertura'],
    ),
    Unit(
      unitCode: 'ipanema',
      unitTitle: 'Apartamento moderno em Ipanema',
      unitAirbnbCode: '987654321098765432',
      tags: ['rio-de-janeiro', 'ipanema', 'praia', 'moderno'],
    ),
  ];

  try {
    print('🔄 Populando Firestore com dados de exemplo...');

    // Verificar se já existem dados
    final bool hasData = await FirebaseService.hasData();

    if (!hasData) {
      await FirebaseService.migrateJsonDataToFirestore(sampleUnits);
      print('✅ Dados inseridos com sucesso no Firestore!');
      print('📋 ${sampleUnits.length} unidades adicionadas');
    } else {
      print('ℹ️ Firestore já contém dados');
    }

    // Testar carregamento
    final units = await FirebaseService.loadUnitsFromFirestore();
    print('✅ Teste de carregamento: ${units.length} unidades encontradas');
    for (final unit in units) {
      print('  - ${unit.unitTitle} (${unit.unitCode})');
    }
  } catch (e) {
    print('❌ Erro: $e');
  }

  print('🎯 Script concluído. Você pode agora executar a aplicação principal.');
}
