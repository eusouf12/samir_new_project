import 'package:flutter/material.dart';

void showDeleteDialog({
  required BuildContext context,
  required VoidCallback onDelete,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Delete Conversation?"),
        content: const Text("Are you sure you want to delete all messages?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              onDelete();
              Navigator.pop(context);
            },
            child: const Text(
              "Delete",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      );
    },
  );
}
