import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../models/order.dart';
import '../../ui/manager/order_manager.dart';
import 'dart:math';
import '../shared/drawer.dart';
class OrdersScreen2 extends StatelessWidget {
  static const routeName = '/order-screen2';

  const OrdersScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đơn Hàng Của Bạn'),
        
      ),
      drawer: const AppDrawer(),
      body: Consumer<OrdersManager>(  
        builder: (ctx, ordersManager, child) {
          return ListView.builder(
            itemCount: ordersManager.orderCount,
            itemBuilder: (ctx, i) => BuilCardDetail(ordersManager.orders[i]),
          );
        },
      ),
    );
  }

  Widget BuilCardDetail(OrderItem orderItem){
    final f = NumberFormat("0.0#", "en_US");
    return SizedBox(
      height: max(200, (orderItem.products.length * 50) + 110),
      child: Card(
        margin: EdgeInsets.all(16.0),
        child: Padding( 
          padding: EdgeInsets.all(8.0),
          child: Column(  
            children: [
              const SizedBox(
                height: 6, // <-- SEE HERE
              ),
              Text('Ngày đặt:  ${orderItem.dateTime}'),
              Divider(
                color: Colors.black
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Ảnh'),
                  Text('Tên Sản Phẩm'),
                  Text('SL'),
                  Text('Giá'),
                  Text('Tổng'),
                ],
              ),
              Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: orderItem.products.length,
                  itemBuilder: (ctx, index) => Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image(
                          width: 30,
                          height: 30,
                          image: NetworkImage(orderItem.products[index].imageUrl)
                        ),
                        const SizedBox(width: 4),
                        SizedBox(
                          width: 100.0,
                          child: Text(
                            orderItem.products[index].title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text('${orderItem.products[index].quantity}'),
                        const SizedBox(width: 4),
                        Text('${f.format(orderItem.products[index].price)}'),
                        const SizedBox(width: 4),
                        Text('${ f.format(orderItem.products[index].price * orderItem.products[index].quantity)}'),
                      ],
                    ),
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
