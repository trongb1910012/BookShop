import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../manager/order_manager.dart';
import '../shared/drawer.dart';
import '../widgets/order_item_cart.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/order-now';
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('building orders');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đơn hàng của bạn'),
      ),
      drawer: const AppDrawer(),
      body: Consumer<OrdersManager>(
        builder: (ctx, ordersManager, child) {
          return ListView.builder(
            itemCount: ordersManager.orderCount,
            itemBuilder: (ctx, i) => OrderItemCard(ordersManager.orders[i]),
          );
        },
      ),
    );
  }
}
