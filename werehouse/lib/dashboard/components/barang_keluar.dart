import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart'; // Import untuk showDatePicker
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:http/http.dart' as http;

var selectedService = 0;

class barang_keluar extends StatefulWidget {
  @override
  _barang_keluarState createState() => _barang_keluarState();
}

class Barang {
  final String nama;
  final int jumlah;
  final String satuan;

  Barang({required this.nama, required this.jumlah, required this.satuan});
}

class _barang_keluarState extends State<barang_keluar> {
  final TextEditingController _namaBarangController = TextEditingController();
  final TextEditingController _jumlahController = TextEditingController();
  final TextEditingController _satuanController = TextEditingController();
  final TextEditingController _ListBarang = TextEditingController();
  final List<String> satuanOptions = [
    'Pieces (pcs)',
    'Kilogram (kg)',
    'Gram (g)',
    'Meter (m)',
    'Centimeter (cm)',
    'Liter (L)',
    'Mililiter (ml)',
    'Box',
    'Botol',
    'Dus',
    'Rol',
    'Lembar',
    'Set',
    'Buah',
    'Pak',
  ];

  String? selectedSatuan;
  List<Map<String, dynamic>> selectedItems =
      []; // List untuk menyimpan detail barang
  List<Barang> listBarang = [];
  // Deklarasi daftar barang
  final List<String> daftarBarang = [
    'Sapu',
    'Sapu',
    'Sapu',
    'Sendok',
    'Sendok cangkul',
    'Handuk',
    'Handuk',
    'Tas',
    'Tas',
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                _greetings(),
                const SizedBox(
                  height: 16,
                ),
                _card(),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildThreeFieldsInRow(
                        hintText1: 'Nama',
                        hintText2: 'Jumlah',
                        hintText3: 'Satuan',
                        label1: 'Nama Barang :',
                        label2: 'Jumlah :',
                        label3: 'Satuan :',
                        controller1: _namaBarangController,
                        controller2: _jumlahController,
                        controller3: _satuanController,
                        onTap1: () {
                          _showDaftarBarang(context);
                        },
                        onTap3: () {
                          ShowsatuanOptions(context);
                        },
                        onButtonTap: () {
                          _tambahBarang();
                        },
                      ),
                      SizedBox(height: 10),
                      _FieldListBarang(
                        hintText: '',
                        label: 'List Barang :',
                        controller: _ListBarang,
                        onTap: () {},
                        onButtonTaps: () {},
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _tambahBarang() {
    if (_namaBarangController.text.isEmpty ||
        _jumlahController.text.isEmpty ||
        _satuanController.text.isEmpty) {
      // Jika salah satu field tidak terisi, tampilkan notifikasi
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lengkapi kolom terlebih dahulu'),
        ),
      );
      return; // Hentikan proses tambah barang
    }

    // Buat objek Barang baru
    Barang barangBaru = Barang(
      nama: _namaBarangController.text,
      jumlah: int.parse(_jumlahController.text),
      satuan: _satuanController.text,
    );

    // Tambahkan barang ke dalam list selectedItems
    setState(() {
      selectedItems.add({
        'nama': barangBaru.nama,
        'jumlah': barangBaru.jumlah,
        'satuan': barangBaru.satuan,
      });
      listBarang.add(barangBaru); // Tambahkan barang ke dalam listBarang
    });

    // Reset field setelah menambahkan barang
    _namaBarangController.clear();
    _jumlahController.clear();
    _satuanController.clear();

    // Update controller _ListBarang agar menampilkan data baru
    _ListBarang.text = listBarang
        .map((barang) =>
            'Barang : ${barang.nama}\nJumlah : ${barang.jumlah} \nSatuan : ${barang.satuan}')
        .join('\n\n');
  }

//

