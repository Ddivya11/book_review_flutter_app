import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Royal Library',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6B0F1A)),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

// ─── DATA MODEL ───────────────────────────────────────────
class Book {
  final String title;
  final String author;
  final double rating;
  final String review;
  final String genre;
  final String quote;
  final String coverId;

  Book({
    required this.title,
    required this.author,
    required this.rating,
    required this.review,
    required this.genre,
    required this.quote,
    required this.coverId,
  });
}

// ─── BOOK DATA ─────────────────────────────────────────────
final List<Book> defaultBooks = [
  Book(
    title: 'A Court of Thorns and Roses',
    author: 'Sarah J. Maas',
    rating: 4.8,
    review:
        'A breathtaking fantasy romance that pulls you into a world of fae, magic, and forbidden love. Sarah J. Maas crafts an irresistible story full of danger, beauty, and heart.',
    genre: 'Fantasy Romance',
    quote: '"I was not a pet, not a doll, not an animal. I was a girl."',
    coverId: 'OL26331974M',
  ),
  Book(
    title: 'Throne of Glass',
    author: 'Sarah J. Maas',
    rating: 4.7,
    review:
        'An assassin, a prince, and a kingdom on the edge of darkness. Throne of Glass is a masterclass in world-building and fierce, unforgettable characters.',
    genre: 'Fantasy',
    quote: '"She was a thing of shadow and starlight."',
    coverId: 'OL25390563M',
  ),
  Book(
    title: 'Pride and Prejudice',
    author: 'Jane Austen',
    rating: 4.9,
    review:
        'A timeless classic of wit, romance, and social commentary. Elizabeth Bennet and Mr. Darcy remain one of literature\'s greatest love stories, sharp and achingly beautiful.',
    genre: 'Classic Romance',
    quote: '"I declare after all there is no enjoyment like reading!"',
    coverId: 'OL7353617M',
  ),
  Book(
    title: 'Verity',
    author: 'Colleen Hoover',
    rating: 4.6,
    review:
        'A dark, twisting thriller that will keep you awake at night. Verity is deeply unsettling, brilliantly plotted, and impossible to put down once you start.',
    genre: 'Dark Thriller',
    quote: '"Every person is a mystery. And I\'m not sure we should spend our lives trying to figure them out."',
    coverId: 'OL32880152M',
  ),
];

