import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:wa_inventory/core/constants/app_constants.dart';
import 'package:wa_inventory/core/utils/app_utils.dart';
import 'package:wa_inventory/features/inventory/items_card.dart';

class ItemsList extends StatelessWidget {
  final List<QueryDocumentSnapshot> items;

  const ItemsList({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index].data() as Map<String, dynamic>;
        return ItemsCard(
          item: item,
          onTap: () => context.go('/item-detail/${items[index].id}'),
          onEdit: () => context.go('/edit-item/${items[index].id}'),
          onDelete: () => _deleteItem(context, items[index].id),
        );
      },
    );
  }

  Future<void> _deleteItem(BuildContext context, String itemId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Item'),
        content: const Text('Are you sure you want to delete this item?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await FirebaseFirestore.instance
            .collection(AppConstants.inventoryCollection)
            .doc(itemId)
            .delete();
        if (context.mounted) {
          AppUtils.showSuccessSnackBar(context, 'Item deleted successfully');
        }
      } catch (e) {
        if (context.mounted) {
          AppUtils.showErrorSnackBar(context, AppConstants.deleteFailed);
        }
      }
    }
  }
}
