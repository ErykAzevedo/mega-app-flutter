import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/unit.dart';

class UnitCard extends StatelessWidget {
  const UnitCard({super.key, required this.unit});
  final Unit unit;

  Future<void> _openCalendar(String airbnbCode) async {
    print('airbnbCode: $airbnbCode');
    final url = Uri.parse('https://www.airbnb.com.br/multicalendar/$airbnbCode');

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _openMessages(String airbnbCode) async {
    final url = Uri.parse(
      'https://www.airbnb.com.br/hosting/messages/?inbox_type=hosting&stay_listing_ids=$airbnbCode',
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${unit.unitTitle} - ${unit.unitCode}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            // Wrap(
            //   spacing: 8,
            //   runSpacing: 4,
            //   children: unit.tags.map((tag) {
            //     return Chip(
            //       label: Text(tag, style: const TextStyle(fontSize: 12)),
            //       backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.1),
            //       side: BorderSide(color: Theme.of(context).primaryColor.withValues(alpha: 0.3)),
            //     );
            //   }).toList(),
            // ),
            // const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _openCalendar(unit.unitAirbnbCode),
                    icon: const Icon(Icons.calendar_month),
                    label: const Text('Calendário'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _openMessages(unit.unitAirbnbCode),
                    icon: const Icon(Icons.message),
                    label: const Text('Mensagens'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