// ─── PAGE 1: HOME ─────────────────────────────────────────
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Book> books = List.from(defaultBooks);
  List<Book> filteredBooks = List.from(defaultBooks);
  final searchController = TextEditingController();

  void filterBooks(String query) {
    setState(() {
      filteredBooks = books
          .where((b) =>
              b.title.toLowerCase().contains(query.toLowerCase()) ||
              b.author.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5ECD7),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6B0F1A),
        title: Row(
          children: const [
            Text('🕯️', style: TextStyle(fontSize: 20)),
            SizedBox(width: 8),
            Text(
              'Royal Library',
              style: TextStyle(
                color: Color(0xFFD4AF37),
                fontWeight: FontWeight.bold,
                fontSize: 22,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            color: const Color(0xFF3B1A0F),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: TextField(
              controller: searchController,
              onChanged: filterBooks,
              style: const TextStyle(color: Color(0xFFF5ECD7)),
              decoration: InputDecoration(
                hintText: 'Search by title or author...',
                hintStyle: const TextStyle(color: Color(0xFFB8977E)),
                prefixIcon: const Icon(Icons.search, color: Color(0xFFD4AF37)),
                filled: true,
                fillColor: const Color(0xFF5C2A1A),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
          // Book List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: filteredBooks.length,
              itemBuilder: (context, index) {
                final book = filteredBooks[index];
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailPage(book: book),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFDF3E3),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: const Color(0xFF8B4513), width: 1.5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.brown.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Book Cover
                              ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.network(
                                  'https://covers.openlibrary.org/b/olid/${book.coverId}-M.jpg',
                                  width: 65,
                                  height: 95,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    width: 65,
                                    height: 95,
                                    color: const Color(0xFF8B4513),
                                    child: const Icon(Icons.menu_book,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      book.title,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF3B1A0F),
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      book.author,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Color(0xFF7A5230),
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    // Wax Seal Genre Badge
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF6B0F1A),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        '🔖 ${book.genre}',
                                        style: const TextStyle(
                                          color: Color(0xFFD4AF37),
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        ...List.generate(5, (i) {
                                          return Icon(
                                            i < book.rating.floor()
                                                ? Icons.star
                                                : (i < book.rating
                                                    ? Icons.star_half
                                                    : Icons.star_border),
                                            color: const Color(0xFFD4AF37),
                                            size: 16,
                                          );
                                        }),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${book.rating}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF7A5230),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(Icons.arrow_forward_ios,
                                  size: 14, color: Color(0xFF8B4513)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Wooden Shelf Divider
                    if (index < filteredBooks.length - 1)
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        height: 10,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF3B1A0F),
                              Color(0xFF6B3A2A),
                              Color(0xFF3B1A0F),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 4,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          // Footer
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            color: const Color(0xFF3B1A0F),
            child: Column(
              children: const [
                Text('🖋️ ─────────────────── 🖋️',
                    style: TextStyle(color: Color(0xFFD4AF37), fontSize: 12)),
                SizedBox(height: 4),
                Text(
                  'Made by Divya',
                  style: TextStyle(
                    color: Color(0xFFD4AF37),
                    fontSize: 13,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF6B0F1A),
        onPressed: () async {
          final newBook = await Navigator.push<Book>(
            context,
            MaterialPageRoute(builder: (_) => const AddReviewPage()),
          );
          if (newBook != null) {
            setState(() {
              books.add(newBook);
              filteredBooks = List.from(books);
            });
          }
        },
        child: const Icon(Icons.add, color: Color(0xFFD4AF37)),
      ),
    );
  }
}

// ─── PAGE 2: DETAIL ───────────────────────────────────────
class DetailPage extends StatelessWidget {
  final Book book;
  const DetailPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5ECD7),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6B0F1A),
        title: Text(
          book.title,
          style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 16),
        ),
        iconTheme: const IconThemeData(color: Color(0xFFD4AF37)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book Cover
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://covers.openlibrary.org/b/olid/${book.coverId}-L.jpg',
                  width: 140,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 140,
                    height: 200,
                    color: const Color(0xFF8B4513),
                    child: const Icon(Icons.menu_book,
                        color: Colors.white, size: 60),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              book.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3B1A0F),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'by ${book.author}',
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF7A5230),
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 10),
            // Genre Badge
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF6B0F1A),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '🔖 ${book.genre}',
                style: const TextStyle(
                  color: Color(0xFFD4AF37),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Stars
            Row(
              children: [
                ...List.generate(5, (i) {
                  return Icon(
                    i < book.rating.floor()
                        ? Icons.star
                        : (i < book.rating
                            ? Icons.star_half
                            : Icons.star_border),
                    color: const Color(0xFFD4AF37),
                    size: 24,
                  );
                }),
                const SizedBox(width: 8),
                Text('${book.rating}/5',
                    style: const TextStyle(
                        fontSize: 15, color: Color(0xFF7A5230))),
              ],
            ),
            const SizedBox(height: 20),
            // Quote Box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF6B0F1A).withOpacity(0.08),
                border: const Border(
                  left: BorderSide(color: Color(0xFF6B0F1A), width: 4),
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                book.quote,
                style: const TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: Color(0xFF3B1A0F),
                  height: 1.6,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Review',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3B1A0F),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFDF3E3),
                borderRadius: BorderRadius.circular(12),
                border:
                    Border.all(color: const Color(0xFF8B4513), width: 1),
              ),
              child: Text(
                book.review,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.7,
                  color: Color(0xFF3B1A0F),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── PAGE 3: ADD REVIEW ───────────────────────────────────
class AddReviewPage extends StatefulWidget {
  const AddReviewPage({super.key});

  @override
  State<AddReviewPage> createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final reviewController = TextEditingController();
  final quoteController = TextEditingController();
  final coverIdController = TextEditingController();
  double rating = 3.0;
  String selectedGenre = 'Fantasy';

  final List<String> genres = [
    'Fantasy',
    'Fantasy Romance',
    'Classic Romance',
    'Dark Thriller',
    'Mystery',
    'Science Fiction',
    'Historical Fiction',
    'Non-Fiction',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5ECD7),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6B0F1A),
        title: const Text('Add a Book',
            style: TextStyle(color: Color(0xFFD4AF37))),
        iconTheme: const IconThemeData(color: Color(0xFFD4AF37)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _label('Book Title'),
            _textField(titleController, 'e.g. The Alchemist'),
            const SizedBox(height: 16),
            _label('Author'),
            _textField(authorController, 'e.g. Paulo Coelho'),
            const SizedBox(height: 16),
            _label('Genre'),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF8B4513)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedGenre,
                  isExpanded: true,
                  items: genres
                      .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                      .toList(),
                  onChanged: (val) =>
                      setState(() => selectedGenre = val ?? selectedGenre),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _label('Your Review'),
            TextField(
              controller: reviewController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Write your thoughts...',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: Color(0xFF8B4513)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _label('Favourite Quote (optional)'),
            _textField(quoteController, '"Your favourite line from the book"'),
            const SizedBox(height: 16),
            _label('Open Library Cover ID (optional)'),
            _textField(coverIdController, 'e.g. OL7353617M'),
            const SizedBox(height: 4),
            const Text(
              'Find it at covers.openlibrary.org',
              style: TextStyle(fontSize: 11, color: Color(0xFF7A5230)),
            ),
            const SizedBox(height: 16),
            Text(
              'Rating: ${rating.toStringAsFixed(1)} ⭐',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xFF5C3317)),
            ),
            Slider(
              value: rating,
              min: 1,
              max: 5,
              divisions: 8,
              activeColor: const Color(0xFF6B0F1A),
              onChanged: (val) => setState(() => rating = val),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6B0F1A),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  if (titleController.text.isNotEmpty &&
                      authorController.text.isNotEmpty) {
                    final newBook = Book(
                      title: titleController.text,
                      author: authorController.text,
                      rating: rating,
                      review: reviewController.text.isEmpty
                          ? 'No review written yet.'
                          : reviewController.text,
                      genre: selectedGenre,
                      quote: quoteController.text.isEmpty
                          ? '"A great book deserves to be read twice."'
                          : quoteController.text,
                      coverId: coverIdController.text.isEmpty
                          ? ''
                          : coverIdController.text,
                    );
                    Navigator.pop(context, newBook);
                  }
                },
                child: const Text('Add to Library',
                    style: TextStyle(
                        color: Color(0xFFD4AF37),
                        fontSize: 16,
                        letterSpacing: 1)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(text,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xFF5C3317))),
      );

  Widget _textField(TextEditingController controller, String hint) =>
      TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF8B4513)),
          ),
        ),
      );
}
