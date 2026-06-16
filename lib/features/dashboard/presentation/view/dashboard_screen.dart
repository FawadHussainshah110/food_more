import 'package:flutter/services.dart';
import 'package:food_app_task/features/cart/presentation/controller/cart_controller.dart';
import 'package:food_app_task/features/cart/presentation/view/cart_screen.dart';
import 'package:food_app_task/features/dashboard/presentation/components/dashboard_nav_item.dart';
import 'package:food_app_task/features/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:food_app_task/features/home/presentation/view/home_screen.dart';
import 'package:food_app_task/features/orders/presentation/view/order_history_screen.dart';
import 'package:food_app_task/features/profile/presentation/view/profile_screen.dart';
import 'package:food_app_task/features/search/presentation/view/search_screen.dart';
import 'package:food_app_task/imports.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const HomeScreen(),
      const SearchScreen(),
      const CartScreen(),
      const OrderHistoryScreen(),
      const ProfileScreen(),
    ];

    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Scaffold(
          extendBody: true,
          body: IndexedStack(
            index: controller.currentIndex,
            children: screens,
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: spacingDefault, vertical: spacingSmall),
              child: GlassContainer(
                borderRadius: radiuslarge,
                blur: 15,
                bgGradientStart: context.theme.colorScheme.onSurface.withValues(alpha: 0.08),
                bgGradientEnd: context.theme.colorScheme.onSurface.withValues(alpha: 0.02),
                child: Container(
                  height: 64.sp,
                  padding: EdgeInsets.symmetric(horizontal: spacingSmall),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DashboardNavItem(
                        index: 0,
                        activeIcon: Icons.home_rounded,
                        inactiveIcon: Icons.home_outlined,
                        label: 'Home',
                        isSelected: controller.currentIndex == 0,
                        onTap: () {
                          HapticFeedback.lightImpact();
                          controller.changeIndex(0);
                        },
                      ),
                      DashboardNavItem(
                        index: 1,
                        activeIcon: Icons.search_rounded,
                        inactiveIcon: Icons.search_rounded,
                        label: 'Search',
                        isSelected: controller.currentIndex == 1,
                        onTap: () {
                          HapticFeedback.lightImpact();
                          controller.changeIndex(1);
                        },
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          DashboardNavItem(
                            index: 2,
                            activeIcon: Icons.shopping_bag_rounded,
                            inactiveIcon: Icons.shopping_bag_outlined,
                            label: 'Cart',
                            isSelected: controller.currentIndex == 2,
                            onTap: () {
                              HapticFeedback.lightImpact();
                              controller.changeIndex(2);
                            },
                          ),
                          Positioned(
                            top: 10.sp,
                            right: 12.sp,
                            child: GetBuilder<CartController>(
                              builder: (cart) {
                                final count = cart.totalItemsCount;
                                if (count == 0) return const SizedBox.shrink();
                                return ScaleBounceAnimation(
                                  child: Container(
                                    padding: EdgeInsets.all(spacingExtraSmall),
                                    decoration: BoxDecoration(color: context.theme.colorScheme.error, shape: BoxShape.circle),
                                    constraints: BoxConstraints(minWidth: 16.sp, minHeight: 16.sp),
                                    child: Text(
                                      '$count',
                                      style: labelSmall(
                                        context,
                                      ).copyWith(color: context.theme.colorScheme.onPrimary, fontSize: 9.sp, fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      DashboardNavItem(
                        index: 3,
                        activeIcon: Icons.receipt_long_rounded,
                        inactiveIcon: Icons.receipt_long_outlined,
                        label: 'Orders',
                        isSelected: controller.currentIndex == 3,
                        onTap: () {
                          HapticFeedback.lightImpact();
                          controller.changeIndex(3);
                        },
                      ),
                      DashboardNavItem(
                        index: 4,
                        activeIcon: Icons.person_rounded,
                        inactiveIcon: Icons.person_outline_rounded,
                        label: 'Profile',
                        isSelected: controller.currentIndex == 4,
                        onTap: () {
                          HapticFeedback.lightImpact();
                          controller.changeIndex(4);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
