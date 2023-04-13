import 'package:flutter/material.dart';
import '../screens/orders_screen.dart';
import '../screens/edit_book.dart';
import '../screens/user_books_screen.dart';
import 'package:provider/provider.dart';
import '../../screens.dart';
import '../auth/auth_manager.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthManager>();
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: const Text('BookShop'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Trang chủ'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Đơn hàng của tôi'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen2.routeName);
            },
          ),
          const Divider(),
          auth.isAdmin
              ? ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text('Quản lý Sản Phẩm'),
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(UserBooksScreen.routeName);
                  },
                )
              : Text(
                  auth.email.toString(),
                  style: TextStyle(fontSize: 16),
                ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Đăng Xuất'),
            onTap: () {
              Navigator.of(context)
                ..pop()
                ..pushReplacementNamed('/');
              context.read<AuthManager>().logout();
            },
          ),
        ],
      ),
    );
  }
}
