class pilih_fitur {
  static String vaccine = "Semua";
  static String Barang = "Barang";
  static String surgery = "Penerimaan Logistik";
  static String spaAndTreatment = "Pengeluaran Logistik";

  //details dari label
  // static String barang1 = "Laporan Barang";
  //static String logistik1 = "Laporan Penerimaan Logistik";
  //static String logistik2 = "Laporan Pengelaran Logistik";
  static List<String> all() {
    return [vaccine, Barang, surgery, spaAndTreatment];
  }
}