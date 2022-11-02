class Character {
  final int id;
  final String char;
  final bool fromHint;

//<editor-fold desc="Data Methods">

  factory Character.empty() => const Character(
        id: -1,
        char: "",
        fromHint: false,
      );

  const Character({
    required this.id,
    required this.char,
    required this.fromHint,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Character &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          char == other.char &&
          fromHint == other.fromHint);

  @override
  int get hashCode => id.hashCode ^ char.hashCode ^ fromHint.hashCode;

  @override
  String toString() {
    return 'Character{ id: $id, char: $char, fromHint: $fromHint,}';
  }

  Character copyWith({
    int? id,
    String? char,
    bool? fromHint,
  }) {
    return Character(
      id: id ?? this.id,
      char: char ?? this.char,
      fromHint: fromHint ?? this.fromHint,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'char': char,
      'fromHint': fromHint,
    };
  }

  factory Character.fromMap(Map<String, dynamic> map) {
    return Character(
      id: map['id'] as int,
      char: map['char'] as String,
      fromHint: map['fromHint'] as bool,
    );
  }

//</editor-fold>
}
