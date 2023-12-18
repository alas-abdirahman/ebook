import 'package:ebook/model/book.dart';
import 'package:ebook/pages/pdf_viewer.dart';
import 'package:flutter/material.dart';

class BookInfoPage extends StatelessWidget {
  final Book book;

  BookInfoPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.bookName), // Use book's name
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildImageBackgroundTitle(context),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Description',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(book.description), // Use book's description
          ),
          const Spacer(), // Pushes the button to the bottom of the screen
          _buildReadButton(context),
        ],
      ),
    );
  }

  Widget _buildImageBackgroundTitle(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(book.image), // Use book's image URL
          fit: BoxFit.contain,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        book.bookName,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildReadButton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 60.0),
    child: Align(
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PdfViewerPage(
                filePath: book.reference,
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue, // Background color
          foregroundColor: Colors.white, // Foreground color
        ),
        child: const Text('Read'),
      ),
    ),
  );
}

}
