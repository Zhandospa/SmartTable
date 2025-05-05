import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onay/Features/basket/presentation/screen/basket_screen.dart';
import 'package:onay/Features/basket/presentation/screen/ordered_screen.dart';
import 'package:onay/Features/home/presentation/widgets/category_selector.dart';

@RoutePage()
class BasketSwitcherScreen extends StatefulWidget {
  const BasketSwitcherScreen({super.key});

  @override
  State<BasketSwitcherScreen> createState() => _BasketSwitcherScreenState();
}

class _BasketSwitcherScreenState extends State<BasketSwitcherScreen> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  final List<String> _tabs = ['Корзина', 'Уже заказано'];

  void _onTabSelected(int index) {
    setState(() => _selectedIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void _onPageChanged(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Заказ'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          CategorySelector<String>(
            categories: _tabs,
            selectedIndex: _selectedIndex,
            onCategorySelected: _onTabSelected,
            titleBuilder: (title) => title,
          ),
          const SizedBox(height: 8),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              children: const [
                BasketScreen(),
                ConfirmedOrdersScreen(), // ✅ вот это главное
              ],
            ),
          ),
        ],
      ),
    );
  }
}
