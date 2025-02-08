import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:snoringmind3/firebase_options.dart';
import 'package:snoringmind3/screens/about_page.dart';
import 'package:snoringmind3/screens/blog_page.dart';
import 'package:snoringmind3/screens/contact_page.dart';
import 'package:snoringmind3/screens/home_page.dart';
import 'package:snoringmind3/screens/pricing_page.dart';
import 'package:snoringmind3/screens/services_page.dart';
import 'package:snoringmind3/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Counseling Psychology',
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(), // Added const
        '/about': (context) => const AboutPage(),
        '/services': (context) => const ServicesPage(),
        '/pricing': (context) => const PricingPage(),
        '/blog': (context) => const BlogPage(),
        '/contact': (context) => const ContactPage(),
      },
    );
  }
}
