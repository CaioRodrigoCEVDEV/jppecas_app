class Produto {
  final int procod;
  final String tipodes;
  final String marcasdes;
  final String prodes;
  final double provl;

  Produto({
    required this.procod,
    required this.tipodes,
    required this.marcasdes,
    required this.prodes,
    required this.provl,
  });

  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
      procod: json['procod'],
      tipodes: json['tipodes'],
      marcasdes: json['marcasdes'] ?? '',
      prodes: json['prodes'],
      provl: double.parse(json['provl'].toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'procod': procod,
      'tipodes': tipodes,
      'marcasdes': marcasdes,
      'prodes': prodes,
      'provl': provl,
    };
  }
}