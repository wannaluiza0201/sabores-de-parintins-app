import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../data/models/business_hour.dart';

/// Tabela vertical de horários (7 dias). O dia atual fica destacado.
///
/// Lista vazia → mostra placeholder cinza (graceful degradation).
class HoursTable extends StatelessWidget {
  const HoursTable({super.key, required this.hours});

  final List<BusinessHour> hours;

  @override
  Widget build(BuildContext context) {
    if (hours.isEmpty) {
      return _Empty();
    }

    // DateTime.weekday: 1=Segunda..7=Domingo. A API usa 0=Domingo..6=Sábado.
    // Conversão: weekday % 7 → 0..6 (Domingo..Sábado).
    final todayDow = DateTime.now().weekday % 7;

    // Ordena na ordem da API (Dom→Sáb).
    final ordered = [...hours]..sort((a, b) => a.dayOfWeek.compareTo(b.dayOfWeek));

    return Column(
      children: ordered.map((h) {
        final isToday = h.dayOfWeek == todayDow;
        return _Row(hour: h, highlighted: isToday);
      }).toList(),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.hour, required this.highlighted});
  final BusinessHour hour;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final timeText = hour.isClosed
        ? AppLocalizations.of(context)!.statusClosed
        : '${hour.opensAt ?? '--:--'} – ${hour.closesAt ?? '--:--'}';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: highlighted ? AppColors.primary.withValues(alpha: 0.10) : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              hour.dayName,
              style: TextStyle(
                fontSize: 14,
                fontWeight: highlighted ? FontWeight.w700 : FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Text(
            timeText,
            style: TextStyle(
              fontSize: 14,
              fontWeight: highlighted ? FontWeight.w600 : FontWeight.w400,
              color: hour.isClosed
                  ? AppColors.textSecondary
                  : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      alignment: Alignment.center,
      child: Column(
        children: [
          Icon(
            Icons.schedule,
            size: 40,
            color: AppColors.textSecondary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.hoursEmpty,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
