import 'package:intl/intl.dart';

DateTime data = DateTime.now();
String dataFormatada = DateFormat('dd/MM/yyyy').format(data);

class Refeicao {
  int id;
  String nome;
  int calorias;
  DateTime data;

  Refeicao({
    required this.id,
    required this.nome,
    required this.calorias,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'calorias': calorias,
      'data': DateFormat('dd/MM/yyyy').format(data), // usa o atributo do objeto
    };
  }

  factory Refeicao.fromMap(Map<String, dynamic> map) {
    return Refeicao(
      id: map['id'],
      nome: map['nome'],
      calorias: map['calorias'],
      data: DateFormat('dd/MM/yyyy').parse(map['data']),
    );
  }
}
