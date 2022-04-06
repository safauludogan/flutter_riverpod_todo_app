class CatFactModel {
  final String fact;
  final int length;

//<editor-fold desc="Data Methods">

  const CatFactModel({
    required this.fact,
    required this.length,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CatFactModel &&
          runtimeType == other.runtimeType &&
          fact == other.fact &&
          length == other.length);

  @override
  int get hashCode => fact.hashCode ^ length.hashCode;

  @override
  String toString() {
    return 'CatFactModel{' + ' fact: $fact,' + ' length: $length,' + '}';
  }

  CatFactModel copyWith({
    String? fact,
    int? length,
  }) {
    return CatFactModel(
      fact: fact ?? this.fact,
      length: length ?? this.length,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fact': this.fact,
      'length': this.length,
    };
  }

  factory CatFactModel.fromMap(Map<String, dynamic> map) {
    return CatFactModel(
      fact: map['fact'] as String,
      length: map['length'] as int,
    );
  }

//</editor-fold>
}