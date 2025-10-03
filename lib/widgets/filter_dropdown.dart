import 'package:flutter/material.dart';

class FilterDropdown extends StatelessWidget {
  const FilterDropdown({
    super.key,
    required this.allTags,
    required this.selectedTags,
    required this.onTagToggled,
    required this.onClearFilters,
  });
  final Set<String> allTags;
  final Set<String> selectedTags;
  final void Function(String) onTagToggled;
  final VoidCallback onClearFilters;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Stack(
        children: [
          const Icon(Icons.filter_list),
          if (selectedTags.isNotEmpty)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(6)),
                constraints: const BoxConstraints(minWidth: 12, minHeight: 12),
                child: Text(
                  '${selectedTags.length}',
                  style: const TextStyle(color: Colors.white, fontSize: 8),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
      tooltip: 'Filtrar por tags',
      itemBuilder: (BuildContext context) {
        final List<PopupMenuEntry<String>> items = [];

        // Adiciona opção "Limpar filtros" se há filtros ativos
        if (selectedTags.isNotEmpty) {
          items.add(
            PopupMenuItem<String>(
              value: '__clear__',
              child: Row(
                children: [
                  Icon(Icons.clear, color: Theme.of(context).colorScheme.error),
                  const SizedBox(width: 8),
                  Text('Limpar filtros', style: TextStyle(color: Theme.of(context).colorScheme.error)),
                ],
              ),
            ),
          );
          items.add(const PopupMenuDivider());
        }

        // Adiciona todas as tags
        for (final tag in allTags) {
          final isSelected = selectedTags.contains(tag);
          items.add(
            PopupMenuItem<String>(
              value: tag,
              child: Row(
                children: [
                  Icon(
                    isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                    color: isSelected ? Theme.of(context).primaryColor : null,
                  ),
                  const SizedBox(width: 8),
                  Expanded(child: Text(tag)),
                ],
              ),
            ),
          );
        }

        return items;
      },
      onSelected: (String value) {
        if (value == '__clear__') {
          onClearFilters();
        } else {
          onTagToggled(value);
        }
      },
    );
  }
}
