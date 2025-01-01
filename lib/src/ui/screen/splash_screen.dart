import 'package:flutter/material.dart';

import 'home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xff050c21),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('assets/images/logo.png'),
            const SizedBox(
              width: 300,
              child: Text(
                'Crea notas y listas de tareas de forma facil',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w800),
                textAlign: TextAlign.justify,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              child: const Text(
                "Iniciar",
                style: TextStyle(
                    color: Color.fromARGB(255, 68, 0, 121), fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}