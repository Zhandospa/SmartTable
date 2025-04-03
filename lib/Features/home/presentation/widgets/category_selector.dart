import 'package:flutter/material.dart';

class CategorySelector extends StatefulWidget {
  final List categories;
  final int selectedIndex;
  final ValueChanged<int> onCategoryTap;

  const CategorySelector({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onCategoryTap,
  });

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _rowKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 3,
                color: Colors.grey[300],
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                key: _rowKey,
                mainAxisSize: MainAxisSize.min,
                children: List.generate(widget.categories.length, (index) {
                  final isSelected = widget.selectedIndex == index;
                  return GestureDetector(
                    onTap: () => widget.onCategoryTap(index),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.categories[index].title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              color: isSelected ? Colors.blue : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            left: _calculateIndicatorPosition(widget.selectedIndex),
            bottom: 0,
            child: Container(
              height: 3,
              width: _getTextWidth(widget.categories[widget.selectedIndex].title),
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  double _calculateIndicatorPosition(int index) {
    final RenderBox? rowBox = _rowKey.currentContext?.findRenderObject() as RenderBox?;
    if (rowBox == null) return 0;

    double leftOffset = 0;
    for (int i = 0; i < index; i++) {
      leftOffset += _getTextWidth(widget.categories[i].title) + 24;
    }

    // Определяем ширину строки и экрана
    double rowWidth = rowBox.size.width;
    double screenWidth = MediaQuery.of(context).size.width;

    // Центрируем строку относительно экрана
    double startOffset = (screenWidth - rowWidth) / 2;
    double currentItemWidth = _getTextWidth(widget.categories[index].title);
    print(index);
    // Вычисляем центр текущего элемента
    return startOffset + leftOffset + (currentItemWidth / 2) - (_getTextWidth(widget.categories[index].title) / 2) + 20 + index + (index - 1) * 6;
  }

  double _getTextWidth(String text) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: const TextStyle(fontSize: 16)),
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.width;
  }
}
