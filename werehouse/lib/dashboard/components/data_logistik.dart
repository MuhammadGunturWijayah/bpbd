import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:werehouse/shared/global.dart'; // Sesuaikan dengan nama proyek Anda

class DataLogistik extends StatelessWidget {
  final TextEditingController _namaBarangController = TextEditingController();
  final TextEditingController _kodeLogistikController = TextEditingController();
  final List<String> satuanOptions = [
    'Pieces (pcs)',
    'Kilogram (kg)',
    'Gram (g)',
    'Meter (m)',
    'Centimeter (cm)',
    'Liter (L)',
    'Mililiter (ml)',
  ];

  String? selectedSatuan;

  DataLogistik({Key? key}) : super(key: key);

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
    String namaBarang = _namaBarangController.text;
    String kodeLogistik = _kodeLogistikController.text;
    final satuan = selectedSatuan;

    if (namaBarang.isEmpty || kodeLogistik.isEmpty || satuan == null) {
      _showFailedSnackBar(context, 'Nama barang dan satuan tidak boleh kosong');
      return;
    }

    _showLoadingDialog(context); // Show loading dialog

    try {
      final url = Uri.parse('${Global.baseUrl}${Global.logistikMasukPath}');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'nama_logistik': namaBarang,
          'kode_logistik': kodeLogistik,
          'satuan_logistik': satuan,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        if (responseData['success']) {
          _hideLoadingDialog(context);
          _showSuccessSnackBar(context);
        } else {
          _hideLoadingDialog(context);
          _showFailedSnackBar(context, responseData['error'] ?? 'Terjadi kesalahan tidak diketahui');
        }
      } else {
        _hideLoadingDialog(context);
        _showFailedSnackBar(context, 'Gagal terhubung ke server dengan status ${response.statusCode}');
      }
    } catch (e) {
      _hideLoadingDialog(context);
      _showFailedSnackBar(context, 'Terjadi kesalahan: $e');
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
                        controller: _kodeLogistikController,
                        hintText: 'kode barang',
                        label: 'kode logistik :',
                      ),
                      const SizedBox(height: 10),
                      _buildTextField(
                        controller: _namaBarangController,
                        hintText: 'nama',
                        label: 'Nama Barang :',
                      ),
                      const SizedBox(height: 10),
                      _buildSatuanDropdown(
                        hintText: '(satuan)',
                        label: 'Satuan :',
                      ),
                      const SizedBox(height: 30),
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
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            onTap: onTap,
            maxLines: null,
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 7,
                offset: const Offset(0, 3),
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
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
                        color: const Color.fromARGB(255, 255, 255, 255),
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
      required Color color
      }) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 132),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
