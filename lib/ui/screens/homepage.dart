import 'package:flutter/material.dart';
import 'package:myapp/ui/widgets/home.dart';
import 'package:myapp/ui/widgets/info_user.dart';
import '../manager/cart_manager.dart';
import '../widgets/card_book.dart';
import '../manager/book_manager.dart';
import '../../screens.dart';
import '../widgets/top_right_badge.dart';
import 'package:provider/provider.dart';

enum FilterOptions { favorites, all }

class BookOverviewScreen extends StatefulWidget {
  const BookOverviewScreen({super.key});

  @override
  State<BookOverviewScreen> createState() => _BookOverviewScreenState();
}

class _BookOverviewScreenState extends State<BookOverviewScreen> {
  final _showOnlyFavorites = ValueNotifier<bool>(false);
  late Future<void> _fetchBooks;
  @override
  void initState() {
    super.initState();
    _fetchBooks = context.read<BookManager>().fetchProducts();
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
            width: 150,
            height: 50,
            color: Colors.white,
            image: NetworkImage(
                'https://www.fiction-addiction.com/media/home/pictures/Bookshop_Logo_Dark.png')),
        actions: <Widget>[
          buildShoppingCartIcon(),
        ],
      ),
      drawer: const AppDrawer(),
      body: _selectedIndex == 1
          ? FutureBuilder(
              future: _fetchBooks,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                      decoration: BoxDecoration(
                          color:
                              Color.fromARGB(255, 43, 25, 57).withOpacity(0.9)),
                      child: Consumer<BookManager>(
                        builder: (context, bookManager, child) =>
                            ListView.builder(
                          itemCount: bookManager.itemCount,
                          itemBuilder: (BuildContext context, int index) {
                            return CardBook(bookManager.books[index]);
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
        selectedItemColor: Color.fromARGB(255, 24, 172, 43),
        onTap: _onItemTapped,
      ),
    );
  }

  Widget buildShoppingCartIcon() {
    return Consumer<CartManager>(
      builder: (ctx, CartManager, child) {
        return TopRightBadge(
          data: CartManager.productCount,
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
