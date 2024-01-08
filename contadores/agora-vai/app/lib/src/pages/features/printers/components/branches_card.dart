import 'package:app/src/core/helpers.dart';
import 'package:flutter/material.dart';

class BranchesCard extends StatelessWidget {
  final String title;
  final Function() onTap;
  const BranchesCard({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.print_rounded, size: 32),
              Text(title, style: Helpers.titleStyle),
            ],
          ),
        ),
      ),
    );
  }
}
