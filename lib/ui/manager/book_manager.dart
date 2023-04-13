import 'package:flutter/foundation.dart';

import '../../models/auth_token.dart';
import '../../models/book.dart';
import '../../services/books_service.dart';

class BookManager with ChangeNotifier {
  List<Book> _items = [];

  final ProductsService _productsService;

  BookManager([AuthToken? authToken])
      : _productsService = ProductsService(authToken);

  set authToken(AuthToken? authToken) {
    _productsService.authToken = authToken;
  }

  Future<void> fetchProducts([bool filterByUser = false]) async {
    _items = await _productsService.fetchProducts(filterByUser);
    notifyListeners();
  }

  int get itemCount {
    return _items.length;
  }

  // List<Book> get books {
  //   return _items;
  // }

  List<Book> get books {
    return [..._items];
  }

  List<Book> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Book findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> addProduct(Book product) async {
    final newProduct = await _productsService.addProduct(product);
    if (newProduct != null) {
      _items.add(newProduct);
      notifyListeners();
    }
  }

  Future<void> updateProduct(Book product) async {
    final index = _items.indexWhere((item) => item.id == product.id);
    if (index >= 0) {
      if (await _productsService.updateBook(product)) {
        _items[index] = product;
        notifyListeners();
      }
    }
  }

  Future<void> toggleFavoriteStatus(Book product) async {
    final savedStatus = product.isFavorite;
    product.isFavorite = !savedStatus;
    if (!await _productsService.saveFavoriteStatus(product)) {
      product.isFavorite = savedStatus;
    }
  }

  Future<void> deleteProduct(String id) async {
    final index = _items.indexWhere((item) => item.id == id);
    Book? existingProducct = _items[index];
    _items.removeAt(index);
    notifyListeners();
    if (!await _productsService.deleteProduct(id)) {
      _items.insert(index, existingProducct);
      notifyListeners();
    }
  }
}
