import 'package:flutter/material.dart';
import 'package:reccomendation_novel/screens/tampilan_favotite.dart';
import 'package:reccomendation_novel/screens/tampilan_home.dart';
import 'package:reccomendation_novel/screens/tampilan_login.dart';
import 'package:reccomendation_novel/screens/tampilan_navigasiBar.dart';
import 'package:reccomendation_novel/screens/tampilan_profile.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      // home: TampilanHome(),
      home: TampilanProfile(),
      // home: TampilanLogin(),
       // home: TampilanNavigasibar(),
    );
  }
}


