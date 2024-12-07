import 'package:flutter/material.dart';
import 'package:reccomendation_novel/screens/tampilan_favorite.dart';
import 'package:reccomendation_novel/screens/tampilan_home.dart';
import 'package:reccomendation_novel/screens/tampilan_login.dart';
import 'package:reccomendation_novel/screens/tampilan_navigasiBar.dart';
import 'package:reccomendation_novel/screens/tampilan_profile.dart';
import 'package:reccomendation_novel/screens/tampilan_register.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Review dan Recommendation Novel',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      // home: TampilanHome(),
      // home: TampilanProfile(),
       home: TampilanLogin(),
       // home: TampilanNavigasibar(),
       // home: TampilanRegister(),
      initialRoute: '/',
      routes: {
        '/Main' : (context) => const TampilanNavigasibar(),
        '/TampilanHome' : (context) => const TampilanHome(),
        '/TampilanLogin' : (context) =>const TampilanLogin(),
        '/TampilanRegister' : (context) => const TampilanRegister(),
      },
    );
  }
}


