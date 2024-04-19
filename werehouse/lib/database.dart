import 'package:mysql1/mysql1.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  late MySqlConnection _conn;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<void> initializeConnection() async {
    _conn = await _createConnection();
    print('Database connection successful');
    }

  static Future<MySqlConnection> _createConnection() async {
    final settings = ConnectionSettings(
      host: 'localhost',
      port: 3306,
      db: 'werehouse-bpbd',
      user: 'root',
      password: '',
    );

    return await MySqlConnection.connect(settings);
  }

  Future<bool> verifyLogin(String Email, String Password) async {
     try {
      await initializeConnection(); // Pastikan koneksi diinisialisasi sebelum verifikasi login

      await _conn.query('USE werehouse-bpbd');
      var results = await _conn.query(
        'SELECT * FROM akun WHERE Email = ? AND Password = ?',
        [Email, Password],
      );

      return results.isNotEmpty;
    } catch (e) {
      print('Error during login verification: $e');
      return false;
    }
  }
}

void main() async {
  DatabaseHelper db = DatabaseHelper();
  await db.initializeConnection(); // Pastikan koneksi diinisialisasi sebelum verifikasi login

  bool isValidLogin = await db.verifyLogin('user@example.com', 'password');

  if (isValidLogin) {
    print('Login Berhasil');
  } else {
    print('Email atau password salah');
  }
}