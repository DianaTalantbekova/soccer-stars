class Player {
  final int id;
  final String name;
  final String lastName;
  final String asset;

//<editor-fold desc="Data Methods">

  const Player({
    required this.id,
    required this.name,
    required this.lastName,
    required this.asset,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Player &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          lastName == other.lastName &&
          asset == other.asset);

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ lastName.hashCode ^ asset.hashCode;

  @override
  String toString() {
    return 'Player{ id: $id, name: $name, fullName: $lastName, asset: $asset,}';
  }

  Player copyWith({
    int? id,
    String? name,
    String? fullName,
    String? asset,
  }) {
    return Player(
      id: id ?? this.id,
      name: name ?? this.name,
      lastName: fullName ?? this.lastName,
      asset: asset ?? this.asset,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'fullName': lastName,
      'asset': asset,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      id: map['id'] as int,
      name: map['name'] as String,
      lastName: map['fullName'] as String,
      asset: map['asset'] as String,
    );
  }

//</editor-fold>
}
