import 'package:flutter/material.dart';
import 'package:reccomendation_novel/screens/tampilan_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TampilanFavorite extends StatefulWidget {
  const TampilanFavorite({super.key});

  @override
  State<TampilanFavorite> createState() => _TampilanFavoriteState();
}

class _TampilanFavoriteState extends State<TampilanFavorite> {

  TextEditingController pencarianController = TextEditingController();
  String pencarian ='';
  List<String> favorite = [];

  List<String> pencarianFavorite = [];


  Future<void> _loadFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      favorite = prefs.getStringList('favorite') ?? [];
      pencarianFavorite = favorite;
    });
  }

  void _pencarianFavorite(String query) {
    setState(() {
      pencarian = query;
      pencarianFavorite = favorite
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Future<void> _hapusFavorite(String title) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      favorite.remove(title);
      pencarianFavorite = favorite;
    });
    await prefs.setStringList('favorite', favorite);
  }

  @override
  void initState() {
    super.initState();
    _loadFavorite();
    pencarianController.addListener((){
      setState(() {
        _pencarianFavorite(pencarianController.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text('Favorite',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: pencarianController,
              decoration: InputDecoration(
                hintText: 'Pencarian',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(),
                ),
              ),
            ),
            const SizedBox(height: 20),

            Expanded(
                child: ListView.builder(
                    itemCount: pencarianFavorite.length,
                    itemBuilder: (context, index){
                      final novel = pencarianFavorite[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        color: Colors.indigo[50],
                        elevation: 5,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.indigo[100],
                            child: Text(
                              "${index + 1}",
                              style: const TextStyle(
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          title: Text(
                            novel,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon : const Icon(
                                  Icons.delete,
                                  color: Colors.indigo,
                                ),
                                onPressed: (){
                                  _hapusFavorite(novel);
                                },
                              ),
                            ],
                          )
                        ),
                      );
                    },
                )
            )
          ],
        ),
      ),
    );
  }
}


