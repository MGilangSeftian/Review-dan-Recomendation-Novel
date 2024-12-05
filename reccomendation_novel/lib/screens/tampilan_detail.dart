import 'package:flutter/material.dart';
import 'package:reccomendation_novel/models_novel/novels_models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class TampilanDetail extends StatefulWidget {
  final Novel novel;
  const TampilanDetail({super.key, required this.novel});

  @override
  State<TampilanDetail> createState() => _TampilanDetailState();
}

class _TampilanDetailState extends State<TampilanDetail> {

  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorite = prefs.getStringList('favorite') ?? [];
    setState(() {
      isFavorite = favorite.contains(widget.novel.title);
    });
  }

  Future<void> _saveFavorite(String title) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorite = prefs.getStringList('favorite') ?? [];

    if (favorite.contains(title)) {
      favorite.remove(title);
    } else {
      favorite.add(title);
    }

    await prefs.setStringList('favorite', favorite);

    setState(() {
      isFavorite = favorite.contains(title);
    });
  }

  void _saveHistory(String title) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList('history') ?? [];
    history.add(title);
    prefs.setStringList('history', history);
  }

  @override
  Widget build(BuildContext context) {
    final novel = widget.novel;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(
          'Detail',
          style:const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding:const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        image: AssetImage(novel.imageUrl),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  Text(
                      novel.rating.toString()
                  ),
                ],
              ),
              SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    novel.title,
                    style:const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Column(
                    children: [
                      IconButton(
                          onPressed: () => _saveFavorite(novel.title),
                          icon: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: isFavorite ? Colors.red : null
                          ),
                      ),
                    ],
                  )
                ],
              ),
              Divider(height: 16,color: Colors.indigo,),
              ListTile(
                title:const Text(
                  'Di Tulis Oleh',
                ),
                subtitle: Text(
                  novel.author,
                ),
              ),
              ListTile(
                title:const Text(
                  'Tahun Terbit',
                ),
                subtitle: Text(
                  novel.tahun_terbit,
                ),
              ),
              ListTile(
                title:const Text(
                  'Penerbit',
                ),
                subtitle: Text(
                  novel.penerbit,
                ),
              ),
              Divider(height: 16,color: Colors.indigo,),
             const Text(
                "Sinopsis Novel",
                style: TextStyle(
                  fontSize:16,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 8,),
              Text(
                novel.synopsis,
              ),
              Divider(height: 16,color: Colors.indigo,),
             const Text(
                'Ulasan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8,),
              Text(
                novel.review,
                style:const TextStyle(
                  fontSize: 16
                ),
              ),
              Divider(height: 16, color: Colors.indigo,),
              SizedBox(height: 8,),
              const Text(
                'Link Novel',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8,),
              InkWell(
                onTap: () async{
                  _saveHistory(novel.title);
                  final Uri url = Uri.parse(novel.linkNovel);
                  if(await canLaunchUrl(url)){
                    await launchUrl(url);
                  }else{
                    throw 'tidak dapat membuka link : $url';
                  }
                },
                child: Text(
                  novel.linkNovel,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 14
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
