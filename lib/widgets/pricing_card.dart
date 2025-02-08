import 'package:flutter/material.dart';

class PricingCard extends StatelessWidget {
  final Map<String, dynamic> plan;
  final bool isSelected;
  final VoidCallback onTap;

  const PricingCard({
    super.key,
    required this.plan,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).primaryColor.withOpacity(0.1)
                : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : Colors.grey.shade300,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                plan['name'],
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                plan['price'],
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Colors.black87,
                ),
              ),
              const SizedBox(height: 24),
              ...plan['features']
                  .map<Widget>((feature) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: isSelected
                                  ? Theme.of(context).primaryColor
                                  : Colors.green,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                feature,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: isSelected
                                      ? Theme.of(context).primaryColor
                                      : Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isSelected
                      ? Theme.of(context).primaryColor
                      : Colors.white,
                  foregroundColor: isSelected
                      ? Colors.white
                      : Theme.of(context).primaryColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                child: const Text(
                  'Get Started',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
