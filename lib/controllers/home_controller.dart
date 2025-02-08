import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxInt selectedCategory = 0.obs;
  final RxInt selectedPlan = 0.obs;

  final List<Map<String, dynamic>> categories = [
    {
      'title': 'Students',
      'icon': 'assets/icons/student.svg',
      'description': 'Academic stress, career guidance, and personal growth',
    },
    {
      'title': 'Teens',
      'icon': 'assets/icons/teen.svg',
      'description': 'Navigate adolescence, relationships, and self-discovery',
    },
    {
      'title': 'Couples',
      'icon': 'assets/icons/couple.svg',
      'description': 'Strengthen relationships and improve communication',
    },
    {
      'title': 'Workplace',
      'icon': 'assets/icons/workplace.svg',
      'description': 'Work-life balance and professional development',
    },
    {
      'title': 'Depression',
      'icon': 'assets/icons/depression.svg',
      'description': 'Professional support for managing depression',
    },
    {
      'title': 'Anxiety',
      'icon': 'assets/icons/anxiety.svg',
      'description': 'Tools and techniques to cope with anxiety',
    },
  ];

  final List<Map<String, dynamic>> statistics = [
    {'value': '10,000+', 'label': 'Appointments Completed'},
    {'value': '50+', 'label': 'Expert Counselors'},
    {'value': '95%', 'label': 'Success Rate'},
    {'value': '4.9/5', 'label': 'Client Satisfaction'},
  ];

  final List<Map<String, dynamic>> plans = [
    {
      'name': 'Basic',
      'price': '₹999/month',
      'features': [
        'Chat support',
        '2 sessions per month',
        'Email support',
        'Self-help resources',
      ],
    },
    {
      'name': 'Standard',
      'price': '₹1,999/month',
      'features': [
        'Chat & Call support',
        '4 sessions per month',
        'Priority email support',
        'Self-help resources',
        'Weekly progress tracking',
      ],
    },
    {
      'name': 'Premium',
      'price': '₹3,999/month',
      'features': [
        'Chat, Call & Video support',
        '8 sessions per month',
        '24/7 priority support',
        'Self-help resources',
        'Weekly progress tracking',
        'Offline sessions',
        'Family counseling',
      ],
    },
  ];
}
