import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaPerfil extends StatefulWidget {
  const TelaPerfil({super.key});

  @override
  State<TelaPerfil> createState() => _TelaPerfilState();
}

class _TelaPerfilState extends State<TelaPerfil> {
  String nome = '';
  int idade = 0;
  double peso = 0;
  double altura = 0;
  String genero = '';
  bool carregando = true;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      nome = prefs.getString('nome') ?? 'Sem nome';
      idade = prefs.getInt('idade') ?? 0;
      peso = prefs.getDouble('peso') ?? 0;
      altura = prefs.getDouble('altura') ?? 0;
      genero = prefs.getString('genero') ?? 'Não informado';
      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (carregando) {
      return const Scaffold(
        backgroundColor: Color(0xFF2D2D2D),
        body: Center(
          child: CircularProgressIndicator(
            color: Color(0xFFC60000),
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: const Color(0xFF2D2D2D),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        selectedItemColor: const Color(0xFFC60000),
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Tela Inicial',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
            child: Column(
          children: [
            const SizedBox(height: 32),
            Text(
              'Seja bem-vindo $nome!',
              style: GoogleFonts.brunoAce(color: Colors.white, fontSize: 15),
              textAlign: TextAlign.center
            ),
            const SizedBox(height: 40),
            Container(
                color: const Color.fromARGB(114, 72, 72, 72),
                height: 50,
                width: double.infinity,
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    Text(
                      'Suas informações pessoais',
                      style: GoogleFonts.brunoAce(
                          color: const Color(0XFFC60000), fontSize: 13),
                    ),
                    const SizedBox(width: 80),
                    IconButton(
                        onPressed: () {},
                        icon: Image.asset('assets/img/pencilSquare.png'))
                  ],
                )),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text('Nome: $nome',
                      style: GoogleFonts.brunoAce(
                          color: Colors.white, fontSize: 10)),
                  const SizedBox(height: 10),
                  Text('Idade: $idade',
                      style: GoogleFonts.brunoAce(
                          color: Colors.white, fontSize: 10)),
                  const SizedBox(height: 10),
                  Text('Peso: $peso kg',
                      style: GoogleFonts.brunoAce(
                          color: Colors.white, fontSize: 10)),
                  const SizedBox(height: 10),
                  Text('Altura: $altura m',
                      style: GoogleFonts.brunoAce(
                          color: Colors.white, fontSize: 10)),
                  const SizedBox(height: 10),
                  Text('Gênero: $genero',
                      style: GoogleFonts.brunoAce(
                          color: Colors.white, fontSize: 10)),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Container(
                color: const Color.fromARGB(114, 72, 72, 72),
                height: 50,
                width: double.infinity,
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    Text(
                      'Meta de hidratação',
                      style: GoogleFonts.brunoAce(
                          color: const Color(0XFFC60000), fontSize: 13),
                    ),
                    const SizedBox(width: 140),
                    IconButton(
                        onPressed: () {},
                        icon: Image.asset('assets/img/pencilSquare.png'))
                  ],
                )),
            Column(
              children: [
                const SizedBox(height: 30),
                Text('0/2000 ml',
                    style: GoogleFonts.brunoAce(
                        color: Colors.white, fontSize: 25)),
                const SizedBox(height: 15),
                Text('Se hidrate o suficiente para alcançar sua meta diária!',
                    style:
                        GoogleFonts.brunoAce(color: Colors.white, fontSize: 10),
                    textAlign: TextAlign.center),
              ],
            ),
            const SizedBox(height: 40),
            Container(
                color: const Color.fromARGB(114, 72, 72, 72),
                height: 50,
                width: double.infinity,
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    Text(
                      'Meta de macronutrientes',
                      style: GoogleFonts.brunoAce(
                          color: const Color(0XFFC60000), fontSize: 13),
                    ),
                    const SizedBox(width: 90),
                    IconButton(
                        onPressed: () {},
                        icon: Image.asset('assets/img/pencilSquare.png'))
                  ],
                )),
            Column(
              children: [
                const SizedBox(height: 20),
                Text('Calorias',
                    style: GoogleFonts.brunoAce(
                        color: Colors.white, fontSize: 12)),
                const SizedBox(height: 5),
                Text('0/1800',
                    style: GoogleFonts.brunoAce(
                        color: Colors.white, fontSize: 22)),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text('Carboidratos',
                            style: GoogleFonts.brunoAce(
                                color: Colors.white, fontSize: 10)),
                        const SizedBox(height: 5),
                        Text('0/200g',
                            style: GoogleFonts.brunoAce(
                                color: Colors.white, fontSize: 15)),
                      ],
                    ),
                    const SizedBox(width: 30),
                    Column(
                      children: [
                        Text('Proteínas',
                            style: GoogleFonts.brunoAce(
                                color: Colors.white, fontSize: 10)),
                        const SizedBox(height: 5),
                        Text('0/150g',
                            style: GoogleFonts.brunoAce(
                                color: Colors.white, fontSize: 15)),
                      ],
                    ),
                    const SizedBox(width: 30),
                    Column(
                      children: [
                        Text('Gorduras',
                            style: GoogleFonts.brunoAce(
                                color: Colors.white, fontSize: 10)),
                        const SizedBox(height: 5),
                        Text('0/60g',
                            style: GoogleFonts.brunoAce(
                                color: Colors.white, fontSize: 15)),
                      ],
                    )
                  ],
                )
              ],
            )
          ],
        )),
      ),
    );
  }
}
