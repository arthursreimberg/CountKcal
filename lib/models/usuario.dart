class Usuario {
  int? id;
  String nome;
  int idade;
  double altura;
  String sexo;
  double peso;
  String? objetivo;
  int? caloriasDiarias;
  double? aguaDiaria;

  Usuario({
    this.id,
    required this.nome,
    required this.idade,
    required this.altura,
    required this.sexo,
    required this.peso,
    this.objetivo,
    this.caloriasDiarias,
    this.aguaDiaria,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'idade': idade,
      'altura': altura,
      'sexo': sexo,
      'peso': peso,
      'objetivo': objetivo,
      'caloriasDiarias': caloriasDiarias,
      'aguaDiaria': aguaDiaria,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      id: map['id'],
      nome: map['nome'],
      idade: map['idade'],
      altura: map['altura'],
      sexo: map['sexo'],
      peso: map['peso'],
      objetivo: map['objetivo'],
      caloriasDiarias: map['caloriasDiarias'],
      aguaDiaria: map['aguaDiaria'],
    );
  }
}
