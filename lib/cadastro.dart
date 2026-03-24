import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_countkcal/services/cadastro_usu.dart';
import 'package:flutter_countkcal/models/usuario.dart';

class TelaCadastro extends StatefulWidget  {
  const TelaCadastro({super.key});
  

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  bool bool1 = false;
  bool bool2 = false;
  Usuario usuario =  Usuario(nome: '', idade: 0, altura: 0, sexo: '', peso: 0);

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
                child: Column(
                  mainAxisSize: MainAxisSize.min, 
                  crossAxisAlignment: CrossAxisAlignment.stretch, 
                  children: [
                    // Logo / Imagem
                    Image.asset(
                      'assets/img/countKcal.png',
                      height: 110, // tamanho da imagem
                    ),

                    const SizedBox(height: 48), // espaçamento maior após logo

                    // CAMPO NOME
                    TextFormField(
                      style: GoogleFonts.brunoAce(color: Colors.white),
                      decoration: _inputDecoration('Digite seu Nome'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Por favor, digite seu nome';
                        }
                        usuario.nome = value.trim();
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    // CAMPO PESO
                    TextFormField(
                      style: GoogleFonts.brunoAce(color: Colors.white),
                      decoration: _inputDecoration('Digite seu peso (kg)'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Por favor, digite seu peso';
                        }
                        else{
                          usuario.peso = double.parse(value);
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    // CAMPO ALTURA
                    TextFormField(
                      style: GoogleFonts.brunoAce(color: Colors.white),
                      decoration: _inputDecoration('Digite sua Altura (m)'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Por favor, digite sua altura';
                        }
                        else{
                          usuario.altura = double.parse(value); 
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 40),
                    Text('Gênero', style: GoogleFonts.brunoAce(color: Colors.red, fontSize: 16)),
                    // CHECKBOX MASCULINO
                    CheckboxListTile(
                      title: Text("Masculino", style: GoogleFonts.brunoAce(color: Colors.white, fontSize: 14)),
                      value: bool1,
                      onChanged: (bool? novoValor) {
                        setState(() {
                          if(bool2 == true){
                            bool2 = false;
                            usuario.sexo = '';
                          }
                          bool1 = novoValor!;
                          usuario.sexo = 'Masculino';
                        });
                      },
                    ),
                    // CHECKBOX FEMININO
                    CheckboxListTile(
                      title: Text("Feminino", style: GoogleFonts.brunoAce(color: Colors.white, fontSize: 14)),
                      value: bool2,
                      onChanged: (bool? novoValor) {
                        setState(() {
                          if(bool1 == true){
                            bool1 = false;
                            usuario.sexo = '';
                          }
                          bool2 = novoValor!;
                          usuario.sexo = 'Feminino';
                        });
                      },
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        //cadastrarUsu(usuario);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TelaCadastro(),  // ← substitua pelo nome da sua tela
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 60),
                        backgroundColor: const Color.fromARGB(255, 139, 32, 32), // fundo escuro
                        foregroundColor: Colors.white,
                        elevation: 0, // tira sombra se não quiser
                        side: const BorderSide(
                          // borda vermelha
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
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey[600]!, 
          width: 1.0,
        ),
      ),
    );
  }
}