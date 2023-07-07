import 'package:flutter/material.dart';

class ScreenWrapper extends StatelessWidget {
  const ScreenWrapper(
      {super.key, this.body, this.onClickAddData, this.onClickAddScore});

  final Widget? body;
  final void Function()? onClickAddData;
  final void Function()? onClickAddScore;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text("Test Coding"),
        //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // ),
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _BuildCustomButton(
              icon: Icons.add,
              text: 'club data',
              onClick: onClickAddData,
            ),
            _BuildCustomButton(
              icon: Icons.add,
              text: 'club score',
              onClick: onClickAddScore,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
          child: body,
        ),
      ),
    );
  }
}

class _BuildCustomButton extends StatelessWidget {
  const _BuildCustomButton({
    required this.icon,
    required this.text,
    this.onClick,
  });

  final IconData icon;
  final String text;
  final void Function()? onClick;

  @override
  Widget build(BuildContext context) {
    if (onClick == null) {
      return const SizedBox();
    }

    return SizedBox(
      width: 140,
      child: FilledButton(
        onPressed: onClick,
        child: Row(
          children: [
            Icon(icon, size: 14),
            const SizedBox(width: 6),
            Expanded(child: Text(text)),
          ],
        ),
      ),
    );
  }
}
