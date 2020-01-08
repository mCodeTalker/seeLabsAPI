import 'package:seelabs/main.dart';
import 'package:seelabs/users.dart';
import 'package:http/http.dart' show Client;
import 'package:seelabs/kelompok.dart';
import 'package:seelabs/anggota.dart';

class SeeLabsAPI {
  final String baseURL = "http://10.251.251.151:443";
  Client client = Client();

  Future<List<User>> reqLogin(String nim, String pass) async {
    final response = await client
        .post("$baseURL/login", body: {'nim': '$nim', 'pass': '$pass'});
    if (response.statusCode == 200) {
      return userFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<List<Kelompok>> reqKelompok(int hari) async {
    final response = await client.get("$baseURL/praktikum/$pid/hari/$hari");
    if (response.statusCode == 200) {
      return kelompokFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<List<Anggota>> reqAnggota(int kid) async {
    final response =
        await client.get("$baseURL/praktikum/$pid/kelompok/$kid/modul$modul");
    if (response.statusCode == 200) {
      return anggotaFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<List<Kelompok>> reqNilai() async {
    final response =
        await client.get("$baseURL/nilai/$modul/aid/$aid/pid/$pid");
    if (response.statusCode == 200) {
      return kelompokFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<List<Anggota>> reqANilai(int kid) async {
    final response =
        await client.get("$baseURL/nilai/$modul/aid/$aid/pid/$pid/kid/$kid");
    if (response.statusCode == 200) {
      return aNilaiFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<bool> updateNilai(int uid, int k1, int k2, int k3) async {
    final response =
        await client.put("$baseURL/nilai/$modul", body: {'uid': '$uid','aid': '$aid', 'pid': '$pid', 'k1': '$k1', 'k2': '$k2', 'k3': '$k3'});
    if (response.statusCode == 200) {
      return true;
    } else {
      return null;
    }
  }

  Future<bool> addAbsen(int kid, int uid, int modul, int presensi) async {
    final response = await client.post("$baseURL/praktikum/$pid/kelompok/$kid",
        body: {
          'uid': '$uid',
          'aid': '$aid',
          'presensi': '$presensi',
          'modul': '$modul'
        });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> editAbsen(int kid, int uid, int modul, int presensi) async {
    final response = await client.put("$baseURL/praktikum/$pid/kelompok/$kid",
        body: {
          'uid': '$uid',
          'aid': '$aid',
          'presensi': '$presensi',
          'modul': '$modul'
        });
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 304) {
      addAbsen(kid, uid, modul, presensi);
    } else {
      return false;
    }
  }
}
