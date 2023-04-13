import 'package:flutter/foundation.dart';
import '../../models/cart_item.dart';
import '../../models/book.dart';

class CartManager with ChangeNotifier {
  Map<String, CartItem> _items = {};

  void clear() {
    _items = {};
    notifyListeners();
  }

  int get productCount {
    return _items.length;
  }

  List<CartItem> get products {
    return _items.values.toList();
  }

  Iterable<MapEntry<String, CartItem>> get productEntries {
    return {..._items}.entries;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });

    return total;
  }

  void addItem(Book book) {
    if (_items.containsKey(book.id)) {
      _items.update(
        book.id!,
        (existingCartItem) => existingCartItem.copyWith(
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        book.id!,
        () => CartItem(
          id: 'c${DateTime.now().toIso8601String()}',
          title: book.name,
          price: book.price,
          quantity: 1,
          imageUrl: book.imageUrl,
        ),
      );
    }
    // print(_items.length);
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]?.quantity as num > 1) {
      _items.update(
        productId,
        (existingCartItem) => existingCartItem.copyWith(
          quantity: existingCartItem.quantity - 1,
        ),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }
}
