class Modelo {
  final int modcod;
  final String moddes;
  final int modmarcascod;

  Modelo({
    required this.modcod,
    required this.moddes,
    required this.modmarcascod,
  });

  factory Modelo.fromJson(Map<String, dynamic> json) {
    return Modelo(
      modcod: json['modcod'],
      moddes: json['moddes'] ?? '',
      modmarcascod: json['modmarcascod'] ?? json['marcascod'] ?? 0,
    );
  }
}
