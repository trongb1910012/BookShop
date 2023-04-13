import 'package:flutter/material.dart';
import '../../ui/manager/product_manager.dart';
import '../../ui/screens/edit_book.dart';
import 'package:provider/provider.dart';

import '../shared/drawer.dart';
import '../widgets/user_product_tile.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';
  const UserProductsScreen({super.key});

  Future<void> _refreshBook(BuildContext context) async {
    await context.read<ProductManager>().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final bookManagers = context.read<ProductManager>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý sản phẩm'),
        actions: <Widget>[
          buildAddButton(context),
        ],
      ),
      drawer: const AppDrawer(),
      // body: buildUserProductListView(bookManagers)
      body: FutureBuilder(
        future: _refreshBook(context),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return RefreshIndicator(
            onRefresh: () => _refreshBook(context),
            child: buildUserProductListView(bookManagers),
          );
        },
      ),
    );
  }

  Widget buildUserProductListView(ProductManager productsManagers) {
    return Consumer<ProductManager>(
      builder: (context, productsManagers, child) {
        return ListView.builder(
          itemCount: productsManagers.products.length,
          itemBuilder: (context, index) => Column(
            children: [
              UserProductListTile(productsManagers.products[index]),
              const Divider(),
            ],
          ),
        );
      },
    );
  }

  Widget buildAddButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.add),
      onPressed: () {
        Navigator.of(context).pushNamed(
          EditBook.routeName,
        );
      },
    );
  }
}
