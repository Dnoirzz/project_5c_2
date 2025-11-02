class UserModel {
  final int idPengguna;
  final String email;
  final String password;
  final String namaLengkap;
  final String role;

  UserModel({
    required this.idPengguna,
    required this.email,
    required this.password,
    required this.namaLengkap,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      idPengguna: int.parse(json['id_pengguna'].toString()),
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      namaLengkap: json['nama_lengkap'] ?? '',
      role: json['role'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_pengguna': idPengguna,
      'email': email,
      'password': password,
      'nama_lengkap': namaLengkap,
      'role': role,
    };
  }
}
