import 'package:flutter/material.dart';

enum SortOption {
  unitTitle('Título da Unidade'),
  unitAirbnbCode('Código Airbnb');

  const SortOption(this.label);
  final String label;
}

class SortDropdown extends StatelessWidget {
  const SortDropdown({super.key, required this.selectedSortOption, required this.onSortOptionChanged});

  final SortOption selectedSortOption;
  final void Function(SortOption?) onSortOptionChanged;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SortOption>(
      icon: const Icon(Icons.sort),
      tooltip: 'Ordenar por',
      onSelected: onSortOptionChanged,
      itemBuilder: (context) => SortOption.values.map((option) {
        return PopupMenuItem<SortOption>(
          value: option,
          child: Row(
            children: [
              Icon(
                selectedSortOption == option ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              ),
              const SizedBox(width: 8),
              Text(option.label),
            ],
          ),
        );
      }).toList(),
    );
  }
}
