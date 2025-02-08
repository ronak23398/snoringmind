import 'package:flutter/material.dart';
import 'package:snoringmind3/widgets/nav_bar.dart';
import 'package:snoringmind3/widgets/responsive_wrapper.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomNavigationBar(),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 32),
              child: Column(
                children: [
                  Text(
                    'Our Services',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(height: 48),
                  ResponsiveWrapper(
                    mobile: Column(
                      children: _buildServices(),
                    ),
                    desktop: Row(
                      children: _buildServices()
                          .map((service) => Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: service,
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildServices() {
    return [
      _ServiceCard(
        title: 'Individual Counseling',
        icon: Icons.person,
        description: 'One-on-one sessions tailored to your needs',
        features: [
          'Personalized treatment plans',
          'Flexible scheduling',
          'Choice of communication method',
          'Progress tracking',
        ],
      ),
      _ServiceCard(
        title: 'Couple Therapy',
        icon: Icons.favorite,
        description: 'Strengthen your relationship with professional guidance',
        features: [
          'Relationship assessment',
          'Communication training',
          'Conflict resolution',
          'Joint session planning',
        ],
      ),
      _ServiceCard(
        title: 'Group Therapy',
        icon: Icons.group,
        description: 'Connect with others facing similar challenges',
        features: [
          'Moderated group sessions',
          'Peer support',
          'Themed discussions',
          'Skills workshops',
        ],
      ),
    ];
  }
}

class _ServiceCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String description;
  final List<String> features;

  const _ServiceCard({
    required this.title,
    required this.icon,
    required this.description,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 48,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 24),
          ...features.map((feature) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Theme.of(context).primaryColor,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(feature),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
