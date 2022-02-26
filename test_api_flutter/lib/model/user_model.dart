class UserModel {

  int? userId;
  int? id;
  String? body;
  String? title;

  UserModel({this.body, this.id, this.title, this.userId});

  factory UserModel.fromJson(Map? json) => UserModel(
    userId: json?["userId"],
    id: json?["id"],
    body: json?["body"],
    title: json?["title"]
  );


}