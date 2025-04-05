import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onay/Features/home/presentation/providers/basket_provider.dart';
import 'package:onay/Features/home/presentation/providers/home_provider.dart';
import 'package:onay/Features/home/presentation/screens/food_screen.dart';
import 'package:onay/Features/home/presentation/widgets/category_selector.dart';
import 'package:onay/Features/home/presentation/widgets/home_app_bar.dart';


@RoutePage()
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(menuProvider);
    final totalPrice = ref.watch(totalPriceProvider).toStringAsFixed(0);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HomeAppBar(totalPrice: totalPrice),
      body: categoriesAsync.when(
        data: (categories) {
          return Column(
            children: [
              CategorySelector(
                categories: categories,
                selectedIndex: selectedIndex,
                onCategorySelected: (i) {
                  setState(() {
                    selectedIndex = i;
                  });
                  _pageController.animateToPage(
                    i,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                },
                titleBuilder: (cat) => cat.title,
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return FoodScreen(
                      categoryId: categories[index].id,
                      categoryTitle: categories[index].title,
                    );
                  },
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) =>
            Center(child: Text("Ошибка загрузки: $error")),
      ),
    );
  }
}
