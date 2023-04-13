import 'package:flutter/material.dart';
import 'package:myapp/ui/widgets/home.dart';
import 'package:myapp/ui/widgets/info_user.dart';
import '../manager/cart__manager.dart';
import '../widgets/product_card.dart';
import '../manager/product_manager.dart';
import '../../screens.dart';
import '../widgets/top_right_badge.dart';
import 'package:provider/provider.dart';

enum FilterOptions { favorites, all }

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({super.key});

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  final _showOnlyFavorites = ValueNotifier<bool>(false);
  late Future<void> _fetchProducts;
  @override
  void initState() {
    super.initState();
    _fetchProducts = context.read<ProductManager>().fetchProducts();
  }

  int _selectedIndex = 0;
  String titlePage = '';
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    Text(''),
    InfoUser(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Image(
            width: 300,
            height: 50,
            color: Colors.blue,
            image: NetworkImage(
                'https://upload.wikimedia.org/wikipedia/en/a/a5/Grand_Theft_Auto_V.png')),
        actions: <Widget>[
          buildShoppingCartIcon(),
        ],
      ),
      drawer: const AppDrawer(),
      body: _selectedIndex == 1
          ? FutureBuilder(
              future: _fetchProducts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                      decoration: BoxDecoration(
                          color:
                              Color.fromARGB(255, 43, 25, 57).withOpacity(0.9)),
                      child: Consumer<ProductManager>(
                        builder: (context, productManager, child) =>
                            ListView.builder(
                          itemCount: productManager.itemCount,
                          itemBuilder: (BuildContext context, int index) {
                            return CardProduct(productManager.products[index]);
                          },
                        ),
                      ));
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            )
          : _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Sách',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle_rounded),
            label: 'Tài Khoản',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget buildShoppingCartIcon() {
    return Consumer<CarttManager>(
      builder: (ctx, CarttManager, child) {
        return TopRightBadge(
          data: CarttManager.productCount,
          child: IconButton(
            icon: const Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(CartScreen.routeName);
            },
          ),
        );
      },
    );
  }
}
