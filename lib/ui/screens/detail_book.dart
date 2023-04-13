import 'package:flutter/material.dart';
import '../../models/book.dart';
import '../widgets/card_book.dart';
import '../manager/book_manager.dart';

class DetailBook extends StatelessWidget {
  static const routeName = '/book-detail';
  const DetailBook(
    this.book,{
      super.key,
    }
  );
  final Book book;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(book.name),
        ),
        body: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: Padding( 
            padding: EdgeInsets.fromLTRB(20, 30, 30, 20), 
            child: Container(
                child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 200,
                        width: 300,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: Colors.black.withOpacity(0.7)
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: NetworkImage(
                                book.imageUrl
                              ),
                              fit: BoxFit.cover,
                            )
                          ],
                        ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 10,),
                        Text(
                          book.name,
                          style: const TextStyle(  
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Text(
                          book.description,
                          style: const TextStyle(  
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Text(
                          'Giá: ${book.price}',
                          style: const TextStyle(  
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 170, 15, 54)
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ))),
          )
            
        );
  }
}
