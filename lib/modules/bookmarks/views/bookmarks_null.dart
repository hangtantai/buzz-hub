import 'package:flutter/material.dart';
import 'package:buzz_hub/modules/post/models/post_model.dart';

class BookMarksNull extends StatefulWidget {
  const BookMarksNull({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CreateBookmarksNull createState() => _CreateBookmarksNull();
}

class _CreateBookmarksNull extends State<BookMarksNull>  {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "name",
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
            Text(
              "status",
              style: TextStyle(color: Colors.white, fontSize: 14.0),
            )
          ],
        ),
      ),

      body: Center(
        // heightFactor: 3,
        // widthFactor: 0.8,
        child: Container(
          color: Colors.green,
          child: const Text(
            'Center Widget',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
