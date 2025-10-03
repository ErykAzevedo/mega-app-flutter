import 'package:flutter/material.dart';

import '../models/unit.dart';
import '../services/units_service.dart';
import '../widgets/filter_dropdown.dart';
import '../widgets/unit_card.dart';

class UnitsListScreen extends StatefulWidget {
  const UnitsListScreen({super.key});

  @override
  State<UnitsListScreen> createState() => _UnitsListScreenState();
}

class _UnitsListScreenState extends State<UnitsListScreen> {
  List<Unit> _allUnits = [];
  List<Unit> _filteredUnits = [];
  Set<String> _allTags = {};
  final Set<String> _selectedTags = {};
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadUnits();
  }

  Future<void> _loadUnits() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final units = await UnitsService.loadUnits();
      final allTags = UnitsService.getAllTags(units);

      setState(() {
        _allUnits = units;
        _filteredUnits = units;
        _allTags = allTags;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  void _onTagToggled(String tag) {
    setState(() {
      if (_selectedTags.contains(tag)) {
        _selectedTags.remove(tag);
      } else {
        _selectedTags.add(tag);
      }
      _applyFilters();
    });
  }

  void _onClearFilters() {
    setState(() {
      _selectedTags.clear();
      _applyFilters();
    });
  }

  void _applyFilters() {
    _filteredUnits = UnitsService.filterUnitsByTags(_allUnits, _selectedTags);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unidades Disponíveis (${_allUnits.length})'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          if (!_isLoading && _errorMessage == null)
            FilterDropdown(
              allTags: _allTags,
              selectedTags: _selectedTags,
              onTagToggled: _onTagToggled,
              onClearFilters: _onClearFilters,
            ),
          IconButton(icon: const Icon(Icons.refresh), onPressed: _loadUnits, tooltip: 'Recarregar'),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
            const SizedBox(height: 16),
            Text('Erro ao carregar unidades', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              _errorMessage!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _loadUnits,
              icon: const Icon(Icons.refresh),
              label: const Text('Tentar novamente'),
            ),
          ],
        ),
      );
    }

    return _buildUnitsList();
  }

  Widget _buildUnitsList() {
    if (_filteredUnits.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(_selectedTags.isEmpty ? Icons.home_outlined : Icons.search_off, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              _selectedTags.isEmpty ? 'Nenhuma unidade encontrada' : 'Nenhuma unidade corresponde aos filtros',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
            ),
            if (_selectedTags.isNotEmpty) ...[
              const SizedBox(height: 8),
              TextButton(onPressed: _onClearFilters, child: const Text('Limpar filtros')),
            ],
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: _filteredUnits.length,
      itemBuilder: (context, index) {
        return UnitCard(unit: _filteredUnits[index]);
      },
    );
  }
}
