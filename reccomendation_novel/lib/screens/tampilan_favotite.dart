import 'package:flutter/material.dart';

class TampilanFavorit extends StatelessWidget {
  // Daftar dummy data untuk novel favorit
  final List<Map<String, String>> favoriteNovels = [
    {
      "title": "Dilan",
      "author": "pidi baiq",
      "image": "Dilan.jpg", // Ganti dengan URL gambar
    },
    {
      "title": "Cinta Dalam Ikhlas",
      "author": "Kang Abay",
      "image": "https://via.placeholder.com/150",
    },
    {
      "title": "Bulan",
      "author": "Tere Liye",
      "image": "https://via.placeholder.com/150",
    },
    {
      "title": "Komet",
      "author": "Tere Liye",
      "image": "https://via.placeholder.com/150",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Novels"),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurpleAccent, Colors.pinkAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: favoriteNovels.length,
          itemBuilder: (context, index) {
            final novel = favoriteNovels[index];
            return Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(12),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    novel["image"]!,
                    width: 50,
                    height: 75,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  novel["title"]!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: Text(
                  "by ${novel["author"]!}",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.pinkAccent,
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${novel["title"]} removed from favorites!'),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
