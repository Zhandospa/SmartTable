

import 'package:flutter/material.dart';

Widget buildMenuCategory({
    required String title,
    required IconData icon,
    required String description,
    required bool isActive,
    VoidCallback? onTap,
  }) {
    return Opacity(
      opacity: isActive ? 1.0 : 0.5, // Если категория отключена, делаем её бледной
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        child: ListTile(
          leading: Icon(icon, color: Colors.brown.shade700, size: 30),
          title: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            description,
            style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
          ),
          trailing: isActive ? const Icon(Icons.arrow_forward_ios, color: Colors.grey) : null,
          onTap: onTap,
        ),
      ),
    );
  }

