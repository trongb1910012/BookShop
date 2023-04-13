import 'package:flutter/material.dart';
import 'package:myapp/ui/screens/detail_product_screen.dart';
import '../../screens.dart';
import '../../models/product.dart';
import 'package:provider/provider.dart';
import '../manager/cart__manager.dart';

class CardProduct extends StatelessWidget {
  const CardProduct(
    this.product, {
    super.key,
  });
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(20.0),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              DetailProduct.routeName,
              arguments: product.id,
            );
          },
          child: SizedBox(
              width: 400,
              height: 160,
              child: Card(
                color: Color.fromARGB(255, 207, 193, 225),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(
                    color: Color.fromARGB(255, 243, 241, 241),
                    width: 2.0,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          height: 130,
                          width: 100,
                          image: NetworkImage(product.imageUrl),
                          fit: BoxFit.cover,
                        )
                      ],
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              product.name,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                          ),
                          Text(
                            product.description,
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Gia: ${product.price}',
                              // ignore: prefer_const_constructors
                              style: TextStyle(
                                  color: Color.fromARGB(255, 172, 32, 32),
                                  fontSize: 14),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.shopping_cart),
                            onPressed: () {
                              final cart = context.read<CarttManager>();
                              cart.addItem(product);
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                      'Item added to cart',
                                    ),
                                    duration: const Duration(seconds: 2),
                                    action: SnackBarAction(
                                      label: 'UNDO',
                                      onPressed: () {
                                        cart.removeSingleItem(product.id!);
                                      },
                                    ),
                                  ),
                                );
                            },
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ])
                  ],
                ),
              )),
        ));
  }
}
