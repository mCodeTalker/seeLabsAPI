import 'dart:convert';

class Kelompok {
  int id;
  String fn;
  String uid;
  Kelompok({this.id = 0});
  factory Kelompok.fromJson(Map<String, dynamic> map) {
    return Kelompok(
        id: map["kid"]);
  }

}

List<Kelompok> kelompokFromJson(String jsonData){
  final data = json.decode(jsonData);
  return List<Kelompok>.from(data['values'].map((item) => Kelompok.fromJson(item)));
}

// String userToJson(Kelompok data) {
//   final jsonData = data.toJson();
//   return json.encode(jsonData);
// }