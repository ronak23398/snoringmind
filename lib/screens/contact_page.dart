import 'package:flutter/material.dart';
import 'package:snoringmind3/widgets/nav_bar.dart';
import 'package:snoringmind3/widgets/responsive_wrapper.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomNavigationBar(),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 32),
              child: ResponsiveWrapper(
                mobile: const Column(
                  children: [
                    _ContactForm(),
                    SizedBox(height: 48),
                    _ContactInfo(),
                  ],
                ),
                desktop: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _ContactForm()),
                    SizedBox(width: 64),
                    Expanded(child: _ContactInfo()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactForm extends StatelessWidget {
  const _ContactForm();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Get in Touch',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'We\'re here to help and answer any questions you might have',
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 32),
          _ContactTextField(
            label: 'Name',
            hintText: 'Enter your full name',
          ),
          const SizedBox(height: 16),
          _ContactTextField(
            label: 'Email',
            hintText: 'Enter your email address',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          _ContactTextField(
            label: 'Phone',
            hintText: 'Enter your phone number',
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16),
          _ContactTextField(
            label: 'Message',
            hintText: 'How can we help you?',
            maxLines: 4,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // TODO: Implement form submission
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Send Message'),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextInputType? keyboardType;
  final int? maxLines;

  const _ContactTextField({
    required this.label,
    required this.hintText,
    this.keyboardType,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          keyboardType: keyboardType,
          maxLines: maxLines,
        ),
      ],
    );
  }
}

class _ContactInfo extends StatelessWidget {
  const _ContactInfo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Information',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 32),
        _ContactInfoItem(
          icon: Icons.location_on,
          title: 'Address',
          content:
              '123 Counseling Street\nMental Health Building\nNew Delhi, India',
        ),
        const SizedBox(height: 24),
        _ContactInfoItem(
          icon: Icons.phone,
          title: 'Phone',
          content: '+91 123 456 7890\n+91 098 765 4321',
        ),
        const SizedBox(height: 24),
        _ContactInfoItem(
          icon: Icons.email,
          title: 'Email',
          content: 'help@counseling.com\nsupport@counseling.com',
        ),
        const SizedBox(height: 48),
        const _SocialLinks(),
      ],
    );
  }
}

class _ContactInfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const _ContactInfoItem({
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 24,
          color: Theme.of(context).primaryColor,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                content,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SocialLinks extends StatelessWidget {
  const _SocialLinks();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Follow Us',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _SocialIcon(
              icon: Icons.facebook,
              onTap: () {
                // TODO: Implement social media navigation
              },
            ),
            _SocialIcon(
              icon: Icons.telegram,
              onTap: () {
                // TODO: Implement social media navigation
              },
            ),
            _SocialIcon(
              icon: Icons.facebook,
              onTap: () {
                // TODO: Implement social media navigation
              },
            ),
            _SocialIcon(
              icon: Icons.link,
              onTap: () {
                // TODO: Implement social media navigation
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _SocialIcon({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 24,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
