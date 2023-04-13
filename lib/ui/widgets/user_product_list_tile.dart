import 'package:flutter/material.dart';
import 'package:myapp/ui/manager/book_manager.dart';
import 'package:provider/provider.dart';
import '../../models/book.dart';
import '../../ui/screens/edit_book.dart';

class UserProductListTile extends StatelessWidget {
  final Book book;

  const UserProductListTile(
    this.book, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(book.name),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(book.imageUrl),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: <Widget>[
            buildEditButton(context),
            buildDeleteButton(context)
          ],
        ),
      ),
    );
  }

  Widget buildEditButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () {
        Navigator.of(context).pushNamed(EditBook.routeName, arguments: book.id);
      },
      color: Theme.of(context).primaryColor,
    );
  }

  Widget buildDeleteButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () async {
        context.read<BookManager>().deleteProduct(book.id!);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(const SnackBar(
            content: Text(
              'Xóa sản phẩm',
              textAlign: TextAlign.center,
            ),
          ));
      },
      color: Theme.of(context).errorColor,
    );
  }
}
