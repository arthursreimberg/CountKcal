import 'package:flutter_countkcal/models/usuario.dart';
import 'package:flutter_countkcal/db/banco.dart';

Future<int> cadastrarUsu(Usuario usuario) async{
  //Conexão com o banco de dados
  final db = await DatabaseHelper.instance.database;

   // Validação básica
  if (usuario.nome.isEmpty && usuario.idade <= 0 && usuario.altura <= 0 && usuario.sexo.isEmpty && usuario.peso <= 0) {
    throw Exception("Dados do usuário inválidos");
  }
  return await db.insert(
    'usuario',
    {
      'nome': usuario.nome,
      'idade': usuario.idade,
      'altura': usuario.altura,
      'sexo': usuario.sexo,
      'peso': usuario.peso,
      'objetivo': usuario.objetivo,
      'caloriasDiarias': usuario.caloriasDiarias,
      'aguaDiaria': usuario.aguaDiaria,
    },

  );
}