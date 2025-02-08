import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snoringmind3/controllers/home_controller.dart';
import 'package:snoringmind3/widgets/animated_hero_section.dart';
import 'package:snoringmind3/widgets/mental_health_items.dart';
import 'package:snoringmind3/widgets/nav_bar.dart';
import 'package:snoringmind3/widgets/responsive_wrapper.dart';
import 'package:snoringmind3/widgets/step_item.dart';

import '../widgets/category_card.dart';

class HomePage extends StatelessWidget {
  final HomeController controller;
  final ScrollController _scrollController = ScrollController();

  HomePage({super.key}) : controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      extendBodyBehindAppBar:
          true, // This allows content to go behind the app bar
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: CustomNavigationBar(),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            AnimatedHeroSection(),
            //
            ScrollingMentalHealthWidget(),
            // Categories Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
              child: Column(
                children: [
                  const Text(
                    'Explore Our Services',
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 24),
                  GetBuilder<HomeController>(
                    builder: (controller) => ResponsiveWrapper(
                      mobile: Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: controller.categories.map((category) {
                          return CategoryCard(
                            title: category['title'],
                            icon: category['icon'],
                            description: category['description'],
                            isSelected: controller.selectedCategory.value ==
                                controller.categories.indexOf(category),
                            onTap: () => controller.selectedCategory.value =
                                controller.categories.indexOf(category),
                          );
                        }).toList(),
                      ),
                      desktop: Row(
                        spacing: 9,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: controller.categories.map((category) {
                          return Expanded(
                            child: CategoryCard(
                              title: category['title'],
                              icon: category['icon'],
                              description: category['description'],
                              isSelected: controller.selectedCategory.value ==
                                  controller.categories.indexOf(category),
                              onTap: () => controller.selectedCategory.value =
                                  controller.categories.indexOf(category),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // How It Works Section
            Container(
              padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 32),
              decoration: BoxDecoration(color: Colors.grey.shade100),
              child: Column(
                children: [
                  const Text(
                    'How It Works',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32),
                  ResponsiveWrapper(
                    mobile: Column(
                      children: _buildSteps(),
                    ),
                    desktop: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildSteps(),
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

  List<Widget> _buildSteps() {
    return [
      StepItem(
        number: '1',
        title: 'Request an Appointment',
        description:
            'Fill in your details and\n choose a category that best fits your needs',
        icon: Icons.calendar_today,
      ),
      StepItem(
        number: '2',
        title: 'Get Matched',
        description:
            'Well match you with a certified counselor\n based on your needs',
        icon: Icons.people,
      ),
      StepItem(
        number: '3',
        title: 'Choose Your Format',
        description:
            'Select between chat, video, call, \nor in-person sessions',
        icon: Icons.forum,
      ),
      StepItem(
        number: '4',
        title: 'Start Your Journey',
        description: 'Begin your sessions and \nreceive continuous support',
        icon: Icons.psychology,
      ),
    ];
  }
}
