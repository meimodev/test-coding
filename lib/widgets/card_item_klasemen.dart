import 'package:flutter/material.dart';
import 'package:test_coding/models/klasemen.dart';

class CardItemKlasemen extends StatelessWidget {
  const CardItemKlasemen({
    super.key,
    required this.klasemen,
    required this.index,
  });

  final Klasemen klasemen;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.only(
          left: 24,
          top: 12,
          bottom: 12,
          right: 12,
        ),
        child: Row(
          children: [
            Text(index.toString(),
                style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(width: 24),
            Expanded(
              child: DefaultTextStyle(
                style: Theme.of(context).textTheme.labelSmall!,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${klasemen.club.name.toUpperCase()}, ${klasemen.club.city}",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text("Point ${klasemen.point}"),
                    const Divider(),
                    Column(
                      children: [
                        _buildRow(
                          "Play",
                          klasemen.play.toString(),
                          "Win",
                          klasemen.win.toString(),
                          "Win Goal",
                          klasemen.goalWin.toString(),
                        ),
                        _buildRow(
                          "Draw",
                          klasemen.draw.toString(),
                          "Lose",
                          klasemen.lose.toString(),
                          "Lose Goal",
                          klasemen.goalLose.toString(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildRow(
    String t1,
    String v1,
    String t2,
    String v2,
    String t3,
    String v3,
  ) =>
      Row(
        children: [
          Row(
            children: [
              SizedBox(width: 45, child: Text(t1)),
              SizedBox(width: 24, child: Text(v1)),
            ],
          ),
          const SizedBox(width: 12),
          Row(
            children: [
              SizedBox(width: 45, child: Text(t2)),
              SizedBox(width: 24, child: Text(v2)),
            ],
          ),
          const SizedBox(width: 12),
          Row(
            children: [
              SizedBox(width: 60, child: Text(t3)),
              SizedBox(width: 24, child: Text(v3)),
            ],
          ),
        ],
      );
}
