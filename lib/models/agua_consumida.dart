import 'package:intl/intl.dart';

DateTime data = DateTime.now();
String dataFormatada = DateFormat('dd/MM/yyyy').format(data);

class AguaConsumida {
  int? id;
  double quantidade;
  DateTime data;

  AguaConsumida({
    required this.id, 
    required this.quantidade, 
    required this.data}
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quantidade': quantidade,
      'data': DateFormat('dd/MM/yyyy').format(data),
    };
  }

  factory AguaConsumida.fromMap(Map<String, dynamic> map) {
    return AguaConsumida(
      id: map['id'],
      quantidade: map['quantidade'],
      data: DateFormat('dd/MM/yyyy').parse(map['data']),
    );
  }
}