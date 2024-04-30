//import 'package:WEREHOUSE/dashboard/homepage/laporan_dashboard/service_model.dart';

class DoctorModel {
  String name;
  String image;
  List<String> services;
  String distance;

  DoctorModel({
    required this.name,
    required this.image,
    required this.services,
    required this.distance,
  });
}

var doctors = [
  DoctorModel (
    name: "Barang",
    image: "gambar_laporan.png", // Memperbarui path gambar disini
    services: ["Laporan Barang"],
    distance: "",
  ),
  DoctorModel(
    name: "Penerimaan Logistik",
    image: "gambar_laporan.png", // Memperbarui path gambar disini
    services: ["Laporan Penerimaan Logistik"],
    distance: "",
  ),
  DoctorModel(
    name: "Pengeluaran Logistik",
    image: "gambar_laporan.png", // Memperbarui path gambar disini
    services: ["Laporan Pengeluaran Logistik"],
    distance: "",
  ),
  DoctorModel(
    name: "Rekab Kejadian",
    image: "gambar_laporan.png", // Memperbarui path gambar disini
    services: ["Laporan Kejadian Bencana"],
    distance: "",
  ),
];