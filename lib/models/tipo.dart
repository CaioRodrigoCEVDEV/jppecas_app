class Tipo {
  final int tipocod;
  final String tipodes;
  final int promarcascod;
  final int promodcod;

  Tipo({
    required this.tipocod,
    required this.tipodes,
    required this.promarcascod,
    required this.promodcod,
  });

  factory Tipo.fromJson(Map<String, dynamic> json) {
    return Tipo(
      tipocod: json['tipocod'],
      tipodes: json['tipodes'] ?? '',
      promarcascod: json['promarcascod'] ?? 0,
      promodcod: json['promodcod'] ?? 0,
    );
  }
}
