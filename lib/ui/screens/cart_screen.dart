import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../manager/cart__manager.dart';
import '../manager/order_manager.dart';
import '../widgets/cart_item_card.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CarttManager>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ Hàng'),
      ),
      body: Column(
        children: <Widget>[
          buildCartSummary(cart, context),
          const SizedBox(height: 10),
          Expanded(
            child: buildCartDetails(cart),
          )
        ],
      ),
    );
  }
}

Widget buildCartDetails(CarttManager cart) {
  return ListView(
    children: cart.productEntries
        .map(
          (e) => CartItemCard(productId: e.key, cardItem: e.value),
        )
        .toList(),
    // itemCount: cart.productCount,
    // itemBuilder: (context, index) {
    //   return CartItemCard(
    //       productId: cart.products[index].id, cardItem: cart.products[index]);
    // },
  );
}

Widget buildCartSummary(CarttManager cart, BuildContext context) {
  return Card(
    margin: const EdgeInsets.all(15),
    child: Padding(
      padding: const EdgeInsets.all((8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text(
            'Tổng',
            style: TextStyle(fontSize: 20),
          ),
          const Spacer(),
          Chip(
            label: Text(
              '\$${cart.totalAmount.toStringAsFixed(2)}',
              style: TextStyle(
                color: Theme.of(context).primaryTextTheme.headline6?.color,
              ),
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          TextButton(
            onPressed: cart.totalAmount <= 0
                ? null
                : () {
                    context.read<OrdersManager>().addOrder(
                          cart.products,
                          cart.totalAmount,
                        );
                    cart.clear();
                  },
            style: TextButton.styleFrom(
              textStyle: TextStyle(color: Theme.of(context).primaryColor),
            ),
            child: const Text('Đặt Hàng'),
          )
        ],
      ),
    ),
  );
}
