import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class TampilanLogin extends StatefulWidget {
  const TampilanLogin({super.key});

  @override
  State<TampilanLogin> createState() => _LoginScreensState();
}

class _LoginScreensState extends State<TampilanLogin> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorText = "";
  bool _isSignIn = false;
  bool _obscurePassword = true;

  void _signin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String savedEmail = prefs.getString('Email') ?? '';
    final String savedNamalengkap = prefs.getString('NamaLengkap') ?? '';
    final String savedUsername = prefs.getString('UserName') ?? '';
    final String savedpassword = prefs.getString('Password') ?? '';

    final String enteredEmail = _emailController.text.trim();
    final String enteredpassword = _passwordController.text.trim();


    if (enteredEmail.isEmpty || enteredpassword.isEmpty) {
      setState(() {
        _errorText = 'Username atau password harus diisi';
      });
      return;
    }
    if (savedUsername.isEmpty || savedEmail.isEmpty || savedpassword.isEmpty) {
      setState(() {
        _errorText = 'Pengguna belum terdaftar';
      });
      return;
    }

    if ((enteredEmail == savedUsername || enteredEmail == savedEmail) &&
        enteredpassword == savedpassword) {
      setState(() {
        _errorText = '';
        _isSignIn = true;
        prefs.setBool('isSignedIn', true);
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/Main');
      });
    } else {
      setState(() {
        _errorText = 'Nama pengguna atau kata sandi salah';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
          centerTitle: true,
          backgroundColor: Colors.blue,
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset("assets/images/Mobile_login.png"),
                  const SizedBox(height: 16),
                  const Text(
                    "Login Detail",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1.0, color: Colors.blue),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1.0, color: Colors.blue),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      hintText: "Username atau Email",
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1.0, color: Colors.blue),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1.0, color: Colors.blue),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        ),
                      ),
                      hintText: "Password",
                    ),
                    obscureText: _obscurePassword,
                  ),
                  const SizedBox(height: 16),
                  if (_errorText.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        _errorText,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onPressed: _signin,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  RichText(
                    text: TextSpan(
                      text: "Belum Punya Akun? ",
                      style: const TextStyle(fontSize: 16, color: Colors.blue),
                      children: [
                        TextSpan(
                          text: "Daftar di sini",
                          style: const TextStyle(
                            color: Colors.deepPurple,
                            decoration: TextDecoration.underline,
                            fontSize: 16,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, '/TampilanRegister');
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
           ),
        );
   }
}