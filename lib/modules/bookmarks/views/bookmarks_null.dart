import 'package:flutter/material.dart';

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
      body: Center(
        // heightFactor: 3,
        // widthFactor: 0.8,
        child: Container(
          color: Color.fromARGB(255, 255, 255, 255),
          child: const Text(
            'No bookmark',
            style: TextStyle(
              color: Color.fromARGB(255, 161, 46, 46),
              fontWeight: FontWeight.bold,
              fontSize: 32.0
            ),
          ),
        ),
      ),
    );
  }
}
