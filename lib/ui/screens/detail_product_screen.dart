import 'package:flutter/material.dart';
import '../../models/product.dart';

class DetailProduct extends StatelessWidget {
  static const routeName = '/product-detail';
  const DetailProduct(
    this.product, {
    super.key,
  });
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(product.name),
        ),
        body: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: Padding(
              padding: EdgeInsets.fromLTRB(20, 30, 30, 20),
              child: Container(
                  child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 200,
                          width: 300,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 2, color: Colors.black.withOpacity(0.7)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                image: NetworkImage(product.imageUrl),
                                fit: BoxFit.cover,
                              )
                            ],
                          ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            product.name,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            product.description,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Giá: ${product.price}',
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 170, 15, 54)),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ))),
        ));
  }
}
