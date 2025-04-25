import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:wa_inventory/core/constants/app_constants.dart';
import 'package:wa_inventory/core/utils/app_utils.dart';

class ItemDetailScreen extends StatefulWidget {
  final String itemId;

  const ItemDetailScreen({
    super.key,
    required this.itemId,
  });

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  bool _isLoading = true;
  Map<String, dynamic>? _item;

  @override
  void initState() {
    super.initState();
    _loadItem();
  }

  Future<void> _loadItem() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection(AppConstants.inventoryCollection)
          .doc(widget.itemId)
          .get();

      if (doc.exists) {
        setState(() {
          _item = doc.data()!;
          _isLoading = false;
        });
      } else {
        if (mounted) {
          AppUtils.showErrorSnackBar(context, 'Item not found');
          context.go('/home');
        }
      }
    } catch (e) {
      if (mounted) {
        AppUtils.showErrorSnackBar(context, AppConstants.somethingWentWrong);
        context.go('/home');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_item == null) {
      return const Scaffold(
        body: Center(
          child: Text('Item not found'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_item!['name']),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.go('/edit-item/${widget.itemId}'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name: ${_item!['name']}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Quantity: ${_item!['quantity']}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Price: ${AppUtils.formatCurrency(_item!['price'])}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    if (_item!['description'] != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        'Description: ${_item!['description']}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                    const SizedBox(height: 8),
                    Text(
                      'Created: ${AppUtils.formatDateTime((_item!['createdAt'] as Timestamp).toDate())}',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    if (_item!['updatedAt'] != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        'Updated: ${AppUtils.formatDateTime((_item!['updatedAt'] as Timestamp).toDate())}',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
