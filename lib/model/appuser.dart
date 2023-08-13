class AppUser {
  final int userId;
  final String name;

  AppUser({required this.userId, required this.name});

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(userId: json['userId'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppUser &&
          runtimeType == other.runtimeType &&
          userId == other.userId;

  @override
  int get hashCode => userId.hashCode;

  @override
  String toString() {
    return 'AppUser: {userId: $userId, name: $name}';
  }
}
