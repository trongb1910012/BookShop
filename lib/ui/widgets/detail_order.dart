import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/cart_item.dart';

class DetailOrder extends StatelessWidget {
  // List<CartItem> cart;
  // List<CartItem> cart = [
  //       CartItem(
  //         id: 'c1',
  //         title: 'Red Shirt',
  //         quantity: 2,
  //         imageUrl: 'https://americastarbooks.com/wp-content/uploads/2018/11/noi-dung-sach-dac-nhan-tam-1280x720.jpg',
  //         price: 29.99,
  //       )
  //     ];
  DetailOrder({
    // required this.cart,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, i) {
          return Text('123123');
        },
      ),
    );
  }
}
