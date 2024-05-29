import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:werehouse/shared/global.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class DataSupplier extends StatefulWidget {
  const DataSupplier({Key? key}) : super(key: key);

  @override
  _DataSupplierState createState() => _DataSupplierState();
}

class _DataSupplierState extends State<DataSupplier> {
  final TextEditingController _kodeSupplierController = TextEditingController();
  final TextEditingController _namaSupplierController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _teleponController = TextEditingController();
  final TextEditingController _instansiSupplier = TextEditingController();

  bool _isLoading = false;

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
                        label: 'Kode Supplier :',
                      ),
                      const SizedBox(height: 10),
                      _buildTextField(
                        controller: _namaSupplierController,
                        hintText: 'Masukan Nama',
                        label: 'Nama Supplier :',
                      ),
                      const SizedBox(height: 10),
                      _buildTextField(
                        controller: _emailController,
                        hintText: 'Masukan Email',
                        label: 'Email :',
                      ),
                      const SizedBox(height: 10),
                      _buildTextField(
                        controller: _teleponController,
                        hintText: 'Masukan Nomor Telepon',
                        label: 'Nomor Telepon :',
                      ),
                      const SizedBox(height: 10),
                      _buildTextField(
                        controller: _instansiSupplier,
                        hintText: 'Masukan Instansi',
                        label: 'Instansi Supplier :',
                      ),
                      const SizedBox(height: 20),
                      _isLoading
                          ? CircularProgressIndicator()
                          : Row(
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
                      style: TextStyle(
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

  void _showSuccessSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Success',
        message: 'Data supplier berhasil disimpan!',
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
  String kodeSupplier = _kodeSupplierController.text;
  String namaSupplier = _namaSupplierController.text;
  String emailSupplier = _emailController.text;
  String teleponSupplier = _teleponController.text;
  String instansiSupplier = _instansiSupplier.text;

  if (kodeSupplier.isEmpty ||
      namaSupplier.isEmpty ||
      emailSupplier.isEmpty ||
      teleponSupplier.isEmpty ||
      instansiSupplier.isEmpty) {
    _showFailedSnackBar(context, 'Semua kolom harus diisi');
    return;
  }

  _showLoadingDialog(context); // Show loading dialog

  try {
    final response = await http.post(
      Uri.parse('${Global.baseUrl}${Global.supplierPath}'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'kode_supplier': kodeSupplier,
        'nama_supplier': namaSupplier,
        'email_supplier': emailSupplier,
        'telepon_supplier': teleponSupplier,
        'instansi_supplier': instansiSupplier,
      }),
    );

    if (response.statusCode == 201) {
      _hideLoadingDialog(context);
      _showSuccessSnackBar(context);
    } else {
      _hideLoadingDialog(context);
      _showFailedSnackBar(context, 'Gagal terhubung ke server dengan status ${response.statusCode}');
    }
  } catch (e) {
    _hideLoadingDialog(context);
    _showFailedSnackBar(context, 'Terjadi kesalahan: $e');
  }
}


  void _hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop();
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
}
