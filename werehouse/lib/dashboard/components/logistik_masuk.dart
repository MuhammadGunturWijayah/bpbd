import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;
import 'package:werehouse/shared/global.dart';

var selectedService = 0;
DateTime? selectedDate; // Change to nullable DateTime

class LogistikMasuk extends StatefulWidget {
  @override
  _logistikmasukstate createState() => _logistikmasukstate();
}

class Supplier {
  final String nama;
  Supplier({required this.nama});
}

class Logistik {
  final String nama;
  Logistik({required this.nama});
}

class _logistikmasukstate extends State<LogistikMasuk> {
  final TextEditingController _tanggalKadaluarsaController =
      TextEditingController();
  final TextEditingController _keteranganController = TextEditingController();
  final TextEditingController _namaSupplierController = TextEditingController();
  final TextEditingController _tanggalMasukController = TextEditingController();
  final TextEditingController _namaLogistikController = TextEditingController();
  final TextEditingController _jumlahLogistikController =
      TextEditingController();
  final TextEditingController _dokumentasiController = TextEditingController();
  final TextEditingController _ListSupplier = TextEditingController();
  final TextEditingController _ListLogistik = TextEditingController();
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
                      SizedBox(height: 10),
                      const SizedBox(height: 10),
                      _buildTextFieldWithButton(
                        hintText: 'Input Tanggal',
                        label: 'Tanggal Masuk Logistik :',
                        controller: _tanggalMasukController,
                        onTap: () {
                          _selectDate(context);
                        },
                      ),
                      const SizedBox(height: 10),
                      _fieldNamaSupplier(
                        hintText: 'Nama Supplier',
                        label: 'Pilih Nama Supplier :',
                        controller: _namaSupplierController,
                        onTap: () {
                          _showDaftarSupplier(context);
                        },
                      ),
                      _fieldListSupplier(
                        controller: _ListSupplier,
                        onTap: () {},
                        onButtonTaps: () {},
                        listSupplier:
                            listSupplier, // Pass the list of items here
                      ),
                      const SizedBox(height: 10),
                      _fieldNamaLogistik(
                        hintText: 'Nama Logistik',
                        label: 'Pilih Nama Logistik :',
                        controller: _namaLogistikController,
                        onTap: () {
                          _showDaftarLogistik(context);
                        },
                      ),
                      _fieldListLogistik(
                        controller: _ListLogistik,
                        onTap: () {},
                        onButtonTaps: () {},
                        listLogistik:
                            listLogistik, // Pass the list of items here
                      ),
                      const SizedBox(height: 10),
                      _fieldKeterangan(
                        hintText: 'Jumlah',
                        label: 'Jumlah Logistik :',
                        controller: _jumlahLogistikController,
                        onTap: () {},
                      ),
                      const SizedBox(height: 10),
                      _fieldKeterangan(
                        hintText: 'Keterangan',
                        label: 'Keterangan :',
                        controller: _keteranganController,
                        onTap: () {},
                      ),
                      const SizedBox(height: 10),
                      _fieldKeterangan(
                        hintText: 'Dokumentasi',
                        label: 'Dokumentasi :',
                        controller: _dokumentasiController,
                        onTap: () {},
                      ),
                      const SizedBox(height: 10),
                      _buildTextFieldWithButton2(
                        hintText: 'Input Tanggal',
                        label: 'Tanggal Kadaluarsa :',
                        controller: _tanggalKadaluarsaController,
                        onTap: () {
                          _selectDate2(context);
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _customButton(
                            text: 'Simpan',
                            onPressed: () {
                              _simpanData(context);
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

   void onTap() {
    _showDaftarSupplier(context);
    _showDaftarLogistik(context);
  }

  List<Map<String, dynamic>> selectedItems = [];

  List<Supplier> listSupplier = [];
  final List<String> DaftarSupplier = [
    '1',
    'Lukman',
  ];
    void _showDaftarSupplier(BuildContext context) {
    List<String> filteredDaftarSupplier = List.from(DaftarSupplier);

    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: MediaQuery.of(context).size.height / 1,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: new Icon(Icons.arrow_back_ios),
                      title: new Text(
                        'Pilih Nama Supplier',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
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
                        decoration: InputDecoration(
                          hintText: 'Pencarian',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          prefixIcon: Icon(Icons.search),
                        ),
                        onChanged: (value) {
                          setState(() {
                            filteredDaftarSupplier = DaftarSupplier.where(
                                (barang) => barang
                                    .toLowerCase()
                                    .contains(value.toLowerCase())).toList();
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredDaftarSupplier.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(filteredDaftarSupplier[index]),
                          onTap: () {
                            _namaSupplierController.text =
                                filteredDaftarSupplier[index];
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
      },
    );
  }

  void _tambahSupplier() {
    if (_namaSupplierController.text.isEmpty) {
      // Jika salah satu field tidak terisi, tampilkan notifikasi
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lengkapi kolom terlebih dahulu'),
        ),
      );
      return; // Hentikan proses tambah barang
    }

    // Buat objek Barang baru
    Supplier SupplierBaru = Supplier(
      nama: _namaSupplierController.text,
    );

    // Tambahkan barang ke dalam list selectedItems
    setState(() {
      selectedItems.add({
        'nama': SupplierBaru.nama,
      });
      listSupplier.add(SupplierBaru); // Tambahkan barang ke dalam listBarang
    });

    // Reset field setelah menambahkan barang
    _namaSupplierController.clear();

    // Update controller _ListBarang agar menampilkan data baru
    _ListSupplier.text = listSupplier
        .map((supplier) => 'Supplier : ${supplier.nama}')
        .join('\n\n');
  }

    Widget _fieldNamaSupplier({
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
                  readOnly: true,
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

  Widget _fieldListSupplier({
    TextEditingController? controller,
    VoidCallback? onTap,
    required VoidCallback onButtonTaps,
    required List<Supplier> listSupplier,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: listSupplier.length,
          itemBuilder: (context, index) {
            final supplier = listSupplier[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
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
                  child: ListTile(
                    title: Text(
                      'Supplier : ${supplier.nama}',
                    ),
                    onTap: onTap,
                  ),
                ),
              ],
            );
          },
        ),
      ],
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

  Widget _buildTextFieldWithButton2({
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

  Widget _inkWell({required VoidCallback onTap, required Widget child}) {
    return InkWell(
      onTap: onTap,
      child: child,
    );
  }

  void readSupplier() async{

  }

  Widget _fieldKeterangan({
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

  List<Logistik> listLogistik = [];
  final List<String> DaftarLogistik = [
    '1',
    'Keran',
  ];

  void _showDaftarLogistik(BuildContext context) {
    List<String> filteredDaftarLogistik = List.from(DaftarLogistik);

    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: MediaQuery.of(context).size.height / 1,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: new Icon(Icons.arrow_back_ios),
                      title: new Text(
                        'Pilih Nama Logistik',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
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
                        decoration: InputDecoration(
                          hintText: 'Pencarian',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          prefixIcon: Icon(Icons.search),
                        ),
                        onChanged: (value) {
                          setState(() {
                            filteredDaftarLogistik = DaftarLogistik.where(
                                (barang) => barang
                                    .toLowerCase()
                                    .contains(value.toLowerCase())).toList();
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredDaftarLogistik.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(filteredDaftarLogistik[index]),
                          onTap: () {
                            _namaLogistikController.text =
                                filteredDaftarLogistik[index];
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
      },
    );
  }

  void _tambahLogistik() {

    // Buat objek Barang baru
    Logistik LogistikBaru = Logistik(
      nama: _namaLogistikController.text,
    );

    // Tambahkan barang ke dalam list selectedItems
    setState(() {
      selectedItems.add({
        'nama': LogistikBaru.nama,
      });
      listLogistik.add(LogistikBaru); // Tambahkan barang ke dalam listBarang
    });

    // Reset field setelah menambahkan barang
    _namaLogistikController.clear();

    // Update controller _ListBarang agar menampilkan data baru
    _ListLogistik.text = listLogistik
        .map((logistik) => 'Supplier : ${logistik.nama}')
        .join('\n\n');
  }

  Widget _fieldNamaLogistik({
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
                  readOnly: true,
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

  Widget _fieldListLogistik({
    TextEditingController? controller,
    VoidCallback? onTap,
    required VoidCallback onButtonTaps,
    required List<Logistik> listLogistik,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: listLogistik.length,
          itemBuilder: (context, index) {
            final Logistik = listLogistik[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
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
                  child: ListTile(
                    title: Text(
                      'Logistik : ${Logistik.nama}',
                    ),
                    onTap: onTap,
                  ),
                ),
              ],
            );
          },
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) selectedDate = picked;
    _tanggalMasukController.text = selectedDate.toString().substring(0, 10);
  }

  Future<void> _selectDate2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) selectedDate = picked;
    _tanggalKadaluarsaController.text =
        selectedDate.toString().substring(0, 10);
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
      home: LogistikMasuk(),
    ));
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void _hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _showSuccessSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Success',
        message: 'Data barang berhasil disimpan!',
        contentType: ContentType.success,
      ),
    );

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showFailedSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Error',
        message: message,
        contentType: ContentType.failure,
      ),
    );

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _simpanData(BuildContext context) async {
    String tanggalMasuk = _tanggalMasukController.text;
    String namaSupplier = _namaSupplierController.text;
    String namaLogistik = _namaLogistikController.text;
    String jumlahLogistik = _jumlahLogistikController.text;
    String keteranganMasuk = _keteranganController.text;
    String dokumentasi = _dokumentasiController.text;
    String tanggalKadaluarsa = _tanggalKadaluarsaController.text;

    _showLoadingDialog(context); // Show loading dialog

    try {
      final url = Uri.parse('${Global.baseUrl}${Global.inlogistikpath}');
      print('Sending POST request to: $url');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'tanggal_masuk': tanggalMasuk,
          'id_supplier': namaSupplier,
          'id_logistik': namaLogistik,
          'jumlah_logistik_masuk': jumlahLogistik,
          'keterangan_masuk': keteranganMasuk,
          'dokumentasi_masuk': dokumentasi,
          'expayer_logistik': tanggalKadaluarsa,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response headers: ${response.headers}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        if (responseData['success']) {
          _hideLoadingDialog(context);
          _showSuccessSnackBar(context);
        } else {
          _hideLoadingDialog(context);
          _showFailedSnackBar(context,
              responseData['error'] ?? 'Terjadi kesalahan tidak diketahui');
        }
      } else if (response.statusCode == 302) {
        // Handle the redirection manually
        final newUrl = response.headers['location'];
        if (newUrl != null) {
          print('Following redirection to: $newUrl');
          final newResponse = await http.post(
            Uri.parse(newUrl),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'tanggal_masuk': tanggalMasuk,
              'id_supplier': namaSupplier,
              'id_logistik': namaLogistik,
              'jumlah_logistik_masuk': jumlahLogistik,
              'keterangan_masuk': keteranganMasuk,
              'dokumentasi_masuk': dokumentasi,
              'expayer_logistik': tanggalKadaluarsa,
            }),
          );

          print('New Response status: ${newResponse.statusCode}');
          print('New Response headers: ${newResponse.headers}');
          print('New Response body: ${newResponse.body}');

          if (newResponse.statusCode == 201) {
            final newResponseData = jsonDecode(newResponse.body);
            if (newResponseData['success']) {
              _hideLoadingDialog(context);
              _showSuccessSnackBar(context);
            } else {
              _hideLoadingDialog(context);
              _showFailedSnackBar(
                  context,
                  newResponseData['error'] ??
                      'Terjadi kesalahan tidak diketahui');
            }
          } else {
            _hideLoadingDialog(context);
            _showFailedSnackBar(context,
                'Gagal terhubung ke server dengan status ${newResponse.statusCode}');
          }
        } else {
          _hideLoadingDialog(context);
          _showFailedSnackBar(context, 'Gagal mengikuti redirection');
        }
      } else if (response.statusCode == 405) {
        _hideLoadingDialog(context);
        _showFailedSnackBar(
            context, 'Method Not Allowed: ${response.statusCode}');
      } else {
        _hideLoadingDialog(context);
        _showFailedSnackBar(context,
            'Gagal terhubung ke server dengan status ${response.statusCode}');
      }
    } catch (e) {
      _hideLoadingDialog(context);
      _showFailedSnackBar(context, 'Terjadi kesalahan: $e');
    }
  }
}
