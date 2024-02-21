import 'package:flutter/material.dart';
import 'package:kerja_praktek/frontend/presentation/history/widget/history_card.dart';

class HistorySection extends StatelessWidget {
  const HistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1.1,
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
        ),
        itemCount: 8,
        itemBuilder: (context, index) => const HistoryCard(),
      ),
    );
  }
}
