import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reccomendation_novel/screens/tampilan_favorite.dart';
import 'package:reccomendation_novel/screens/tampilan_home.dart';
import 'package:reccomendation_novel/screens/tampilan_profile.dart';

class TampilanNavigasibar extends StatefulWidget {
  const TampilanNavigasibar({super.key});

  @override
  State<TampilanNavigasibar> createState() => _TampilanNavigasibarState();
}

class _TampilanNavigasibarState extends State<TampilanNavigasibar> {
  int currentIndex = 0;

  final List<Widget> _TampilanScreens = [
    TampilanHome(),
    TampilanFavorite(),
    TampilanProfile(),
  ];

  final List<IconData> listIcons = [
    FontAwesomeIcons.home,
    FontAwesomeIcons.heart,
    FontAwesomeIcons.user,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _TampilanScreens[
        currentIndex
      ],
      bottomNavigationBar: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(40),
              ),
            ),
          ),
          Positioned(
              child: Container(
                height: 75,
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:
                    List.generate(
                        listIcons.length,
                        (index) =>InkWell(
                          onTap: (){
                            setState(() {
                              currentIndex = index;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: index == currentIndex ? 15 : 30,
                          ),
                            child: Icon(
                              listIcons[index],
                              color: index == currentIndex
                                  ? Colors.deepPurple[100]
                                  : Colors.white,
                              size: index == currentIndex ? 35 : 30,
                            ),
                          ),
                        ),
                    )
                ),
              ),
          ),
        ],
      ),
    );
  }
}
