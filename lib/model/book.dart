class Book {
  final String category;
  final String bookName;
  final String author;
  final String year;
  final String description;
  final String reference; // Filename of the PDF in assets
  final String image;
  bool isFavorited;
  bool popular;

  Book({
    required this.category,
    required this.bookName,
    required this.author,
    required this.year,
    required this.description,
    required this.reference,
    required this.image,
    required this.isFavorited,
    required this.popular,
  });
}

List<Book> books = [
  Book(
    category: "All",
    bookName: "The Adventures of Tom Sawyer",
    author: "Mark Twain",
    year: "2021",
    description:
        "The adventures and pranks of a mischievous boy growing up in a nineteenth-century Mississippi River town as he witnesses a crime, hunts for the pirates’ treasure, and becomes lost in a cave.",
    reference: "b1.pdf",
    image: "assets/images/b1.png",
    isFavorited: false,
    popular: true,
  ),
  Book(
    category: "Story",
    bookName: "The Gift of the Magi and Other Stories",
    author: "O. Henry",
    year: "2018",
    description:
        "A husband and wife sell their most prized possessions in order to purchase the perfect gift for each other, along with other stories.",
    reference: "b2.pdf",
    image: "assets/images/b2.png",
    isFavorited: false,
    popular: false,
  ),
  Book(
    category: "Story",
    bookName: "Robinson Crusoe",
    author: "Daniel Defoe",
    year: "2006",
    description:
        "Robinson Crusoe is a classic adventure story that has captivated readers for generations. Now we’re delighted to offer a beginner’s level e-book download of this timeless tale, specially designed for English language learners. If you’re just starting to learn English or want to improve your language skills, this e-book is a fantastic way to embark on a literary journey with the story of Robinson Crusoe.",
    reference: "b3.pdf",
    image: "assets/images/b3.png",
    isFavorited: false,
    popular: true,
  ),
  // Add more books as needed
];
