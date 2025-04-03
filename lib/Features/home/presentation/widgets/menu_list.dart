// import 'package:flutter/material.dart';
// import 'package:onay/Features/home/presentation/widgets/build_menu_category.dart';

// class MenuList extends StatelessWidget {
//   final List<MenuCategory> categories;

//   const MenuList({super.key, required this.categories});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       padding: const EdgeInsets.all(16.0),
//       itemCount: categories.length,
//       itemBuilder: (context, index) {
//         final category = categories[index];
//         return buildMenuCategory(
//           title: category.title,
//           icon: category.icon,
//           description: category.description,
//           isActive: category.isActive,
//           onTap: category.isActive
//               ? () {
//                   .navigateToFoodCategory(
//                     context,
//                     category.title,
//                     category.id,
//                   );
//                 }
//               : null,
//         );
//       },
//     );
//   }
// }
