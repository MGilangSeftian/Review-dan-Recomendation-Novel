import 'package:flutter/material.dart';
import 'package:reccomendation_novel/data_list_novel/data_novel.dart';
import 'package:reccomendation_novel/models_novel/novels_models.dart';
import 'package:reccomendation_novel/widget/item_card.dart';
import 'package:reccomendation_novel/screens/tampilan_detail.dart';



class TampilanHome extends StatefulWidget {
  const TampilanHome({super.key});

  @override
  State<TampilanHome> createState() => _TampilanHomeState();
}

class _TampilanHomeState extends State<TampilanHome> {
  String pilihanKategori = 'Semua';
  TextEditingController pencarianController = TextEditingController();
  String pencarian ='';
  List<Novel>get filterKategori {
    List<Novel> daftarlist = novels;
    if (pilihanKategori != 'Semua') {
      daftarlist =
          daftarlist.where((novel) => novel.kategori == pilihanKategori).toList();
    }
    if (pencarian.isNotEmpty) {
      daftarlist = daftarlist.where((novel) =>
      novel.title.toLowerCase().startsWith(
          pencarian.toLowerCase()) ||
          novel.author.toLowerCase().startsWith(
              pencarian.toLowerCase())
      ).toList();
    }
    return daftarlist;
  }

  @override
  void initState() {
    super.initState();
    pencarianController.addListener((){
      setState(() {
        pencarian = pencarianController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title:const Text('Home',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.all(8),
            child: TextField(
              controller: pencarianController,
              decoration: InputDecoration(
                hintText: 'Pencarian',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide:const BorderSide(),
                ),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8),
            child: Container(
              height: 170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: const DecorationImage(
                    image: AssetImage('assets/images/TampilanHome.jpg'),
                  fit: BoxFit.cover
                ),
              ),
            ),
          ),
          const Divider(height: 1, color: Colors.blueGrey, ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Rekomendasi Novel',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: (){
                      showModalBottomSheet(
                        backgroundColor: Colors.indigo[100],
                          context: context,
                          builder: (BuildContext contect){
                            return ListView(
                              children: Kategori.map((kategori){
                                return ListTile(
                                  title: Text(kategori,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  onTap: (){
                                    setState(() {
                                      pilihanKategori = kategori;
                                    });
                                    Navigator.pop(context);
                                  },
                                );
                              }).toList(),
                            );
                          });
                      },
                    icon: const Icon(Icons.filter_list),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Colors.blueGrey, ),
          Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    childAspectRatio: 0.60
                  ),
                  itemCount: filterKategori.length,
                  itemBuilder: (context, index){
                  final novel = filterKategori[index];
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TampilanDetail(novel: novels[index]),
                          ),
                      );
                    },
                    child: ItemCard(novel: novel),
                  );
                  },
              ),
          ),
        ],
      ),
    );
  }
}


