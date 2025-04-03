// import 'package:flutter/material.dart';

// Widget _buildAnimatedPanel() {
//     return AnimatedPositioned(
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//       bottom: _isPanelVisible ? 0 : -80,
//       child: Container(
//         width: 200,
//         height: 60,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.2),
//               blurRadius: 10,
//               spreadRadius: 2,
//             ),
//           ],
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             IconButton(
//               onPressed: _decrementCounter,
//               icon: const Icon(Icons.remove, color: Colors.red),
//             ),
//             Text(
//               '$_count',
//               style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             IconButton(
//               onPressed: _incrementCounter,
//               icon: const Icon(Icons.add, color: Colors.green),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text("Подтверждено: $_count")),
//                 );
//               },
//               style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
//               child: const Text("✓", style: TextStyle(fontSize: 20, color: Colors.white)),
//             ),
//           ],
//         ),
//       ),
//     );