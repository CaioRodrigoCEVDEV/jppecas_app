class Marca {
  final int marcascod;
  final String marcasdes;

  Marca({required this.marcascod, required this.marcasdes});

  factory Marca.fromJson(Map<String, dynamic> json) {
    return Marca(
      marcascod: json['marcascod'],
      marcasdes: json['marcasdes'] ?? '',
    );
  }
}
