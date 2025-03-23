import 'package:ecommerce_assignment/features/auth/presentation/screens/profile_screen.dart';
import 'package:ecommerce_assignment/features/cart/presentation/screens/cart_screen.dart';
import 'package:ecommerce_assignment/features/main/tab_item_widget.dart';
import 'package:ecommerce_assignment/features/orders/presentation/screens/orders_screen.dart';
import 'package:ecommerce_assignment/features/products/presentation/screens/product_listing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const route = '/main';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ValueNotifier<int> currentIndexNotifier = ValueNotifier(0);
  final PageController pageController = PageController();

  final List<NavigatorTab> tabs = [
    NavigatorTab(title: 'Products', icon: Icons.home),
    NavigatorTab(title: 'Cart', icon: Icons.shopping_cart),
    NavigatorTab(title: 'Orders', icon: Icons.list_alt),
    NavigatorTab(title: 'Profile', icon: Icons.person),
  ];

  final List<Widget> pages = [
    ProductListingScreen(),
    CartScreen(),
    OrdersScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    currentIndexNotifier.addListener(() {
      pageController.jumpToPage(currentIndexNotifier.value);
    });
  }

  @override
  void dispose() {
    currentIndexNotifier.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: currentIndexNotifier,
        builder: (context, currentIndex, _) {
          return Container(
            height: 80.h,
            color: Theme.of(context).colorScheme.tertiary,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:
                  tabs.map((tab) {
                    return TabItemWidget(
                      tab: tab,
                      isActive: tab == tabs[currentIndex],
                      onTap: () {
                        currentIndexNotifier.value = tabs.indexOf(tab);
                      },
                    );
                  }).toList(),
            ),
          );
        },
      ),
      body: PageView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: tabs.length,
        controller: pageController,
        itemBuilder: (context, index) => pages[index],
      ),
    );
  }
}

class NavigatorTab {
  final String title;
  final IconData icon;

  NavigatorTab({required this.title, required this.icon});
}
