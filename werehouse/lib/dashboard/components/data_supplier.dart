import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:werehouse/shared/global.dart';

var selectedService = 0;
DateTime? selectedDate;

class data_supplier extends StatelessWidget {
  final Key? key;
  final TextEditingController _kodeSupplierController = TextEditingController();
  final TextEditingController _namaSupplierController = TextEditingController();
  final TextEditingController _EmailController = TextEditingController();
  final TextEditingController _TeleponController = TextEditingController();
  final TextEditingController _Instansi_Supplier = TextEditingController();
  data_supplier({this.key}) : super(key: key);

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
                _card(),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      _buildTextField(
                        controller: _kodeSupplierController,
                        hintText: 'Masukan Kode',
                        label: 'kode supplier :',
                      ),
                      const SizedBox(height: 10),
                      _buildTextField(
                        controller: _namaSupplierController,
                        hintText: 'Masukan Nama',
                        label: 'Nama Supplier :',
                      ),
                      const SizedBox(height: 10),
                      _buildTextField(
                        controller: _EmailController,
                        hintText: 'Masukan Email',
                        label: 'Email :',
                      ),
                      const SizedBox(height: 10),
                      _buildTextField(
                        controller: _TeleponController,
                        hintText: 'Masukan Nomor Telepon',
                        label: 'Nomor Telepon :',
                      ),
                       const SizedBox(height: 10),
                      _buildTextField(
                        controller: _Instansi_Supplier,
                        hintText: 'Masukan Instansi',
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
                          _customButton(
                            text: 'Hapus',
                            onPressed: () {
                              // Tambahkan fungsi untuk menghapus data
                            },
                            color: Colors.red,
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

  Widget _buildTextField({
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
            onTap: onTap,
            maxLines:
                null, // Set maxLines menjadi null untuk mengizinkan teks turun ke baris baru
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Hallo, ",
                      style: GoogleFonts.manrope(
                        fontSize: 14,
                        color: Color.fromARGB(255, 255, 255, 255),
                        height: 150 / 100,
                      ),
                      children: const [
                        TextSpan(
                          text: "Silahkan  ",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        TextSpan(
                          text:
                              "\n Melengkapi Kolom \n Yang Ada Di \n Bawah Ini...",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _customButton(
      {required String text,
      required VoidCallback onPressed,
      required Color color}) {
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
   
    final kodeSupplier = _kodeSupplierController.text;
    final namaSupplier = _namaSupplierController.text;
    final emailSupplier = _EmailController.text;
    final teleponSupplier = _TeleponController.text;
    final instansiSupplier= _Instansi_Supplier.text;
    if ( kodeSupplier.isEmpty || namaSupplier.isEmpty || emailSupplier.isEmpty || teleponSupplier.isEmpty || instansiSupplier.isEmpty) {
      // Tampilkan pesan error jika nama barang atau satuan kosong
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('kolom tidak boleh kosong!!'),
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
      Uri.parse('${Global.baseUrl}${Global.supplierPath}'),
      body: {
        'kode_supplier': kodeSupplier,
        'nama_supplier': namaSupplier,
        'email_supplier' : emailSupplier,
        'telepon_supplier' : teleponSupplier,
        'instansi_supplier' : instansiSupplier,
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
