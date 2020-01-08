import 'dart:convert';

class Anggota {
  int uid,kid ;
  bool presensi;
  String fn; 
  Anggota({this.uid = 0, this.kid= 0, this.fn, this.presensi});
  Anggota.aNilai({this.uid=0, this.fn});
  factory Anggota.fromJson(Map<String, dynamic> map) {
    bool absen;
    if(map["presensi"]==null){
       absen=false;
    }else if(map["presensi"]=='0'){
       absen=false;
    }
    else{
       absen=true;
    }
    //print(absen);
    return Anggota(
        uid: map["uid"], fn: map["user_fullname"], kid: map["kelompok"], presensi: absen);
  }
  factory Anggota.afromJson(Map<String, dynamic> map){
    return Anggota.aNilai(uid: map["uid"], fn: map["user_fullname"]);
  }

}

List<Anggota> anggotaFromJson(String jsonData){
  final data = json.decode(jsonData);
  return List<Anggota>.from(data['values'].map((item) => Anggota.fromJson(item)));
}
List<Anggota> aNilaiFromJson(String jsonData){
  final data = json.decode(jsonData);
  return List<Anggota>.from(data['values'].map((item) => Anggota.afromJson(item)));
}

// String userToJson(Kelompok data) {
//   final jsonData = data.toJson();
//   return json.encode(jsonData);
// }