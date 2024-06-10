import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:werehouse/dashboard/component_setting/screens/edit_screen.dart';
import 'package:werehouse/dashboard/components/logistik_masuk.dart';
import 'package:werehouse/shared/global.dart';

class barang_keluar extends StatefulWidget {
  @override
  _barang_keluarState createState() => _barang_keluarState();
}

class Barang {
  final String nama;
  final int jumlah;

  Barang({required this.nama, required this.jumlah});
}

class Logistik {
  final int id;
  final String namaLogistik;
  final int jumlahLogistikMasuk;

  Logistik({
    required this.id,
    required this.namaLogistik,
    required this.jumlahLogistikMasuk,
  });

  factory Logistik.fromJson(Map<String, dynamic> json) {
    return Logistik(
      id: json['id'],
      namaLogistik: json['nama_logistik']?.toString() ?? '',
      jumlahLogistikMasuk: json['jumlah_logistik_masuk'] ?? 0,
    );
  }

  @override
  String toString() {
    return 'Logistik{id: $id, namaLogistik: $namaLogistik, jumlahLogistikMasuk: $jumlahLogistikMasuk}';
  }
}

class _barang_keluarState extends State<barang_keluar> {
  final TextEditingController _namaLogistikController = TextEditingController();
  final TextEditingController _jumlahController = TextEditingController();
  final TextEditingController _ListBarang = TextEditingController();
  final TextEditingController _TanggalKejadianController =
      TextEditingController();
  final TextEditingController _inputNomorKKController = TextEditingController();
  final TextEditingController _inputAlamatController = TextEditingController();
  final TextEditingController _inputNamaPenerimaController =
      TextEditingController();
  final TextEditingController _inputKeteranganController =
      TextEditingController();
  final TextEditingController _dokumentasiController = TextEditingController();
  String userName = '';
  String userEmail = '';
  List<Map<String, dynamic>> selectedItems = [];
  List<Logistik> listLogistik = [];
  List<String> DaftarLogistik = [];
  List<Barang> listBarang = [];
  @override
  void initState() {
    super.initState();
    _loadUserName();

    fetchLogistik().then((logistik) {
      setState(() {
        listLogistik = logistik;
        DaftarLogistik =
            logistik.map((logistik) => logistik.namaLogistik).toList();
      });
    }).catchError((error) {
      print('Error fetching logistik: $error');
    });
  }

