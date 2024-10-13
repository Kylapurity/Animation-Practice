import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'theme.dart';
import 'product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
      home: CatalogPage(toggleTheme: toggleTheme),
    );
  }
}

class CatalogPage extends StatelessWidget {
  final Function toggleTheme;

  CatalogPage({super.key, required this.toggleTheme});

  final List<Product> products = [
    Product(name: "Product 1", imageUrl: "https://via.placeholder.com/150", price: 29.99),
    Product(name: "Product 2", imageUrl: "https://via.placeholder.com/150", price: 19.99),
    Product(name: "Product 3", imageUrl: "https://via.placeholder.com/150", price: 39.99),
    Product(name: "Product 4", imageUrl: "https://via.placeholder.com/150", price: 49.99),
    // Add more products as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Store"),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () => toggleTheme(),
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return FadeInProductCard(product: products[index]);
        },
      ),
    );
  }
}

class FadeInProductCard extends StatefulWidget {
  final Product product;

  const FadeInProductCard({super.key, required this.product});

  @override
  FadeInProductCardState createState() => FadeInProductCardState(); // Made public

}

class FadeInProductCardState extends State<FadeInProductCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..forward();

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Text(widget.product.name),
            ),
          );
        },
        child: Card(
          elevation: 4.0,
          margin: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(widget.product.imageUrl, height: 100, width: 100, fit: BoxFit.cover),
              const SizedBox(height: 8.0),
              Text(widget.product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text("\$${widget.product.price.toStringAsFixed(2)}"),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}