import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:projekpab/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
class RegisterScreens extends StatefulWidget {
  const RegissterScreens({super.key});

  @override
  State<RegissterScreens> createState() => _RegissterScreensState();
}
class _RegissterScreensState extends State<RegissterScreens> {
  final emailController = TextEditingController(;
  final passwordController = TextEditingController();
  final namaLengkapController = TextEditingController();
  final userNameController = TextEditingController();
  bool _isSignIn = false;
  bool _obscurePassword = false;

  String? _errorNamaLengkap;
  String? _errorUserName ;
  String? _errorEmail ;
  String? _errorPassword;

  void _signUp() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String NamaLengkap = namaLengkapController.text.trim();
    String UserName = userNameController.text.trim();
    String Email = emailController.text.trim();
    String Password = passwordController.text.trim();

    setState(() {
      _errorNamaLengkap = null;
      _errorUserName = null;
      _errorEmail = null;
      _errorPassword = null;
    });
    bool hasError = false;

      if(NamaLengkap.isEmpty){
        setState(() {
          _errorNamaLengkap = 'Nama lengkap tidak boleh kososng';
        });
      hasError = true;
    }
    if(UserName.isEmpty) {
      setState(() {
        _errorUserName = 'Username Tidak Boleh kosong';
      });
      hasError = true;
    }
    if(Email.isEmpty){
      setState(() {
        _errorEmail = 'Email Tidak Boleh kosong';
      }):
    hasError = true;
    }if
      (!RegExp(r"^[^@]+@[^@]+\.[^@]+$").hasMatch(Email)){
    setState(() {
    _errorEmail = 'Format Email tidak valid';
    });
    hasError = true;
    };

    if (Password.length < 6 ||
    !Password.contains(RegExp(r'[A-Z]')) ||
    !Password.contains(RegExp(r'[a-z]')) ||
    !Password.contains(RegExp(r'[0-9]')) ||
    !Password.contains(RegExp(r'[!@#$%^&*()<>,.?"/:;]'))) {
    setState(() {
    _errorPassword =
    'Minimal 6 karakter, kombinasi [A-Z], [a-z], [0-9], [!@#|||$%^&*(),.?":{}|<>]';
    });
    hasError = true;
    }
    if(hasError){
      return;
    }
    prefs.setString('NamaLengkap', NamaLengkap);
    prefs.setString('UserName', UserName);
    prefs.setString('Email', Email);
    prefs.setString('Password', Password);

    Navigator.pushReplacementNamed(context, '/TampilanSignIn');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Register",
          ), // Text
          centerTitle: true,
          backgroundColor: Colors.blue,
          elevation: 0,
        ), //AppBar
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                Image.asset("assets/images/Mobile_register.png",),
              const SizedBox(height: 16,),
              Text("Register Detail",
                style: TextStyle(fontSize: 20),
              ),
              // Text.
              const SizedBox(height: 24,),
              TextField(
                controller: namaLengkapController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1,
                        color: Colors.blue,
                      ), // BorderSide
                      borderRadius: BorderRadius.circular(5),
                    ),
                    // OutlineInputBorder
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1.0,
                        color: Colors.blue,
                      ), // BorderSide
                      borderRadius: BorderRadius.circular(5),
                    ),
                    // OutlineInputBorder
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.red,
                      ), // BorderSide
                    ),
                    // OutlineInputBorder
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.red,
                      ), // BorderSide
                    ),
                    // OutlineInputBorder
                    hintText: "Nama Lengkap",
                    errorText: _errorNamaLengkap
                ), // InputDecoration
              ),
              // TextField
              const SizedBox(height: 16,),
              TextField(
                controller: userNameController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1.0,
                      color: Colors.blue,
                    ), // BorderSide
                    borderRadius: BorderRadius.circular(5),
                  ),
                  // OutlineInputBorder
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 1.0,
                        color: Colors.red
                    ), // BorderSide
                  ),
                  // OutlineInputBorder
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: Colors.red
                      ) // BorderSide
                  ),
                  // OutlineInputBorder
                  hintText: "Username",
                  errorText: _errorUserName,
                ), // InputDecoration
              ),
              // TextField
              const SizedBox(height: 16,),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1.0,
                      color: Colors.blue,
                    ), // BorderSide
                    borderRadius: BorderRadius.circular(5),
                  ),
                  // OutlineInputBorder
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide (
                      width: 1.0,
                      color: Colors.blue,
                    ), // BorderSide
                    borderRadius: BorderRadius.circular(5),
                  ),
                  // OutlineInputBorder
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1,
                        color: Colors.red
                    ), // BorderSide
                  ),
                  // OutlineInputBorder
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1,
                        color: Colors.red
                    ), // BorderSide
                  ),
                  // OutlineInputBorder
                  hintText: "Email",
                  errorText: _errorEmail,
                ), // InputDecoration
              ),
              // TextField
              const SizedBox(height: 16,),
              TextField(
                controller: passwordController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide (
                      width: 1.0,
                      color: Colors.blue,
                    ), // BorderSide
                    borderRadius: BorderRadius.circular(5),
                  ),
                  // OutlineInputBorder
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide (
                      width: 1.0,
                      color: Colors.blue,
                    ), // BorderSide
                    borderRadius: BorderRadius.circular(5),
                  ),
                  // OutlineInputBorder
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.red,
                    ), // BorderSide
                  ),
                  // OutlineInputBorder
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1,
                        color: Colors.red
                    ), // BorderSide
                  ),
                  // OutlineInputBorder
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off
                          : Icons.visibility,
                    ),),
                  // Icon, IconButton
                  hintText: "Password",
                  errorText: _errorPassword,
                ), // InputDecoration
                obscureText: _obscurePassword,
              ),
              // TextField
              const SizedBox(height: 24,),
              ElevatedButton(
                onPressed: () {
                  _signUp();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16).
                  child: Text("Register",
                  style: TextStyle(fontSize: 20, color: Colors.indigo),),
              )), // Padding, ElevatedButton
          const SizedBox(height: 24,),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: "Sudah Punya Akun ?",
                style: TextStyle(fontSize: 16, color: Colors.black),
                children: [
                  TextSpan(
                      text: "\nLogin di Sini",
                      style: TextStyle(
                        color: Colors.deepPurple,
                        decoration: TextDecoration.underline,
                        fontSize: 16,
                      ), // Textstyle
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    LoginScreens()), // MaterialPageRoute
                          );
                        }
                  ), //TextSpan
                ]
            ), //TextSpan
          ), //RichText
          ],
        ), //Column
      ), //Padding
      ), //SingleChildScrollView
      ); //Scaffold
  }
}

