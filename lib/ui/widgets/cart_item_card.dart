import 'package:flutter/material.dart';
import 'package:myapp/models/cart_item.dart';
import 'package:provider/provider.dart';

import '../../models/cart_item.dart';
import '../manager/cart_manager.dart';
import '../shared/dialog_utils.dart';

class CartItemCard extends StatelessWidget {
  final String productId;
  final CartItem cardItem;

  const CartItemCard({
    super.key,
    required this.productId,
    required this.cardItem,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cardItem.id),
      // key: Key(cardItem.id),
      background: Container(
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showConfirmDialog(
            context, 'Bạn muốn xóa sản phẩm khỏi giỏ hàng?');
      },
      onDismissed: (direction) {
        context.read<CartManager>().removeItem(productId);
      },

      child: buildItemCard(),
    );
  }

  Widget buildItemCard() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: Image(
            image: NetworkImage(
              cardItem.imageUrl,
            ),
          ),
          title: Text(cardItem.title),
          subtitle: Text('Giá ${cardItem.price}'),
          trailing: Text('SL: ${cardItem.quantity}'),
        ),
      ),
    );
  }
}
