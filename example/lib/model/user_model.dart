// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  String? email;
  String? pasword;
  UserModel({this.email, this.pasword});

  UserModel copyWith({String? email, String? pasword}) {
    return UserModel(
      email: email ?? this.email,
      pasword: pasword ?? this.pasword,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'email': email, 'pasword': pasword};
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] != null ? map['email'] as String : null,
      pasword: map['pasword'] != null ? map['pasword'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserModel(email: $email, pasword: $pasword)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.email == email && other.pasword == pasword;
  }

  @override
  int get hashCode => email.hashCode ^ pasword.hashCode;
}
