import 'package:flutter/material.dart';
import 'package:snoringmind3/widgets/nav_bar.dart';
import 'package:snoringmind3/widgets/responsive_wrapper.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

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
                    'Blog',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Latest insights and articles on mental health',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                  ),
                  const SizedBox(height: 48),
                  ResponsiveWrapper(
                    mobile: Column(
                      children: _buildBlogPosts(),
                    ),
                    desktop: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      childAspectRatio: 0.8,
                      mainAxisSpacing: 32,
                      crossAxisSpacing: 32,
                      children: _buildBlogPosts(),
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

  List<Widget> _buildBlogPosts() {
    return [
      _BlogCard(
        title: 'Understanding Anxiety in the Modern World',
        image: 'assets/images/blog1.jpg',
        category: 'Mental Health',
        date: 'Feb 5, 2024',
        excerpt:
            'Learn about the common triggers of anxiety and effective coping strategies.',
      ),
      _BlogCard(
        title: 'The Impact of Social Media on Mental Health',
        image: 'assets/images/blog2.jpg',
        category: 'Digital Wellness',
        date: 'Feb 3, 2024',
        excerpt:
            'Explore how social media affects our mental well-being and tips for healthy usage.',
      ),
      _BlogCard(
        title: 'Building Resilience in Challenging Times',
        image: 'assets/images/blog3.jpg',
        category: 'Self-Help',
        date: 'Feb 1, 2024',
        excerpt:
            'Discover practical ways to build emotional resilience and cope with stress.',
      ),
    ];
  }
}

class _BlogCard extends StatelessWidget {
  final String title;
  final String image;
  final String category;
  final String date;
  final String excerpt;

  const _BlogCard({
    required this.title,
    required this.image,
    required this.category,
    required this.date,
    required this.excerpt,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
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
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              image,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      date,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  excerpt,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    // TODO: Implement blog post navigation
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Read More',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward,
                        size: 16,
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
