import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class pilih_fitur {
  static String vaccine = "Semua";
  static String surgery = "Logistik Masuk";
  static String spaAndTreatment = "Logistik Keluar";

  static List<String> all() {
    return [vaccine, surgery, spaAndTreatment];
  }
}

class keterangan_laporan {
  String name;
  String image;
  List<String> services;
  String distance;

  keterangan_laporan({
    required this.name,
    required this.image,
    required this.services,
    required this.distance,
  });
}

var doctors = [
  keterangan_laporan(
    name: "Logistik Masuk",
    image: "gambar_laporan.png", // Memperbarui path gambar disini
    services: ["Laporan Logistik Masuk"],
    distance: "",
  ),
  keterangan_laporan(
    name: "Logistik Keluar",
    image: "gambar_laporan.png", // Memperbarui path gambar disini
    services: ["Laporan Logistik Keluar"],
    distance: "",
  ),
  keterangan_laporan(
    name: "Logistik Keluar",
    image: "gambar_laporan.png", // Memperbarui path gambar disini
    services: ["Laporan Logistik Keluar"],
    distance: "",
  ),
];

class fitur_laporan extends StatefulWidget {
  fitur_laporan({super.key});

  @override
  _fitur_laporanState createState() => _fitur_laporanState();
}

class _fitur_laporanState extends State<fitur_laporan> {
  int selectedService = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cetak Laporan'),
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
                    const SizedBox(
                      height: 30,
                    ),
                    _card(),
                    const SizedBox(
                      height: 20,
                    ),
                    _services(),
                    const SizedBox(
                      height: 27,
                    ),
                    _doctors()
                  ],
                ),
              ))),
    );
  }

  Widget _doctors() {
    List<keterangan_laporan> filteredDoctors;
    if (selectedService == 0) {
      filteredDoctors = doctors;
    } else if (selectedService == 1) {
      filteredDoctors = doctors
          .where((doctor) => doctor.name == "Logistik Masuk")
          .toList();
    } else {
      filteredDoctors = doctors
          .where((doctor) => doctor.name == "Logistik Keluar")
          .toList();
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 1000),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: ListView.separated(
          key: ValueKey<int>(selectedService),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => _doctor(filteredDoctors[index]),
          separatorBuilder: (context, index) => const SizedBox(
                height: 11,
              ),
          itemCount: filteredDoctors.length),
    );
  }

  Container _doctor(keterangan_laporan keterangan_laporan) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
                color: const Color(0xFF35385A).withOpacity(.12),
                blurRadius: 30,
                offset: const Offset(0, 2))
          ]),
      child: Row(children: [
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: Image.asset(
            'assets/images/${keterangan_laporan.image}',
            width: 88,
            height: 103,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Flexible(
          fit: FlexFit.tight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                keterangan_laporan.name,
                style: GoogleFonts.manrope(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF3F3E3F)),
              ),
              const SizedBox(
                height: 7,
              ),
              RichText(
                  text: TextSpan(
                      text:
                          "Terkait: ${keterangan_laporan.services.join(', ')}",
                      style: GoogleFonts.manrope(
                          fontSize: 12, color: Colors.black))),
              const SizedBox(
                height: 7,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 7,
                  ),
                  Text("${keterangan_laporan.distance}Lihat Lebih Detail",
                      style: GoogleFonts.manrope(
                        fontSize: 12,
                        color: const Color(0xFFACA3A3),
                      ))
                ],
              ),
              const SizedBox(
                height: 7,
              ),
              Row(
                children: [
                  Text(
                    "Selanjutnya >",
                    style: GoogleFonts.manrope(
                        color: const Color(0xFF50CC98),
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        )
      ]),
    );
  }

  SizedBox _services() {
    return SizedBox(
      height: 36,
      child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  setState(() {
                    selectedService = index;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: selectedService == index
                          ? const Color(0xFF818AF9)
                          : const Color(0xFFF6F6F6),
                      border: selectedService == index
                          ? Border.all(
                              color: const Color(0xFFF1E5E5).withOpacity(.22),
                              width: 2)
                          : null,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Text(
                    pilih_fitur.all()[index],
                    style: GoogleFonts.manrope(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: selectedService == index
                            ? Colors.white
                            : const Color(0xFF3F3E3F).withOpacity(.3)),
                  )),
                ),
              ),
          separatorBuilder: (context, index) => const SizedBox(
                width: 10,
              ),
          itemCount: pilih_fitur.all().length),
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
        child: Stack(children: [
          Image.asset(
            'assets/images/gambar_fitur_laporan.png',
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
                        text: "Hi, ",
                        style: GoogleFonts.manrope(
                            fontSize: 14,
                            color: Color.fromARGB(255, 255, 255, 255),
                            height: 150 / 100),
                        children: const [
                      TextSpan(
                          text: "Apakah ",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800)),
                      TextSpan(
                          text:
                              "Anda Tertarik Untuk\n Melihat Fitur Laporan \n Lainnya.. ?",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800)),
                    ])),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.4),
                      border: Border.all(
                          color: Colors.white.withOpacity(.12), width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "Selanjutnya >",
                    style: GoogleFonts.manrope(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }

  
}
