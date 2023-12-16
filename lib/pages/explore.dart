import 'package:ebook/model/book.dart';
import 'package:ebook/pages/book_info.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  // ignore: unused_field
  String _searchQuery = '';
  String _selectedCategory = 'All';
  List<Book> allBooks = books;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              const Text('Explore Books', style: TextStyle(fontSize: 24)),
              _buildSearchInput(),
              const SizedBox(height: 20),
              _buildCategoryCarousel(),
              const SizedBox(height: 20),
              _buildBookList(), // This will dynamically change based on search and category selection
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchInput() {
    return TextField(
      onChanged: (value) {
        setState(() {
          if (value.isNotEmpty) {
            // Filter books as the user types in the search field
            allBooks = books.where((book) {
              // Check if the search term is contained within book name, author, or year
              return book.bookName
                      .toLowerCase()
                      .contains(value.toLowerCase()) ||
                  book.author.toLowerCase().contains(value.toLowerCase()) ||
                  book.year.contains(value);
            }).toList();
          } else {
            // If the search input is empty, reset to display all books
            allBooks = books;
          }
        });
      },
      decoration: const InputDecoration(
        labelText: 'Search books by name, author or year',
        suffixIcon: Icon(Icons.search),
      ),
    );
  }

  Widget _buildCategoryCarousel() {
    List<String> categories = [
      'All',
      'Story',
      'Film',
      'War',
      'Sports',
      'Politics'
    ];

    return CarouselSlider(
      options: CarouselOptions(
        height: 40.0, // Adjust height as needed
        viewportFraction: 0.3, // Adjust this value to show multiple categories
        enlargeCenterPage: true, // Optionally, highlight the central item
      ),
      items: categories.map((category) {
        bool isActive = _selectedCategory == category;
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategory = category;
                  if (_selectedCategory == 'All') {
                    allBooks = books;
                  } else {
                    allBooks = books.where((book) {
                      return book.category == _selectedCategory;
                    }).toList();
                  }
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: isActive ? Colors.blue : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: isActive ? Colors.white : Colors.black,
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildBookList() {
    return Expanded(
      child: ListView.builder(
        itemCount: allBooks.length,
        itemBuilder: (context, index) {
          Book book = allBooks[index];
          return Column(
            children: [
              _buildBookRow(book),
              SizedBox(height: 10),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBookRow(Book book) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                BookInfoPage(book: book), // Pass the book object
          ),
        );
      },
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              width: 90,
              height: 90,
              child: Image.asset(
                book.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(book.bookName,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(book.author),
                Text(book.year),
              ],
            ),
          ),
          IconButton(
            icon:
                Icon(book.isFavorited ? Icons.favorite : Icons.favorite_border),
            color: Colors.red, // Optional: change color if favorited
            onPressed: () {
              setState(() {
                // Find the book in the list and toggle its isFavorited status
                int index = books.indexOf(book);
                if (index != -1) {
                  // Toggle favorite status
                  books[index] = Book(
                    category: book.category,
                    bookName: book.bookName,
                    author: book.author,
                    year: book.year,
                    description: book.description,
                    reference: book.reference,
                    image: book.image,
                    isFavorited: !book.isFavorited,
                    popular: book.popular,
                  );
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
