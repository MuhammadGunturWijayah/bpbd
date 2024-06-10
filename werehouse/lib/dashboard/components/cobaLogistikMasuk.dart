import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

import 'package:werehouse/shared/global.dart';

class Supplier {
  final String id;
  final String nama;

  Supplier({required this.id, required this.nama});
}

class Logistik {
  final String id;
  final String nama;

  Logistik({required this.id, required this.nama});
}

class CobaLogistikMasuk extends StatefulWidget {
  @override
  _LogistikMasukState createState() => _LogistikMasukState();
}

class _LogistikMasukState extends State<CobaLogistikMasuk> {
  final TextEditingController _namaSupplierController = TextEditingController();
  final TextEditingController _namaLogistikController = TextEditingController();
  final TextEditingController _ListSupplier = TextEditingController();
  final TextEditingController _ListLogistik = TextEditingController();

  List<Map<String, dynamic>> selectedItems = [];
  List<Supplier> listSupplier = [];
  List<String> daftarSupplier = [];

  List<Logistik> listLogistik = [];
  List<String> daftarLogistik = [];

  @override
  void initState() {
    super.initState();
    fetchLogistik().then((logistik) {
      setState(() {
        listLogistik = logistik;
        daftarLogistik = logistik.map((logistik) => logistik.nama).toList();
      });
    }).catchError((error) {
      print('Error fetching logistik: $error');
    });

    fetchSuppliers().then((suppliers) {
      setState(() {
        listSupplier = suppliers;
        daftarSupplier = suppliers.map((supplier) => supplier.nama).toList();
      });
    }).catchError((error) {
      print('Error fetching suppliers: $error');
    });
  }

  Future<List<Logistik>> fetchLogistik() async {
  final response = await http.get(Uri.parse('${Global.baseUrl}${Global.getLogistikMasuk}'));

  if (response.statusCode == 200) {
    final List<dynamic> jsonResponse = jsonDecode(response.body)['data'];
    print('Logistik Response: ${jsonResponse}'); // Print response for debugging
    
    List<Logistik> daftarLogistik = jsonResponse.map((item) => Logistik(
      id: item['id'].toString(),
      nama: item['nama_logistik'], // Ensure this is correct based on your JSON structure
    )).toList();
    return daftarLogistik;
  } else {
    throw Exception('Failed to load logistik');
  }
}

Future<List<Supplier>> fetchSuppliers() async {
  final response = await http.get(Uri.parse('${Global.baseUrl}${Global.getSupplierMasuk}'));

  if (response.statusCode == 200) {
    final List<dynamic> jsonResponse = jsonDecode(response.body)['data'];
    print('Suppliers Response: ${jsonResponse}'); // Print response for debugging
    
    List<Supplier> daftarSuppliers = jsonResponse.map((item) => Supplier(
      id: item['id'].toString(),
      nama: item['nama_supplier'], // Corrected property name
    )).toList();
    return daftarSuppliers;
  } else {
    throw Exception('Failed to load suppliers');
  }
}



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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                        listSupplier: listSupplier,
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
                        listLogistik: listLogistik,
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

  void _showDaftarSupplier(BuildContext context) {
  List<String> filteredDaftarSupplier = daftarSupplier;

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
                          filteredDaftarSupplier = daftarSupplier.where(
                              (supplier) => supplier
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

void _showDaftarLogistik(BuildContext context) {
  List<String> filteredDaftarLogistik = daftarLogistik;

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
                          filteredDaftarLogistik = daftarLogistik.where(
                              (logistik) => logistik
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



 void _simpanData(BuildContext context) {
  String namaSupplier = _namaSupplierController.text;
  String namaLogistik = _namaLogistikController.text;

  Supplier selectedSupplier = listSupplier.firstWhere((supplier) => supplier.nama == namaSupplier);
  Logistik selectedLogistik = listLogistik.firstWhere((logistik) => logistik.nama == namaLogistik);

  String supplierId = selectedSupplier.id;
  String logistikId = selectedLogistik.id;

  print('Supplier ID: $supplierId, Nama: $namaSupplier');
  print('Logistik ID: $logistikId, Nama: $namaLogistik');

  // Tambahkan logika untuk menyimpan data ke backend
}


  Widget _fieldNamaSupplier({
    required String hintText,
    required String label,
    required TextEditingController controller,
    required GestureTapCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.nunito(
              fontSize: 14, fontWeight: FontWeight.w700, color: Colors.black),
        ),
        TextField(
          controller: controller,
          onTap: onTap,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          ),
        ),
      ],
    );
  }

  Widget _fieldListSupplier({
    required TextEditingController controller,
    required List<Supplier> listSupplier,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'List Supplier',
          style: GoogleFonts.nunito(
              fontSize: 14, fontWeight: FontWeight.w700, color: Colors.black),
        ),
        TextField(
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
            hintText: 'Pilih Supplier',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            suffixIcon: IconButton(
              onPressed: () {
                _showDaftarSupplier(context);
              },
              icon: Icon(Icons.arrow_drop_down),
            ),
          ),
        ),
      ],
    );
  }

  Widget _fieldNamaLogistik({
    required String hintText,
    required String label,
    required TextEditingController controller,
    required GestureTapCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.nunito(
              fontSize: 14, fontWeight: FontWeight.w700, color: Colors.black),
        ),
        TextField(
          controller: controller,
          onTap: onTap,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          ),
        ),
      ],
    );
  }

  Widget _fieldListLogistik({
    required TextEditingController controller,
    required List<Logistik> listLogistik,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'List Logistik',
          style: GoogleFonts.nunito(
              fontSize: 14, fontWeight: FontWeight.w700, color: Colors.black),
        ),
        TextField(
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
            hintText: 'Pilih Logistik',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            suffixIcon: IconButton(
              onPressed: () {
                _showDaftarLogistik(context);
              },
              icon: Icon(Icons.arrow_drop_down),
            ),
          ),
        ),
      ],
    );
  }

  Widget _customButton({
    required String text,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return Container(
      width: 140,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
