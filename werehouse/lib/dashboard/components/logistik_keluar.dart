import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:werehouse/dashboard/components/logistik_keluar_lanjutan.dart';
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
    // Add debug print statements to inspect the JSON data
    print('Parsing Logistik from JSON: $json');

    // Adjust the fields to correctly reflect the types in the JSON response
    return Logistik(
      id: json['id'],
      namaLogistik: json['id_logistik']?.toString() ?? '',
      jumlahLogistikMasuk: json['jumlah_logistik_masuk'] ?? 0,
    );
  }
}

class _barang_keluarState extends State<barang_keluar> {
  final TextEditingController _namaLogistikController = TextEditingController();
  final TextEditingController _jumlahController = TextEditingController();
  final TextEditingController _ListBarang = TextEditingController();
  String userName = '';
  String userEmail = '';
  List<Map<String, dynamic>> selectedItems = [];
  List<Logistik> listLogistik = [];
  List<String> DaftarLogistik = [];

  @override
  void initState() {
    super.initState();
    _loadUserName();

    fetchLogistik().then((logistik) {
      setState(() {
        listLogistik = logistik;
        DaftarLogistik =    logistik.map((logistik) => logistik.namaLogistik).toList();
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

  List<Barang> listBarang = [];

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
                      SizedBox(height: 10),
                      _FieldListBarang(
                        hintText: '',
                        label: 'List Barang :',
                        controller: _ListBarang,
                        onTap: () {},
                        onButtonTaps: () {},
                        listBarang: listBarang,
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

  Future<List<Logistik>> fetchLogistik() async {
    try {
      final response = await http.get(Uri.parse('${Global.baseUrl}${Global.getInLogistikMasuk}'));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse == null || jsonResponse['data'] == null) {
          throw Exception('Invalid response format: ${response.body}');
        }

        final List<dynamic> jsonData = jsonResponse['data'];
        print('Logistik Response: $jsonData');

        List<Logistik> daftarLogistik = jsonData.map((item) => Logistik.fromJson(item)).toList();
        return daftarLogistik;
      } else {
        throw Exception('Gagal memuat data logistik: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Gagal memuat data logistik: $e');
    }
  }
  

  void _tambahBarang() {
  if (_namaLogistikController.text.isEmpty || _jumlahController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Lengkapi kolom terlebih dahulu'),
      ),
    );
    return;
  }

  int jumlahLogistikMasuk = listLogistik
      .firstWhere((logistik) => logistik.namaLogistik == _namaLogistikController.text, orElse: () => Logistik(id: 0, namaLogistik: '', jumlahLogistikMasuk: 0))
      .jumlahLogistikMasuk;

  int jumlahBarang = int.parse(_jumlahController.text);

  if (jumlahBarang > jumlahLogistikMasuk) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Jumlah barang melebihi stok yang tersedia (${jumlahLogistikMasuk})'),
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
                SizedBox(height: 10), // Add spacing between items
              ],
            );
          },
        ),
        SizedBox(height: 20),
        // Menambahkan tombol di bawah field
        _inkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => lanjutan()),
            );
          },
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
                  'Lanjutkan Pengisian Data',
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
                    leading: new Icon(Icons.arrow_back_ios),
                    title: new Text(
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
                              filteredDaftarLogistik[index].split(':')[0].trim();
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



  void main() {
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: barang_keluar(),
    ));
  }
}
