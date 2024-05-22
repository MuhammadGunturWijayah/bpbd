import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:werehouse/shared/global.dart';

class LogistikMasuk extends StatefulWidget {
  @override
  _LogistikMasukState createState() => _LogistikMasukState();
}

class _LogistikMasukState extends State<LogistikMasuk> {
  final TextEditingController _namaSupplierController = TextEditingController();
  final TextEditingController _kodeSupplierController = TextEditingController();
  final TextEditingController _emailSupplierController =
      TextEditingController();
  final TextEditingController _teleponSupplierController =
      TextEditingController();
  final TextEditingController _instansiSupplierController =
      TextEditingController();
  List<Map<String, String>> _supplierList =
      []; // List untuk menyimpan data supplier

  @override
  void initState() {
    super.initState();
    _fetchSuppliers();
  }

  Future<void> _fetchSuppliers() async {
    try {
      final response = await http
          .get(Uri.parse('${Global.baseUrl}${Global.tambah_logistik_masuk}'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data != null && data['success']) {
          List<Map<String, String>> suppliers = [];

          for (var item in data['data']) {
            String namaSupplier = item['nama_supplier'] ??
                ''; // Defaultkan ke string kosong jika null
            String kodeSupplier = item['kode_supplier'] ??
                ''; // Defaultkan ke string kosong jika null
            String emailSupplier = item['email_supplier'] ??
                ''; // Defaultkan ke string kosong jika null
            String teleponSupplier = item['telepon_supplier'] ??
                ''; // Defaultkan ke string kosong jika null
            String instansiSupplier = item['instansi_supplier'] ??
                ''; // Defaultkan ke string kosong jika null
            suppliers.add({
              'nama_supplier': namaSupplier,
              'kode_supplier': kodeSupplier,
              'email_supplier': emailSupplier,
              'telepon_supplier': teleponSupplier,
              'instansi_supplier': instansiSupplier,
            });
          }

          setState(() {
            _supplierList = suppliers;
          });
        } else {
          // Handle case when data['success'] is false or data is null
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Error'),
              content: Text('Gagal mengambil data supplier'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK'),
                ),
              ],
            ),
          );
        }
      } else {
        // Handle HTTP error status codes
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content:
                Text('Gagal terhubung ke server (HTTP ${response.statusCode})'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      // Handle general exceptions
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Terjadi kesalahan: ${e.toString()}'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Logistik Masuk'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      _buildTextField(
                        controller: _namaSupplierController,
                        hintText: 'Pilih nama supplier',
                        label: 'Nama Supplier:',
                        onTap: () {
                          _showSupplierDialog();
                        },
                      ),
                      const SizedBox(height: 10),
                      _fieldLainnya1(
                        controller: _kodeSupplierController,
                        hintText: 'Kode Supplier',
                        label: 'Kode Supplier :',
                      ),
                      const SizedBox(height: 10),
                      _fieldLainnya1(
                        controller: _emailSupplierController,
                        hintText: 'Email Supplier',
                        label: 'Email Supplier :',
                      ),
                      const SizedBox(height: 10),
                      _fieldLainnya1(
                        controller: _teleponSupplierController,
                        hintText: 'Telepon Supplier',
                        label: 'Telepon Supplier :',
                      ),
                      const SizedBox(height: 10),
                      _fieldLainnya1(
                        controller: _instansiSupplierController,
                        hintText: 'Instansi Supplier',
                        label: 'Instansi Supplier :',
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
                            color: Colors.green,
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

  Widget _fieldLainnya1({
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
            controller: controller,
            maxLines: null,
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String hintText,
    required String label,
    TextEditingController? controller,
    VoidCallback? onTap,
    bool enabled = true,
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
            controller: controller,
            onTap: onTap,
            readOnly: true,
            maxLines:
                null, // Set maxLines menjadi null untuk mengizinkan teks turun ke baris baru
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              suffixIcon:
                  Icon(Icons.arrow_drop_down), // Icon panah ke bawah di sini
            ),
          ),
        ),
      ],
    );
  }

  void _showSupplierDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Pilih Nama Supplier'),
          content: Container(
            width: double.minPositive,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _supplierList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_supplierList[index]['nama_supplier']!),
                  onTap: () {
                    setState(() {
                      _namaSupplierController.text =
                          _supplierList[index]['nama_supplier']!;
                      _kodeSupplierController.text =
                          _supplierList[index]['kode_supplier']!;
                      _emailSupplierController.text =
                          _supplierList[index]['email_supplier']!;
                      _teleponSupplierController.text =
                          _supplierList[index]['telepon_supplier']!;
                      _instansiSupplierController.text =
                          _supplierList[index]['instansi_supplier']!;
                    });
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        );
      },
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
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Future<void> _simpanData(BuildContext context) async {
    final namaSupplier = _namaSupplierController.text;
    final kodeSupplier = _kodeSupplierController.text;
    final emailSupplier = _emailSupplierController.text;
    final teleponSupplier = _teleponSupplierController.text;
    final instansiSupplier = _instansiSupplierController.text;


    if (namaSupplier.isEmpty || kodeSupplier.isEmpty || emailSupplier.isEmpty || teleponSupplier.isEmpty || instansiSupplier.isEmpty) {
      // Tampilkan pesan error jika nama supplier atau kode logistik kosong
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Nama supplier dan kode logistik tidak boleh kosong'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    final response = await http.post(
      Uri.parse('${Global.baseUrl}${Global.tambah_logistik_masuk}'),
      body: {
        'nama_supplier': namaSupplier,
        'kode_supplier': kodeSupplier,
        'email_supplier' : emailSupplier,
        'telepon_supplier' : teleponSupplier,
        'instansi_supplier' : instansiSupplier,
        
        // Tambahkan field lain jika diperlukan
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['success']) {
        // Tampilkan pesan sukses
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Sukses'),
            content: Text('Barang berhasil ditambahkan'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        // Tampilkan pesan error dari server
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text(responseData['error']),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } else {
      // Tampilkan pesan error jika server tidak merespon
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Gagal terhubung ke server'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
