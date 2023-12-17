import 'package:carousel_slider/carousel_slider.dart';
import 'package:ebook/model/book.dart';
import 'package:ebook/pages/book_info.dart';
import 'package:ebook/pages/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _username = "Guest"; // Default to "Guest"

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');

    setState(() {
      _username = username ?? "Guest";
    });
  }

  List<List<Book>> _groupBooks(List<Book> books, int groupSize) {
    List<List<Book>> groupedBooks = [];
    for (int i = 0; i < books.length; i += groupSize) {
      int end = (i + groupSize < books.length) ? i + groupSize : books.length;
      groupedBooks.add(books.sublist(i, end));
    }
    return groupedBooks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Home'), // Optional: Can be removed or customized
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 20),
              Text('Hi, Welcome $_username',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Text('Checkout new books groups events places and more!'),
              const SizedBox(height: 20),

              Align(
                alignment: Alignment.center,
                child: Image.asset('assets/images/b.png'),
              ), // Replace with your image path
              const SizedBox(height: 20),

              _buildCategoryRow('Most Popular', () {
                BaseWidget.changePageKey.currentState?.changePage(1);
              }),
              _buildCarousel(),

              _buildCategoryRow('Latest', () {
                BaseWidget.changePageKey.currentState?.changePage(1);
              }),
              _buildLatestBooks(), // Display the latest books
              // Implement your latest books section
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryRow(String title, VoidCallback seeAllCallback) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(title, style: const TextStyle(fontSize: 20)),
        TextButton(
          onPressed: seeAllCallback,
          child: const Text('See All'),
        ),
      ],
    );
  }

  Widget _buildCarousel() {
    List<Book> popularBooks = books.where((book) => book.popular).toList();
    List<List<Book>> groupedBooks =
        _groupBooks(popularBooks, 3); // Group books by 3s

    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0, // Adjust as needed
        viewportFraction: 1.0, // Use full viewport width
        enlargeCenterPage:
            false, // Set to false for better layout with multiple items
        autoPlay: true,
      ),
      items: groupedBooks.map((group) {
        return Builder(
          builder: (BuildContext context) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: group.map((book) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BookInfoPage(book: book)),
                    );
                  },
                  child: Image.asset(
                    book.image,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width / 3 -
                        30, // Adjust width based on screen size
                  ),
                );
              }).toList(),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildLatestBooks() {
    // Assuming 'books' is sorted by date or just take the last 3 books for simplicity
    List<Book> latestBooks = books.reversed.take(3).toList();

    return Container(
      height: 200, // Adjust as needed
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: latestBooks.length,
        itemBuilder: (context, index) {
          Book book = latestBooks[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BookInfoPage(book: book)),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                book.image,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
