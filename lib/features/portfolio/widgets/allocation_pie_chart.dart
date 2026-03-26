import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:trading/features/portfolio/data/models/allocation_data.dart';

class AllocationPieChart extends StatelessWidget {
  final List<AllocationData> allocations;

  const AllocationPieChart({super.key, required this.allocations});

  @override
  Widget build(BuildContext context) {
    final sorted = List<AllocationData>.from(allocations);
    sorted.sort((a, b) => b.value.compareTo(a.value));

    final total = sorted.fold<double>(0, (sum, d) => sum + d.value);

    return AspectRatio(
      aspectRatio: 1.2,
      child: PieChart(
        PieChartData(
          sections: sorted.map((data) {
            final value = data.value;
            final percentage = total > 0 ? (value / total) * 100 : 0;
            return PieChartSectionData(
              value: value,
              title: '${percentage.toStringAsFixed(1)}%',
              color: data.color,
              radius: 80,
              titleStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            );
          }).toList(),
          borderData: FlBorderData(show: false),
          sectionsSpace: 2,
          centerSpaceRadius: 40,
        ),
      ),
    );
  }
}
