import 'package:flutter/material.dart';
import 'package:snoringmind3/widgets/nav_bar.dart';
import 'package:snoringmind3/widgets/responsive_wrapper.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomNavigationBar(),
            // Hero Section
            Container(
              padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 32),
              color: Theme.of(context).primaryColor,
              child: ResponsiveWrapper(
                mobile: const Column(
                  children: [
                    _AboutHeroContent(),
                    SizedBox(height: 32),
                    // _AboutImage(),
                  ],
                ),
                desktop: const Row(
                  children: [
                    Expanded(child: _AboutHeroContent()),
                    SizedBox(width: 64),
                    // Expanded(child: _AboutImage()),
                  ],
                ),
              ),
            ),
            // Team Section
            const _TeamSection(),
            // Mission Section
            // const _MissionSection(),
          ],
        ),
      ),
    );
  }
}

class _AboutHeroContent extends StatelessWidget {
  const _AboutHeroContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About Us',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: Colors.white,
              ),
        ),
        const SizedBox(height: 24),
        Text(
          'Leading the way in online mental health care',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white70,
              ),
        ),
        const SizedBox(height: 16),
        Text(
          'We believe everyone deserves access to quality mental health care. Our platform connects you with certified professionals who can help you navigate life\'s challenges.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white70,
              ),
        ),
      ],
    );
  }
}

// class _AboutImage extends StatelessWidget {
//   const _AboutImage();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 400,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16),
//         image: const DecorationImage(
//           image: AssetImage('assets/images/about-hero.jpg'),
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }
// }

class _TeamSection extends StatelessWidget {
  const _TeamSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 32),
      child: Column(
        children: [
          Text(
            'Our Team',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: 48),
          ResponsiveWrapper(
            mobile: Column(
              children: _buildTeamMembers(),
            ),
            desktop: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildTeamMembers(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTeamMembers() {
    return [
      _TeamMemberCard(
        name: 'Dr. Sarah Johnson',
        role: 'Chief Counseling Officer',
        image: 'assets/images/team1.jpg',
        description: '15+ years experience in clinical psychology',
      ),
      _TeamMemberCard(
        name: 'Dr. Michael Chen',
        role: 'Head of Therapy',
        image: 'assets/images/team2.jpg',
        description: 'Specialist in cognitive behavioral therapy',
      ),
      _TeamMemberCard(
        name: 'Dr. Emily Williams',
        role: 'Senior Counselor',
        image: 'assets/images/team3.jpg',
        description: 'Expert in relationship counseling',
      ),
    ];
  }
}

class _TeamMemberCard extends StatelessWidget {
  final String name;
  final String role;
  final String image;
  final String description;

  const _TeamMemberCard({
    required this.name,
    required this.role,
    required this.image,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        width: 300,
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
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(image),
            ),
            const SizedBox(height: 16),
            Text(
              name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              role,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).primaryColor,
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
          ],
        ),
      ),
    );
  }
}
