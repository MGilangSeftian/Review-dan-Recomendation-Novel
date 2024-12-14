import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reccomendation_novel/screens/tampilan_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'dart:io' show File;
import 'package:flutter/foundation.dart' show kIsWeb;

class TampilanProfile extends StatefulWidget {
  const TampilanProfile({super.key});

  @override
  State<TampilanProfile> createState() => _TampilanProfileState();
}

class _TampilanProfileState extends State<TampilanProfile> {
  String _imageFile = '';
  final picker = ImagePicker();

  Future<void> _saveImage() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('imagePath', _imageFile);
  }
  Future<void> _loadImage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _imageFile = prefs.getString('imagePath') ?? '';
    });
  }


  Future<void> _getImage(ImageSource source) async {
    if (kIsWeb && source == ImageSource.camera) {
      debugPrint('Kamera tidak didukung di Web. Gunakan perangkat fisik.');
      return;
    }

    try {
      final pickedFile = await picker.pickImage(
          source: source,
          maxHeight: 720,
          maxWidth: 720,
          imageQuality: 80
      );
      if (pickedFile != null) {
        setState(() {
          _imageFile = pickedFile.path;
        });
        _saveImage();
      } else {
        debugPrint('No image selected.');
      }
    } catch (e) {
      
    }
  }

  void _showPicker() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: Colors.indigo[50],
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.camera,
                    color: Colors.indigo
                  ),
                  title: const Text('Camera'),
                  onTap: (){
                    debugPrint('Kamera dipanggil');
                    Navigator.of(context).pop();
                    _getImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: const Icon(
                      Icons.photo_library,
                      color: Colors.indigo
                  ),
                  title: const Text('Gallery'),
                  onTap: (){
                    Navigator.of(context).pop();
                    _getImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          );
        }
    );
  }

  List<String> history = [];

  String _NamaLengkap = '';
  String _UserName = '';
  String _Email = '';

  Future<void> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final encryptedNamaLengkap = prefs.getString('NamaLengkap') ?? '';
    final encryptedUsername = prefs.getString('UserName') ?? '';
    final encryptedEmail = prefs.getString('Email') ?? '';
    final keyString = prefs.getString('key') ?? '';
    final ivString = prefs.getString('iv') ?? '';

    if (encryptedNamaLengkap.isNotEmpty &&
        encryptedUsername.isNotEmpty &&
        encryptedEmail.isNotEmpty &&
        keyString.isNotEmpty &&
        ivString.isNotEmpty) {
      try {
        final key = encrypt.Key.fromBase64(keyString);
        final iv = encrypt.IV.fromBase64(ivString);
        final encrypter = encrypt.Encrypter(encrypt.AES(key));

        setState(() {
          _NamaLengkap = encrypter.decrypt64(encryptedNamaLengkap, iv: iv);
          _UserName = encrypter.decrypt64(encryptedUsername, iv: iv);
          _Email = encrypter.decrypt64(encryptedEmail, iv: iv);
        });
      } catch (e) {
        setState(() {
          _NamaLengkap = 'Dekripsi gagal';
          _UserName = 'Dekripsi gagal';
          _Email = 'Dekripsi gagal';
        });
      }
    } else {
      setState(() {
        _NamaLengkap = 'Data tidak tersedia';
        _UserName = 'Data tidak tersedia';
        _Email = 'Data tidak tersedia';
      });
    }
  }

  void _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      history = prefs.getStringList('history') ?? [];
    });
  }

  void _showHistoryDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.indigo[50],
          title: const Text('Riwayat Pembacaan',
            style: TextStyle(
              color: Colors.indigo,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Text(
                  'Berikut adalah judul novel yang telah Anda baca:',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                height: 300,
                child: ListView.builder(
                  itemCount: history.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: Colors.indigo[100],
                      child: ListTile(
                        title: Text(
                          '${index + 1}.  ${history[index]}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tutup',
                style: TextStyle(
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _logout() async {
    Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context) => TampilanLogin()),
    );
  }


  @override
  void initState(){
    super.initState();
    getUserData();
    _loadHistory();
    _loadImage();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text(
          'Profil',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.indigo, width: 2),
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _imageFile.isNotEmpty
                        ? (kIsWeb
                          ? NetworkImage(_imageFile)
                          : FileImage(File(_imageFile))) as ImageProvider
                        : AssetImage('assets/images/person.png'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  IconButton(
                    onPressed: _showPicker,
                    icon: Icon(Icons.camera_alt),
                    color: Colors.indigo,
                    iconSize: 30,
                  ),
                  const SizedBox(height: 20),
                  Text(_UserName,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(_Email,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(
                    color: Colors.indigo,
                    thickness: 1,
                  ),
                  const SizedBox(height: 20),
                  Text(_NamaLengkap,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _logout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Logout',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(5.0)
              ),
              child: IconButton(
                onPressed: _showHistoryDialog,
                icon: const Icon(Icons.history),
                color: Colors.white,
                iconSize: 30,
              ),
            ),
          )
        ],
      ),
    );
  }
}