  Widget _buildTextFieldWithButton({
    required String hintText,
    required String label,
    TextEditingController? controller,
    VoidCallback? onTap,
    VoidCallback? onButtonTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: controller,
                  onTap: onTap,
                  readOnly: true, // Set field menjadi tidak bisa ditulis
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: hintText,
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    suffixIcon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  TextEditingController controller = TextEditingController();

  void onTap1() {
    _showDaftarBarang(context);
  }

  Widget _buildBarangField() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nama Barang :',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: _namaBarangController,
                  onTap: onTap1,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: 'Nama',
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Jumlah :',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Jumlah',
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  ),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Satuan :',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Satuan',
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildThreeFieldsInRow({
    required String hintText1,
    required String hintText2,
    required String hintText3,
    required String label1,
    required String label2,
    required String label3,
    TextEditingController? controller1,
    TextEditingController? controller2,
    TextEditingController? controller3,
    VoidCallback? onTap1,
    VoidCallback? onTap2,
    VoidCallback? onTap3,
    required VoidCallback onButtonTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label1,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: controller1,
                      onTap: onTap1,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: hintText1,
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label2,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: controller2,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: hintText2,
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      ),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label3,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: controller3,
                      onTap: onTap3,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: hintText3,
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        // Menambahkan tombol di bawah field

        _inkWell(
          onTap:
              onButtonTap, // Anda bisa menggunakan onButtonTap untuk menambahkan item saat tombol ditekan
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Text(
                'Tambah Ke List Barang',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _inkWell({required VoidCallback onTap, required Widget child}) {
    return InkWell(
      onTap: onTap,
      child: child,
    );
  }

  Widget _FieldListBarang({
    required String hintText,
    required String label,
    TextEditingController? controller,
    VoidCallback? onTap,
    required VoidCallback onButtonTaps,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Color.fromARGB(255, 171, 171, 171),
            fontSize: 12,
          ),
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  onTap: onTap,
                  maxLines: null,
                  enabled: false, // Field tidak bisa diketik
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                  ),
                  decoration: InputDecoration(
                    hintText: hintText,
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        // Menambahkan tombol di bawah field
        _inkWell(
          onTap:
              onButtonTaps, // Anda bisa menggunakan onButtonTap untuk menambahkan item saat tombol ditekan
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Lanjutkan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSatuanDropdown(
      {required String hintText, required String label}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
        SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: DropdownButtonFormField<String>(
            value: selectedSatuan,
            onChanged: (newValue) {
              selectedSatuan = newValue;
            },
            items: satuanOptions.map((satuan) {
              return DropdownMenuItem<String>(
                value: satuan,
                child: Text(satuan),
              );
            }).toList(),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            ),
          ),
        ),
      ],
    );
  }

  AspectRatio _card() {
    return AspectRatio(
      aspectRatio: 336 / 184,
      child: Container(
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: const Color(0xFF818AF9),
        ),
        child: Stack(
          children: [
            Image.asset(
              'assets/images/fitur_barang.png',
              height: double.maxFinite,
              width: double.maxFinite,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Fitur Barang',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Kelola barang secara mudah\n dan aman.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDaftarBarang(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: MediaQuery.of(context).size.height / 1,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: new Icon(Icons.arrow_back_ios),
                  title: new Text(
                    'Pilih Barang',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: daftarBarang.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(daftarBarang[index]),
                      onTap: () {
                        _namaBarangController.text = daftarBarang[index];
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void ShowsatuanOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: MediaQuery.of(context).size.height / 1,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: new Icon(Icons.arrow_back_ios),
                  title: new Text(
                    'Pilih Satuan',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: satuanOptions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(satuanOptions[index]),
                      onTap: () {
                        _satuanController.text = satuanOptions[index];
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget _greetings() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hai, Guntur!',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        Text(
          'Ayo lakukan pengiriman barang !',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    ),
  );
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      textTheme: GoogleFonts.poppinsTextTheme(),
    ),
    home: barang_keluar(),
  ));
}
