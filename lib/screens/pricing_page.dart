import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snoringmind3/controllers/home_controller.dart';
import 'package:snoringmind3/widgets/nav_bar.dart';
import 'package:snoringmind3/widgets/pricing_card.dart';
import 'package:snoringmind3/widgets/responsive_wrapper.dart';

class PricingPage extends StatelessWidget {
  const PricingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

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
                    'Pricing Plans',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Choose the plan that fits your needs',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                  ),
                  const SizedBox(height: 48),
                  ResponsiveWrapper(
                    mobile: Column(
                      children: controller.plans
                          .map((plan) => PricingCard(
                                plan: plan,
                                isSelected: controller.selectedPlan.value ==
                                    controller.plans.indexOf(plan),
                                onTap: () => controller.selectedPlan.value =
                                    controller.plans.indexOf(plan),
                              ))
                          .toList(),
                    ),
                    desktop: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: controller.plans
                          .map((plan) => Expanded(
                                child: PricingCard(
                                  plan: plan,
                                  isSelected: controller.selectedPlan.value ==
                                      controller.plans.indexOf(plan),
                                  onTap: () => controller.selectedPlan.value =
                                      controller.plans.indexOf(plan),
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
}
