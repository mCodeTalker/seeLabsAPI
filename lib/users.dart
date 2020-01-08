import 'dart:convert';

class User {
  int aid;
  String name;
  int pid;

  User({this.aid = 0, this.name, this.pid});

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
        aid: map["asisten_id"], name: map["asisten_fullname"], pid: map["asisten_pid"]);
  }

  Map<String, dynamic> toJson() {
    return {"asisten_id": aid, "asisten_fullname": name, "asisten_pid": pid};
  }

  @override
  String toString() {
    return 'User{id: $aid, name: $name, pid: $pid}';
  }

}

List<User> userFromJson(String jsonData){
  final data = json.decode(jsonData);
  return List<User>.from(data['values'].map((item) => User.fromJson(item)));
}

String userToJson(User data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}