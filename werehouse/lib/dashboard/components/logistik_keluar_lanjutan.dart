//   Future<List<Logistik>> fetchLogistik() async {
//   try {
//     final response = await http.get(Uri.parse('${Global.baseUrl}${Global.getInLogistikMasuk}'));

//     if (response.statusCode == 200) {
//       final jsonResponse = jsonDecode(response.body);

//       if (jsonResponse == null || jsonResponse['data'] == null) {
//         throw Exception('Invalid response format: ${response.body}');
//       }

//       final List<dynamic> jsonData = jsonResponse['data'];
//       print('Logistik Response: $jsonData');

//       List<Logistik> daftarLogistik = jsonData.map((item) => Logistik.fromJson(item)).toList();
//       return daftarLogistik;
//     } else {
//       throw Exception('Gagal memuat data logistik: ${response.statusCode}');
//     }
//   } catch (e) {
//     throw Exception('Gagal memuat data logistik: $e');
//   }
// }


//opsi 2

// Future<List<Logistik>> fetchLogistik() async {
//   try {
//     // Mengambil data logistik masuk
//     final responseIn = await http.get(Uri.parse('${Global.baseUrl}${Global.getInLogistikMasuk}'));
//     print('ResponseIn status: ${responseIn.statusCode}');
//     print('ResponseIn body: ${responseIn.body}');

//     if (responseIn.statusCode == 200) {
//       final jsonResponseIn = jsonDecode(responseIn.body);
//       final List<dynamic> jsonDataIn = jsonResponseIn['data'];
//       print('jsonDataIn: $jsonDataIn');
      
//       // Mengambil data logistik
//       final responseLogistik = await http.get(Uri.parse('${Global.baseUrl}${Global.getLogistikMasuk}'));
//       print('ResponseLogistik status: ${responseLogistik.statusCode}');
//       print('ResponseLogistik body: ${responseLogistik.body}');

//       if (responseLogistik.statusCode == 200) {
//         final jsonResponseLogistik = jsonDecode(responseLogistik.body);
//         final List<dynamic> jsonDataLogistik = jsonResponseLogistik['data'];
//         print('jsonDataLogistik: $jsonDataLogistik');

//         // Membuat peta dari id_logistik ke nama_logistik
//         final logistikMap = {for (var item in jsonDataLogistik) item['id_logistik']: item['nama_logistik']};
//         print('logistikMap: $logistikMap');

//         // Memetakan data ke objek Logistik
//         List<Logistik> daftarLogistik = jsonDataIn.map((item) {
//           final idLogistik = item['id_logistik'];
//           final namaLogistik = logistikMap[idLogistik] ?? '';
//           print('Mapping id_logistik $idLogistik to nama_logistik $namaLogistik');
//           return Logistik(
//             id: item['id'],
//             namaLogistik: namaLogistik,
//             jumlahLogistikMasuk: item['jumlah_logistik_masuk'] ?? 0,
//           );
//         }).toList();

//         print('daftarLogistik: $daftarLogistik');
//         return daftarLogistik;
//       } else {
//         throw Exception('Gagal memuat data logistik: ${responseLogistik.statusCode}');
//       }
//     } else {
//       throw Exception('Gagal memuat data logistik masuk: ${responseIn.statusCode}');
//     }
//   } catch (e) {
//     print('Exception: $e');
//     throw Exception('Gagal memuat data logistik: $e');
//   }
// }


