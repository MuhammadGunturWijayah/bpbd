import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:werehouse/shared/global.dart'; // Sesuaikan dengan nama proyek Anda

class data_logistik extends StatelessWidget {
  final TextEditingController _namaBarangController = TextEditingController();
  final TextEditingController _kodelogistikController = TextEditingController();
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

  data_logistik({Key? key}) : super(key: key);

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
                        controller: _kodelogistikController,
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
  String namaBarang = _namaBarangController.text;
  String kodeLogistik = _kodelogistikController.text;
  final satuan = selectedSatuan;

  if (namaBarang.isEmpty || kodeLogistik.isEmpty || satuan == null) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text('Nama barang dan satuan tidak boleh kosong'),
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

  try {
    final url = Uri.parse('${Global.baseUrl}${Global.logistikMasukPath}');
    print('URL: $url');

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
      // Asumsikan 'success' adalah kunci yang menunjukkan keberhasilan
      if (responseData['success']) {
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
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text(responseData['error'] ?? 'Terjadi kesalahan tidak diketahui'),
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
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Gagal terhubung ke server dengan status ${response.statusCode}'),
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
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text('Terjadi kesalahan: $e'),
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
