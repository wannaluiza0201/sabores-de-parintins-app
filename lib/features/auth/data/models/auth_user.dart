import 'dart:convert';

/// Usuário autenticado. Sem freezed: modelo simples, atualizado raramente.
///
/// `fromJson` é tolerante a:
/// - campos faltando (`avatar_url`, `created_at`)
/// - `created_at` em formatos ISO 8601 ou null
class AuthUser {
  const AuthUser({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
    this.createdAt,
  });

  final int id;
  final String name;
  final String email;
  final String? avatarUrl;
  final DateTime? createdAt;

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      id: json['id'] as int,
      name: (json['name'] as String?) ?? '',
      email: (json['email'] as String?) ?? '',
      avatarUrl: json['avatar_url'] as String?,
      createdAt: _parseDate(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'avatar_url': avatarUrl,
        'created_at': createdAt?.toIso8601String(),
      };

  /// Helper pra (de)serializar no SecureStorage como string única.
  String toJsonString() => jsonEncode(toJson());
  factory AuthUser.fromJsonString(String s) =>
      AuthUser.fromJson(jsonDecode(s) as Map<String, dynamic>);

  static DateTime? _parseDate(dynamic v) {
    if (v == null) return null;
    if (v is String && v.isEmpty) return null;
    return DateTime.tryParse(v.toString());
  }
}
