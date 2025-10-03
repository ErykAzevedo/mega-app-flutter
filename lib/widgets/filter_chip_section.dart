import 'package:flutter/material.dart';

class FilterChipSection extends StatelessWidget {
  const FilterChipSection({
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
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filtrar por tags:',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              if (selectedTags.isNotEmpty) TextButton(onPressed: onClearFilters, child: const Text('Limpar filtros')),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: allTags.map((tag) {
              final isSelected = selectedTags.contains(tag);
              return FilterChip(
                label: Text(tag),
                selected: isSelected,
                onSelected: (_) => onTagToggled(tag),
                selectedColor: Theme.of(context).primaryColor.withOpacity(0.2),
                checkmarkColor: Theme.of(context).primaryColor,
              );
            }).toList(),
          ),
          if (selectedTags.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              'Filtros ativos: ${selectedTags.join(", ")}',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey[600], fontStyle: FontStyle.italic),
            ),
          ],
        ],
      ),
    );
  }
}
