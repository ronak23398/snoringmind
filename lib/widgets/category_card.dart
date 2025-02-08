import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String icon;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.title,
    required this.icon,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? Colors.white
                : const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SvgPicture.asset(
            //   icon,
            //   height: 64,
            //   width: 64,
            //   color: isSelected
            //       ? Theme.of(context).primaryColor
            //       : Colors.grey.shade700,
            // ),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
