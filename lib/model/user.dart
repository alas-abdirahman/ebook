class User {
  int? id; // SQLite databases use an integer as the primary key
  final String fullname;
  final String email;
  final String phone;
  final String address;
  final String username;
  final String password; // In a real app, you should never store passwords in plain text

  User({this.id, required this.fullname, required this.email, required this.phone, required this.address, required this.username, required this.password});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullname': fullname,
      'email': email,
      'phone': phone,
      'address': address,
      'username': username,
      'password': password, // Consider using a proper way to handle passwords
    };
  }
}
