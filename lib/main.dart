import 'package:flutter/material.dart';
import 'package:flutter_countkcal/perfil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'cadastro.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  if (!kIsWeb) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    verificarPrimeiraVez();
  }

  void verificarPrimeiraVez() async {
  final prefs = await SharedPreferences.getInstance();

  bool jaViuIntro = prefs.getBool('jaViuIntro') ?? false;
  bool usuarioCadastrado = prefs.getBool('usuarioCadastrado') ?? false;

  await Future.delayed(const Duration(seconds: 2));

  if (!jaViuIntro) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  } else if (!usuarioCadastrado) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => TelaCadastro()),
    );
  } else {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => TelaPerfil()),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D2D2D),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, // importante
          children: [
            Image.asset('assets/img/countKcal.png'),
            const SizedBox(height: 6), // espaço bem pequeno
            const CircularProgressIndicator(
              color: Color(0xFFC60000),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> images = [
    'assets/img/foodImg.jpg',
    'assets/img/mealImg.jpg',
    'assets/img/foodImg.jpg',
  ];

  List<String> texts = [
    'Com o CountKcal, identifique qual é a melhor meta calórica para o seu objetivo!',
    'Calcule a quantidade de calorias, proteinas, carboidratos e gordura sua refeição possui.',
    'Identifique a quantidade ideal de água para garantir sua hidratação diária.',
  ];

  int i = 0;

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF2D2D2D),
        body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 600),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: Image.asset(
                images[i],
                key: ValueKey(i), // MUITO IMPORTANTE
                width: 600,
              ),
            ),
            const SizedBox(height: 16),
            Container(
                height: 50,
                color: Color(0xFF2E2C2C),
                child: SizedBox(
                  width: 350,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    child: Text(
                      texts[i],
                      key: ValueKey(i),
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.brunoAce(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )),
            Container(
              height: 50,
              width: 600,
              color: const Color(0xFF3A3838),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (i >= 1) {
                          i--;
                        }
                      });
                    },
                    icon: const Icon(Icons.chevron_left),
                    color: Colors.white,
                  ),
                  Row(
                    children: [
                      Icon(i == 0 ? Icons.circle : Icons.circle_outlined,
                          size: 10, color: i == 0 ? Colors.red : Colors.white),
                      const SizedBox(width: 6),
                      Icon(i == 1 ? Icons.circle : Icons.circle_outlined,
                          size: 10, color: i == 1 ? Colors.red : Colors.white),
                      const SizedBox(width: 6),
                      Icon(i == 2 ? Icons.circle : Icons.circle_outlined,
                          size: 10, color: i == 2 ? Colors.red : Colors.white),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (i < images.length - 1) {
                          i++;
                        }
                      });
                    },
                    icon: const Icon(Icons.chevron_right),
                    color: Colors.white,
                  )
                ],
              ),
            ),
            i == 2
                ? Container(
                    margin: const EdgeInsets.only(top: 30),
                    height: 50,
                    width: 350,
                    child: ElevatedButton(
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('jaViuIntro', true);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TelaCadastro(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                            255, 139, 32, 32), // fundo escuro
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
                      child: const Text('Continuar'),
                    ),
                  )
                : Container(),
          ]),
        ));
  }
}
