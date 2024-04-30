//import 'package:WEREHOUSE/dashboard/homepage/laporan_dashboard/service_model.dart';

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
  keterangan_laporan (
    name: "Barang",
    image: "gambar_laporan.png", // Memperbarui path gambar disini
    services: ["Laporan Barang"],
    distance: "",
  ),
  keterangan_laporan(
    name: "Penerimaan Logistik",
    image: "gambar_laporan.png", // Memperbarui path gambar disini
    services: ["Laporan Penerimaan Logistik"],
    distance: "",
  ),
  keterangan_laporan(
    name: "Pengeluaran Logistik",
    image: "gambar_laporan.png", // Memperbarui path gambar disini
    services: ["Laporan Pengeluaran Logistik"],
    distance: "",
  ),
  keterangan_laporan(
    name: "Rekab Kejadian",
    image: "gambar_laporan.png", // Memperbarui path gambar disini
    services: ["Laporan Kejadian Bencana"],
    distance: "",
  ),
];