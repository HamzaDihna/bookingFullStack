import 'package:flutter/material.dart';

class FilterChipWidget extends StatelessWidget {
  final String label;
  final VoidCallback onRemove;

  const FilterChipWidget({
    super.key,
    required this.label,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Chip(
        label: Text(label),
        deleteIcon: const Icon(Icons.close, size: 18),
        onDeleted: onRemove,
        backgroundColor: Colors.grey.shade200,
      ),
    );
  }
}
