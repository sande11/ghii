class Repository {
  final int id;
  final String fullname;
  final bool private;
  final String login;
  final String avatarUrl;
  final String type;
  final String? description;

  Repository({
    required this.id,
    required this.fullname,
    required this.private,
    required this.login,
    required this.avatarUrl,
    required this.type,
    this.description,
  });

  factory Repository.fromJson(Map<String, dynamic> json) {
    return Repository(
      id: json['id'],
      fullname: json['full_name'],
      private: json['private'],
      login: json['owner']['login'],
      avatarUrl: json['owner']['avatar_url'],
      type: json['owner']['type'],
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullname': fullname,
      'private': private ? 1 : 0,
      'login': login,
      'avatar_url': avatarUrl,
      'type': type,
      'description': description ?? '',
    };
  }

  factory Repository.fromMap(Map<String, dynamic> map) {
    return Repository(
      id: map['id'],
      fullname: map['fullname'],
      private: map['private'] == 1,
      login: map['login'],
      avatarUrl: map['avatar_url'],
      type: map['type'],
      description: map['description'],
    );
  }

  get isPrivate => null;
}
