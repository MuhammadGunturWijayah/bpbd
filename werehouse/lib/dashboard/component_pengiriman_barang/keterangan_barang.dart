//import 'package:WEREHOUSE/dashboard/homepage/laporan_dashboard/service_model.dart';

class keterangan_laporan {
  String name;
  String image;
  List<String> keterangan;
  String distance;

  keterangan_laporan({
    required this.name,
    required this.image,
    required this.keterangan,
    required this.distance,
  });
}

var doctors = [
  keterangan_laporan(
    name: "Ihsannudin", 
    image: "pengiriman_barang.png", // Memperbarui path gambar disini
    keterangan: ["Laporan Barang"],
    distance: "",
  ),
  keterangan_laporan(
    name: "Penerimaan Logistik",
    image: "pengiriman_barang.png", // Memperbarui path gambar disini
    keterangan: ["Laporan Penerimaan Logistik"],
    distance: "",
  ),
  keterangan_laporan(
    name: "Pengeluaran Logistik",
    image: "pengiriman_barang.png", // Memperbarui path gambar disini
    keterangan: ["Laporan Pengeluaran Logistik"],
    distance: "",
  ),
  keterangan_laporan(
    name: "Rekab Kejadian",
    image: "pengiriman_barang.png", // Memperbarui path gambar disini
    keterangan: ["Laporan Kejadian Bencana"],
    distance: "",
  ),
];