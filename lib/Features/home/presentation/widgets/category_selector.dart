import 'package:flutter/material.dart';
import 'package:onay/Features/home/data/models/menu_category.dart';

class CategorySelector extends StatefulWidget {
  final List<MenuCategory> categories;
  final int selectedIndex;
  final ValueChanged<int> onCategorySelected;

  const CategorySelector({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onCategorySelected,
  });

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _itemKeys = [];
  double _underlineLeft = 0;
  double _underlineWidth = 0;

  @override
  void initState() {
    super.initState();
    _itemKeys.addAll(widget.categories.map((e) => GlobalKey()).toList());

    WidgetsBinding.instance.addPostFrameCallback((_) => _setUnderline());
  }

  @override
  void didUpdateWidget(covariant CategorySelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _setUnderline());
    }
  }

  void _setUnderline() {
    if (_itemKeys.length <= widget.selectedIndex) return;

    final key = _itemKeys[widget.selectedIndex];
    final context = key.currentContext;
    if (context == null) return;

    final box = context.findRenderObject() as RenderBox;
    final position = box.localToGlobal(Offset.zero, ancestor: context.findAncestorRenderObjectOfType<RenderBox>());

    setState(() {
      _underlineLeft = position.dx;
      _underlineWidth = box.size.width;
    });
  }

  void _onTap(int index) {
    widget.onCategorySelected(index);
    _scrollToIndex(index);
  }

  void _scrollToIndex(int index) {
    if (_itemKeys.length <= index) return;

    final key = _itemKeys[index];
    final context = key.currentContext;
    if (context == null) return;

    final box = context.findRenderObject() as RenderBox;
    final position = box.localToGlobal(Offset.zero, ancestor: context.findAncestorRenderObjectOfType<RenderBox>());
    final offset = _scrollController.offset + position.dx - MediaQuery.of(context).size.width / 2 + box.size.width / 2;

    _scrollController.animateTo(
      offset.clamp(0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: List.generate(widget.categories.length, (index) {
                return Padding(
                  key: _itemKeys[index],
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: GestureDetector(
                    onTap: () => _onTap(index),
                    child: Text(
                      widget.categories[index].title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: widget.selectedIndex == index ? FontWeight.bold : FontWeight.normal,
                        color: widget.selectedIndex == index ? const Color.fromRGBO(0, 122, 255, 1): Colors.grey,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            bottom: 0,
            left: _underlineLeft,
            width: _underlineWidth,
            height: 3,
            child: Container(color:const Color.fromRGBO(0, 122, 255, 1),),
          ),
        ],
      ),
    );
  }
}