  void _loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? '';
    });
  }

  Widget _greetings() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ' hai, $userName',
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
                const SizedBox(height: 30),
                _greetings(),
                const SizedBox(height: 16),
                _card(),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildThreeFieldsInRow(
                        hintText1: 'Nama',
                        hintText2: 'Jumlah',
                        label1: 'Nama Barang :',
                        label2: 'Jumlah :',
                        controller1: _namaLogistikController,
                        controller2: _jumlahController,
                        onTap1: () {
                          _showDaftarBarang(context);
                        },
                        onButtonTap: () {
                          _tambahBarang();
                        },
                        addSpacing: true,
                      ),
                      _FieldListBarang(
                        hintText: '',
                        label: ' ',
                        controller: _ListBarang,
                        onTap: () {},
                        onButtonTaps: () {},
                        listBarang: listBarang,
                      ),
                      const SizedBox(height: 10),
                      _fieldNama(
                        hintText: 'Nama',
                        label: 'Nama Penerima :',
                        controller: _inputNamaPenerimaController,
                        onTap: () {},
                      ),
                      const SizedBox(height: 10),
                      _fieldAlamat(
                        hintText: 'Alamat',
                        label: 'Alamat Penerima :',
                        controller: _inputAlamatController,
                        onTap: () {},
                      ),
                      const SizedBox(height: 10),
                      _fieldNomorKK(
                        hintText: 'Nomor KK',
                        label: 'Nomor KK :',
                        controller: _inputNomorKKController,
                        onTap: () {},
                      ),
                      const SizedBox(height: 10),
                      _fieldKeterangan(
                        hintText: 'Keterangan',
                        label: 'Keterangan Kejadian :',
                        controller: _inputKeteranganController,
                        onTap: () {},
                      ),
                      const SizedBox(height: 10),
                      _fieldDokumentasi(
                        hintText: 'Dokumentasi',
                        label: 'Dokumentasi :',
                        controller: _dokumentasiController,
                        onTap: () =>
                            _pickImageFromGallery(_dokumentasiController),
                      ),
                      const SizedBox(height: 10),
                      _buildTextFieldWithButton(
                        hintText: 'Input Tanggal',
                        label: 'Tanggal Kejadian :',
                        controller: _TanggalKejadianController,
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

  Future<List<Logistik>> fetchLogistik() async {
  try {
    // Mengambil data logistik masuk
    final responseIn = await http.get(Uri.parse('${Global.baseUrl}${Global.getInLogistikMasuk}'));
    print('ResponseIn status: ${responseIn.statusCode}');
    print('ResponseIn body: ${responseIn.body}');

    if (responseIn.statusCode == 200) {
      final jsonResponseIn = jsonDecode(responseIn.body);
      final List<dynamic> jsonDataIn = jsonResponseIn['data'];
      print('jsonDataIn: $jsonDataIn');

      // Membuat peta dari id_logistik ke jumlah_logistik_masuk
      final Map<int, int> logistikMap = {
        for (var item in jsonDataIn)
          item['id_logistik'] ?? 0: item['jumlah_logistik_masuk'] ?? 0
      };
      print('logistikMap: $logistikMap');

      // Mengambil data logistik
      final responseLogistik = await http.get(Uri.parse('${Global.baseUrl}${Global.getLogistikMasuk}'));
      print('ResponseLogistik status: ${responseLogistik.statusCode}');
      print('ResponseLogistik body: ${responseLogistik.body}');

      if (responseLogistik.statusCode == 200) {
        final jsonResponseLogistik = jsonDecode(responseLogistik.body);
        final List<dynamic> jsonDataLogistik = jsonResponseLogistik['data'];
        print('jsonDataLogistik: $jsonDataLogistik');

        // Membuat peta dari id_logistik ke nama_logistik
        final Map<int, String> logistikNameMap = {
          for (var item in jsonDataLogistik)
            item['id'] ?? 0: item['nama_logistik'] ?? ''
        };
        print('logistikNameMap: $logistikNameMap');

        // Memetakan data ke objek Logistik
        List<Logistik> daftarLogistik = logistikMap.entries.map((entry) {
          final idLogistik = entry.key;
          final jumlahLogistikMasuk = entry.value;
          final namaLogistik = logistikNameMap[idLogistik] ?? '';
          print('Mapping id_logistik $idLogistik to nama_logistik $namaLogistik');
          return Logistik(
            id: idLogistik,
            namaLogistik: namaLogistik,
            jumlahLogistikMasuk: jumlahLogistikMasuk,
          );
        }).toList();

        print('daftarLogistik: $daftarLogistik');
        return daftarLogistik;
      } else {
        throw Exception('Gagal memuat data logistik: ${responseLogistik.statusCode}');
      }
    } else {
      throw Exception('Gagal memuat data logistik masuk: ${responseIn.statusCode}');
    }
  } catch (e) {
    print('Exception: $e');
    throw Exception('Gagal memuat data logistik: $e');
  }
}


  void _tambahBarang() {
    if (_namaLogistikController.text.isEmpty ||
        _jumlahController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lengkapi kolom terlebih dahulu'),
        ),
      );
      return;
    }

    int jumlahLogistikMasuk = listLogistik
        .firstWhere(
            (logistik) => logistik.namaLogistik == _namaLogistikController.text,
            orElse: () =>
                Logistik(id: 0, namaLogistik: '', jumlahLogistikMasuk: 0))
        .jumlahLogistikMasuk;

    int jumlahBarang = int.parse(_jumlahController.text);

    if (jumlahBarang > jumlahLogistikMasuk) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Jumlah barang melebihi stok yang tersedia (${jumlahLogistikMasuk})'),
        ),
      );
      return;
    }

    Barang barangBaru = Barang(
      nama: _namaLogistikController.text,
      jumlah: jumlahBarang,
    );

    setState(() {
      selectedItems.add({
        'nama': barangBaru.nama,
        'jumlah': barangBaru.jumlah,
      });
      listBarang.add(barangBaru);
    });

    _namaLogistikController.clear();
    _jumlahController.clear();

    _ListBarang.text = listBarang
        .map((barang) => 'Barang : ${barang.nama}\nJumlah : ${barang.jumlah}')
        .join('\n\n');
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
                  readOnly: true,
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
                  controller: _namaLogistikController,
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
      ],
    );
  }

  Widget _buildThreeFieldsInRow({
    required String hintText1,
    required String hintText2,
    required String label1,
    required String label2,
    TextEditingController? controller1,
    TextEditingController? controller2,
    VoidCallback? onTap1,
    VoidCallback? onTap2,
    VoidCallback? onTap3,
    required VoidCallback onButtonTap,
    bool addSpacing =
        false, // Add a boolean parameter to determine whether to add spacing
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
          ],
        ),
        SizedBox(height: addSpacing ? 15 : 0), // Add spacing conditionally
        // Menambahkan tombol di bawah field
        _inkWell(
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
                'Tambah Barang',
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
    required List<Barang> listBarang,
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
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: listBarang.length,
          itemBuilder: (context, index) {
            final barang = listBarang[index];
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
                      'Barang : ${barang.nama}\nJumlah: ${barang.jumlah}',
                    ),
                    onTap: onTap,
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _deleteItem(index);
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  void _deleteItem(int index) {
    setState(() {
      listBarang.removeAt(index);
    });
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
                      leading: Icon(Icons.arrow_back_ios),
                      title: Text(
                        'Pilih ID Logistik',
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
                              (logistik) => logistik
                                  .toLowerCase()
                                  .contains(value.toLowerCase()),
                            ).toList();
                            print(
                                'Filtered Daftar Logistik: $filteredDaftarLogistik');
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredDaftarLogistik.length,
                      itemBuilder: (context, index) {
                        print(
                            'Building ListTile for ${filteredDaftarLogistik[index]}');
                        return ListTile(
                          title: Text(filteredDaftarLogistik[index]),
                          onTap: () {
                            _namaLogistikController.text =
                                filteredDaftarLogistik[index]
                                    .split(':')[0]
                                    .trim();
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

  Widget _fieldNama({
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

  Widget _fieldAlamat({
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

  Widget _fieldDokumentasi({
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
                  readOnly: true,
                  onTap: onTap, // Panggil onTap yang telah ditetapkan
                  maxLines: 1,
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
                                Icons.camera_alt,
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

  Future<void> _pickImageFromGallery(TextEditingController controller) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      controller.text = image.path;
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
    _TanggalKejadianController.text = selectedDate.toString().substring(0, 10);
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
                  keyboardType: TextInputType.number,
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

  void main() {
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: barang_keluar(),
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

  // 'id_logistik': listLogistik.firstWhere((logistik) => logistik.namaLogistik == namaLogistik).id,

 void _simpanData(BuildContext context) async {
  String namaPenerima = _inputNamaPenerimaController.text;
  String alamatPenerima = _inputAlamatController.text;
  String kkPenerima = _inputNomorKKController.text;
  String keterangan = _inputKeteranganController.text;
  String dokumentasi = _dokumentasiController.text;
  String tanggalKejadian = _TanggalKejadianController.text;

  _showLoadingDialog(context); // Show loading dialog

  for (var barang in listBarang) {
    try {
      // Find the Logistik item that matches the barang name
      Logistik? logistik = listLogistik.firstWhere(
        (logistik) => logistik.namaLogistik == barang.nama,
        orElse: () => Logistik(id: 0, namaLogistik: '', jumlahLogistikMasuk: 0),
      );

      if (logistik == null || logistik.id == 0) {
        throw Exception('Logistik item not found for ${barang.nama}');
      }

      // Construct the URL
      final url = Uri.parse('${Global.baseUrl}${Global.outLogistikpath}');
      print('Sending POST request to: $url');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'id_logistik': logistik.id, // Use the actual ID
          'jumlah_logistik_keluar': barang.jumlah,
          'tanggal_keluar': tanggalKejadian,
          'nama_penerima': namaPenerima,
          'alamat_penerima': alamatPenerima,
          'nik_kk_penerima': kkPenerima,
          'keterangan_keluar': keterangan,
          'dokumentasi_keluar': dokumentasi,
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
          _showFailedSnackBar(context, responseData['error'] ?? 'Terjadi kesalahan tidak diketahui');
        }
      } else if (response.statusCode == 302) {
        await _handleRedirection(context, response.headers['location'], {
          'id_logistik': logistik.id, // Use the actual ID
          'jumlah_logistik_keluar': barang.jumlah,
          'tanggal_keluar': tanggalKejadian,
          'nama_penerima': namaPenerima,
          'alamat_penerima': alamatPenerima,
          'nik_kk_penerima': kkPenerima,
          'keterangan_keluar': keterangan,
          'dokumentasi_keluar': dokumentasi,
        });
      } else if (response.statusCode == 405) {
        _hideLoadingDialog(context);
        _showFailedSnackBar(context, 'Method Not Allowed: ${response.statusCode}');
      } else {
        _hideLoadingDialog(context);
        _showFailedSnackBar(context, 'Gagal terhubung ke server dengan status ${response.statusCode}');
      }
    } catch (e) {
      _hideLoadingDialog(context);
      _showFailedSnackBar(context, 'Terjadi kesalahan: $e');
    }
  }
}


Future<void> _handleRedirection(BuildContext context, String? newUrl, Map<String, dynamic> body) async {
  if (newUrl != null) {
    print('Following redirection to: $newUrl');
    final newResponse = await http.post(
      Uri.parse(newUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
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
        _showFailedSnackBar(context, newResponseData['error'] ?? 'Terjadi kesalahan tidak diketahui');
      }
    } else {
      _hideLoadingDialog(context);
      _showFailedSnackBar(context, 'Gagal terhubung ke server dengan status ${newResponse.statusCode}');
    }
  } else {
    _hideLoadingDialog(context);
    _showFailedSnackBar(context, 'Gagal mengikuti redirection');
  }
}
}
