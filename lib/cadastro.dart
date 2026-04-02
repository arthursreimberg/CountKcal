import 'package:flutter/material.dart';
import 'package:flutter_countkcal/perfil.dart';
import 'package:flutter_countkcal/services/cadastro_usu.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_countkcal/models/usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final _formKey = GlobalKey<FormState>();

  bool bool1 = false;
  bool bool2 = false;

  Usuario usuario = Usuario(
    nome: '',
    idade: 0,
    altura: 0,
    sexo: '',
    peso: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D2D2D),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Form(
                key: _formKey, // ✅ IMPORTANTE
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      'assets/img/countKcal.png',
                      height: 110,
                    ),

                    const SizedBox(height: 48),

                    // NOME
                    TextFormField(
                      style: GoogleFonts.brunoAce(color: Colors.white),
                      decoration: _inputDecoration('Digite seu Nome'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Digite seu nome';
                        }
                        usuario.nome = value.trim();
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    // IDADE
                    TextFormField(
                      style: GoogleFonts.brunoAce(color: Colors.white),
                      decoration: _inputDecoration('Digite sua Idade'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Digite sua idade';
                        }

                        usuario.idade = int.tryParse(value) ?? 0;

                        if (usuario.idade <= 0) {
                          return 'Idade inválida';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    // PESO
                    TextFormField(
                      style: GoogleFonts.brunoAce(color: Colors.white),
                      decoration: _inputDecoration('Digite seu peso (kg)'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Digite seu peso';
                        }
                        usuario.peso = double.tryParse(value.replaceAll(',', '.'),) ?? 0;
                        if (usuario.peso <= 0) {
                          return 'Peso inválido';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    // ALTURA
                    TextFormField(
                      style: GoogleFonts.brunoAce(color: Colors.white),
                      decoration: _inputDecoration('Digite sua Altura (m)'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Digite sua altura';
                        }
                        usuario.altura = double.tryParse(value.replaceAll(',', '.'),) ?? 0;
                        if (usuario.altura <= 0) {
                          return 'Altura inválida';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 40),

                    Text(
                      'Gênero',
                      style: GoogleFonts.brunoAce(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),

                    CheckboxListTile(
                      title: Text("Masculino",
                          style: GoogleFonts.brunoAce(
                              color: Colors.white, fontSize: 14)),
                      value: bool1,
                      onChanged: (bool? value) {
                        setState(() {
                          bool1 = value!;
                          bool2 = false;
                          usuario.sexo = 'Masculino';
                        });
                      },
                    ),

                    CheckboxListTile(
                      title: Text("Feminino",
                          style: GoogleFonts.brunoAce(
                              color: Colors.white, fontSize: 14)),
                      value: bool2,
                      onChanged: (bool? value) {
                        setState(() {
                          bool2 = value!;
                          bool1 = false;
                          usuario.sexo = 'Feminino';
                        });
                      },
                    ),

                    const SizedBox(height: 40),

                    ElevatedButton(
                      onPressed: () async {
                        if (!_formKey.currentState!.validate()) return;

                        if (usuario.sexo.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Selecione um gênero'),
                            ),
                          );
                          return;
                        }

                        try {
                          await cadastrarUsu(usuario); // 👈 SALVA NO BANCO

                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setBool('usuarioCadastrado', true);

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TelaPerfil(),
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Erro ao cadastrar: $e'),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 60),
                        backgroundColor:
                            const Color.fromARGB(255, 139, 32, 32),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        side: const BorderSide(
                          color: Colors.red,
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 14,
                        ),
                        textStyle: GoogleFonts.brunoAce(
                          fontSize: 16,
                        ),
                      ),
                      child: const Text('Cadastrar'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: GoogleFonts.brunoAce(
        color: const Color(0xFFC60000),
        fontSize: 14,
      ),
      border: const OutlineInputBorder(),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xFFC60000),
          width: 2.0,
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
    );
  }
}