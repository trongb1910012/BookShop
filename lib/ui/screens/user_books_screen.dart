import 'package:flutter/material.dart';
import '../../ui/manager/book_manager.dart';
import '../../ui/screens/edit_book.dart';
import 'package:provider/provider.dart';

import '../shared/drawer.dart';
import '../widgets/user_product_list_tile.dart';

class UserBooksScreen extends StatelessWidget {
  static const routeName = '/user-products';
  const UserBooksScreen({super.key});

  Future<void> _refreshBook(BuildContext context) async {
    await context.read<BookManager>().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final bookManagers = context.read<BookManager>();
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

  Widget buildUserProductListView(BookManager bookManagers) {
    return Consumer<BookManager>(
      builder: (context, bookManager, child) {
        return ListView.builder(
          itemCount: bookManager.books.length,
          itemBuilder: (context, index) => Column(
            children: [
              UserProductListTile(bookManager.books[index]),
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
