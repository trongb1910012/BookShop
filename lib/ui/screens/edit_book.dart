import 'package:flutter/material.dart';
import '../../models/book.dart';
import '../../ui/manager/book_manager.dart';
import '../shared/dialog_utils.dart';
import 'package:provider/provider.dart';

class EditBook extends StatefulWidget {
  static const routeName = '/edit-book';

  EditBook(
    Book? product, {
    super.key,
  }) {
    if (product == null) {
      this.book = Book(
        id: null,
        name: '',
        price: 0,
        description: '',
        imageUrl: '',
      );
    } else {
      this.book = product;
    }
  }

  late final Book book;

  @override
  State<EditBook> createState() => _EditBookState();
}

class _EditBookState extends State<EditBook> {
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _editForm = GlobalKey<FormState>();
  late Book _editedProduct;
  var _isLoading = false;

  bool _isValidImageUrl(String value) {
    return (value.startsWith('http') ||
        value.startsWith('https') && (value.endsWith('.png')) ||
        value.endsWith('.jpg') ||
        value.endsWith('.jpeg'));
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(() {
      if (!_imageUrlFocusNode.hasFocus) {
        if (!_isValidImageUrl(_imageUrlController.text)) {
          return;
        }

        setState(() {});
      }
    });
    _editedProduct = widget.book;
    _imageUrlController.text = _editedProduct.imageUrl;
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chỉnh sửa sản phẩm'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _saveForm,
            ),
          ],
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _editForm,
                  child: ListView(
                    children: <Widget>[
                      buildTitleField(),
                      buildPriceField(),
                      buildDescriptionField(),
                      buildProductPreview(),
                    ],
                  ),
                ),
              ));
  }

  Future<void> _saveForm() async {
    final isValid = _editForm.currentState!.validate();
    if (!isValid) {
      return;
    }
    _editForm.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      final bookManager = context.read<BookManager>();
      if (_editedProduct.id != null) {
        await bookManager.updateProduct(_editedProduct);
      } else {
        await bookManager.addProduct(_editedProduct);
      }
    } catch (error) {
      await showErrorDialog(context, 'Đã có sự cố.');
    }
    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  TextFormField buildTitleField() {
    return TextFormField(
      initialValue: _editedProduct.name,
      decoration: const InputDecoration(labelText: 'Tên sản phẩm'),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return "Vui lòng cung cấp một giá trị.";
        }
        return null;
      },
      onSaved: (value) {
        _editedProduct = _editedProduct.copyWith(name: value);
      },
    );
  }

  TextFormField buildPriceField() {
    return TextFormField(
      initialValue: _editedProduct.price.toString(),
      decoration: const InputDecoration(labelText: 'Price'),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Vui lòng nhập giá.';
        }
        if (double.tryParse(value) == null) {
          return 'Vui lòng nhập một số hợp lệ.';
        }
        if (double.parse(value) <= 0) {
          return 'Vui lòng nhập một số lớn hơn 0.';
        }
        return null;
      },
      onSaved: (value) {
        _editedProduct = _editedProduct.copyWith(price: double.parse(value!));
      },
    );
  }

  TextFormField buildDescriptionField() {
    return TextFormField(
      initialValue: _editedProduct.description,
      decoration: const InputDecoration(labelText: 'Mô tả'),
      maxLines: 3,
      keyboardType: TextInputType.multiline,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Vui lòng nhập mô tả.';
        }
        if (value.length < 10) {
          return 'Phải dài ít nhất 10 ký tự.';
        }
        return null;
      },
      onSaved: (value) {
        _editedProduct = _editedProduct.copyWith(description: value);
      },
    );
  }

  Widget buildProductPreview() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          width: 100,
          height: 100,
          margin: const EdgeInsets.only(
            top: 8,
            right: 10,
          ),
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _imageUrlController.text.isEmpty
              ? const Text('Nhập một URL')
              : FittedBox(
                  child: Image.network(
                    _imageUrlController.text,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
        Expanded(
          child: buildImageURLField(),
        )
      ],
    );
  }

  TextFormField buildImageURLField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Image URL'),
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.done,
      controller: _imageUrlController,
      focusNode: _imageUrlFocusNode,
      onFieldSubmitted: (value) => _saveForm(),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Vui lòng nhập URL hình ảnh.';
        }
        if (!_isValidImageUrl(value)) {
          return 'Vui lòng nhập URL hình ảnh hợp lệ.';
        }
        return null;
      },
      onSaved: (value) {
        _editedProduct = _editedProduct.copyWith(imageUrl: value);
      },
    );
  }
}
