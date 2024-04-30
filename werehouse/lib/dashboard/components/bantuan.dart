import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart'; // Import untuk showDatePicker
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

var selectedService = 0;
DateTime? selectedDate; // Change to nullable DateTime

class bantuan extends StatelessWidget {
  final Key? key;
  final TextEditingController _expiredController = TextEditingController();
  final TextEditingController _inputGambar = TextEditingController();
  final TextEditingController _inputShareLocation = TextEditingController();
  final TextEditingController _inputNomor = TextEditingController();
  final TextEditingController _namaBarangController = TextEditingController();
  final TextEditingController _jumlahController = TextEditingController();
  final TextEditingController _satuanController = TextEditingController();
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

  bantuan({this.key}) : super(key: key);

  // Deklarasi daftar barang
  final List<String> daftarBarang = [
    'Sapu',
    'Sapu',
    'Sapu',
    'Sendok',
    'Sendok',
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
                          // Panggil fungsi yang ingin Anda eksekusi ketika tombol ditekan
                        },
                      ),
                      const SizedBox(height: 10),
                      _fieldNomorKK(
                        hintText: 'Nomor KK',
                        label: 'Nomor KK :',
                        controller: _inputNomor,
                        onTap: () {},
                      ),
                      const SizedBox(height: 10),
                      _fieldDokumentasi(
                        hintText: 'Input Images',
                        label: 'Foto Dokumentasi :',
                        controller: _inputGambar,
                        onTap: () {
                          _getImage();
                        },
                      ),
                      const SizedBox(height: 10),
                      _buildTextFieldWithButton(
                        hintText: 'Input Tanggal',
                        label: 'Tanggal :',
                        controller: _expiredController,
                        onTap: () {
                          _selectDate(context);
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _customButton(
                            text: 'Simpan',
                            onPressed: () {
                              // Tambahkan fungsi untuk menyimpan data
                            },
                            color: Colors.blue,
                          ),
                          _customButton(
                            text: 'Cancel',
                            onPressed: () {
                              // Tambahkan fungsi untuk menghapus data
                            },
                            color: Colors.grey,
                          ),
                        ],
                      ),
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
    VoidCallback?
        onButtonTap, // Tambahkan parameter untuk menangani tombol input
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
        InkWell(
          onTap: onButtonTap,
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
                'Input',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16, // Sesuaikan ukuran font sesuai kebutuhan
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _fieldNomorKK({
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
                  maxLines: null,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                  ),
                  decoration: InputDecoration(
                    hintText: hintText,
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    suffixIcon: onButtonTap != null
                        ? InkWell(
                            onTap: onButtonTap,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Icon(
                                Icons.add,
                                size: 24,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : null,
                  ),
                ),
              ),
            ),
          ],
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

  Widget _fieldDokumentasi({
    required String hintText,
    required String label,
    TextEditingController? controller,
    VoidCallback? onTap,
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
              child: InkWell(
                onTap: onTap,
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
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: hintText,
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      suffixIcon: Icon(
                        Icons.camera_alt,
                        color: Colors.grey,
                      ),
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

  Widget _fieldShareLocation({
    required String hintText,
    required String label,
    TextEditingController? controller,
    VoidCallback? onTap,
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
              child: InkWell(
                onTap: onTap,
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
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: hintText,
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      suffixIcon: Icon(
                        Icons.location_on,
                        color: Colors.grey,
                      ),
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

  Widget _customButton({
    required String text,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Future<void> _showDaftarBarang(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Pilih Barang"),
          content: SingleChildScrollView(
            child: Column(
              children: daftarBarang
                  .map((barang) => ListTile(
                        title: Text(barang),
                        onTap: () {
                          Navigator.pop(context, barang);
                        },
                      ))
                  .toList(),
            ),
          ),
        );
      },
    );
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _inputGambar.text = pickedFile.path;
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) selectedDate = picked;
    _expiredController.text = selectedDate.toString().substring(0, 10);
  }

  void ShowsatuanOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: MediaQuery.of(context).size.height / 3,
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
          'Hai, User!',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        Text(
          'Ayo kelola barang kamu!',
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
    home: bantuan(),
  ));
}