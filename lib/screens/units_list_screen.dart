import 'package:flutter/material.dart';

import '../models/unit.dart';
import '../services/units_service.dart';
import '../widgets/filter_dropdown.dart';
import '../widgets/sort_dropdown.dart';
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
  SortOption _selectedSortOption = SortOption.unitTitle;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadUnits();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
      _applyFilters();
    });
  }

  void _onClearSearch() {
    setState(() {
      _searchController.clear();
      _searchQuery = '';
      _applyFilters();
    });
  }

  void _applyFilters() {
    // Primeiro aplicar filtro por tags
    final List<Unit> tagFilteredUnits = UnitsService.filterUnitsByTags(_allUnits, _selectedTags);

    // Depois aplicar busca livre
    if (_searchQuery.isNotEmpty) {
      _filteredUnits = tagFilteredUnits.where((unit) {
        return unit.unitTitle.toLowerCase().contains(_searchQuery) ||
            unit.unitCode.toLowerCase().contains(_searchQuery);
      }).toList();
    } else {
      _filteredUnits = tagFilteredUnits;
    }

    _applySorting();
  }

  void _applySorting() {
    _filteredUnits.sort((a, b) {
      switch (_selectedSortOption) {
        case SortOption.unitTitle:
          return a.unitTitle.toLowerCase().compareTo(b.unitTitle.toLowerCase());
        case SortOption.unitAirbnbCode:
          return a.unitAirbnbCode.toLowerCase().compareTo(b.unitAirbnbCode.toLowerCase());
      }
    });
  }

  void _onSortOptionChanged(SortOption? newOption) {
    if (newOption != null && newOption != _selectedSortOption) {
      setState(() {
        _selectedSortOption = newOption;
        _applySorting();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unidades (${_allUnits.length})'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          if (!_isLoading && _errorMessage == null) ...[
            SortDropdown(selectedSortOption: _selectedSortOption, onSortOptionChanged: _onSortOptionChanged),
            FilterDropdown(
              allTags: _allTags,
              selectedTags: _selectedTags,
              onTagToggled: _onTagToggled,
              onClearFilters: _onClearFilters,
            ),
          ],
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadUnits,
        child: Column(
          children: [
            if (!_isLoading && _errorMessage == null) _buildSearchField(),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _searchController,
        onChanged: _onSearchChanged,
        decoration: InputDecoration(
          hintText: 'Buscar por título ou código...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(icon: const Icon(Icons.clear), onPressed: _onClearSearch)
              : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height - 200,
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
          ),
        ],
      );
    }

    return _buildUnitsList();
  }

  Widget _buildUnitsList() {
    if (_filteredUnits.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height - 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(_selectedTags.isEmpty ? Icons.home_outlined : Icons.search_off, size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  _getEmptyStateMessage(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
                ),
                if (_selectedTags.isNotEmpty || _searchQuery.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  TextButton(onPressed: _onClearFilters, child: const Text('Limpar filtros')),
                ],
              ],
            ),
          ),
        ],
      );
    }

    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: _filteredUnits.length,
      itemBuilder: (context, index) {
        return UnitCard(unit: _filteredUnits[index]);
      },
    );
  }

  String _getEmptyStateMessage() {
    if (_selectedTags.isEmpty && _searchQuery.isEmpty) {
      return 'Nenhuma unidade encontrada';
    } else if (_selectedTags.isNotEmpty && _searchQuery.isNotEmpty) {
      return 'Nenhuma unidade corresponde aos filtros e busca';
    } else if (_selectedTags.isNotEmpty) {
      return 'Nenhuma unidade corresponde aos filtros';
    } else {
      return 'Nenhuma unidade corresponde à busca';
    }
  }
}
