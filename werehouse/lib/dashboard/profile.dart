import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Your App'),
      ),
      body: RootApp(),
    ),
  ));
}

class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  File? _image;

  Future<void> _getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<CustomListTile> customListTiles = [
      CustomListTile(
        icon: Icons.person,
        title: "akun",
        shadow: Colors.black,
      ),
      CustomListTile(
        icon: Icons.edit,
        title: "Edit Profile",
        shadow: Colors.black,
      ),
      CustomListTile(
        icon: Icons.lock,
        title: "Kata Sandi dan Keamanan",
        shadow: Colors.black,
      ),
      CustomListTile(
        title: "Detail Pribadi",
        icon: CupertinoIcons.person_2_alt,
        shadow: Colors.black,
      ),
      CustomListTile(
        title: "Logout",
        icon: CupertinoIcons.arrow_right_arrow_left,
        shadow: Colors.black,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text("PROFILE"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          // COLUMN THAT WILL CONTAIN THE PROFILE
          Column(
            children: [
              Stack(
                children: [
                  GestureDetector(
                    onTap: _getImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      backgroundImage: _image != null
                          ? FileImage(_image!) as ImageProvider<Object>
                          : const NetworkImage(
                              "https://www.pngall.com/wp-content/uploads/5/Profile-PNG-Images.png",
                            ),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    right: -2,
                    child: Stack(
                      children: [
                        Container(
                          width:
                              29, // menyesuaikan dengan lebar icon dan outline
                          height:
                              29, // menyesuaikan dengan tinggi icon dan outline
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            width: 29,
                            height: 29,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          child: IconButton(
                            onPressed: _getImage,
                            icon: Icon(
                              Icons.add,
                              size: 17,
                              color: Colors.white,
                            ),
                          ),
                          left: -9, // menyesuaikan posisi ikon dalam kotak biru
                          top: -9, // menyesuaikan posisi ikon dalam kotak biru
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                "Guntur Wijaya",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("~ User ~"),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Tambahkan fungsi onPressed sesuai kebutuhan
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Warna latar belakang tombol
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(30), // Mengatur border radius
                  ),
                  elevation: 4, // Menambahkan elevasi
                  shadowColor: Colors.black, // Warna bayangan
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    "Edit", // Teks pada tombol
                    style: TextStyle(
                      color: Colors.white, // Warna teks
                      fontSize: 16, // Ukuran teks
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...List.generate(
            customListTiles.length,
            (index) {
              final tile = customListTiles[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Card(
                  elevation: 4,
                  shadowColor: tile.shadow ?? Colors.black12, // Penambahan shadow color
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(30), // Mengatur border radius
                  ),
                  child: ListTile(
                    leading: Icon(tile.icon),
                    title: Text(
                      tile.title,
                      style: TextStyle(
                        color:
                            tile.title == 'Logout' ? Colors.red : Colors.black,
                      ),
                    ),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class CustomListTile {
  final IconData icon;
  final String title;
  final Color? shadow; // Mengubah tipe menjadi Color
  CustomListTile({
    required this.icon,
    required this.title,
    this.shadow, // Mengubah tipe menjadi Color
  });
}