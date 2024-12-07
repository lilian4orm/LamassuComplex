class UserModel {
  Results results;
  bool error;

  UserModel({
    required this.results,
    required this.error,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      results: Results.fromJson(json['results']),
      error: json['error'],
    );
  }
}

class Results {
  String token;
  String id;
  String name;
  String email;
  String phone;
  String type;
  String centerId;

  Results({
    required this.token,
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.type,
    required this.centerId,
  });

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      token: json['token'],
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      type: json['type'],
      centerId: json['center_id'],
    );
  }
}
