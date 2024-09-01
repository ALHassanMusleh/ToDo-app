class AppUser {
  late String id;
  late String name;
  late String email;
  static const String collectionName = 'users';
  static AppUser? currentUser;

  AppUser({
    required this.id,
    required this.name,
    required this.email,
  });

  AppUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
  }

  // Method to convert the instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
