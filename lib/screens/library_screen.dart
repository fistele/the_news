import 'package:flutter/material.dart';
import '../config/colors.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Commencer à lire !",
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          const Padding(
            padding: EdgeInsets.only(left: 50.0, right: 50.0),
            child: Text(
              "Pour accéder à vos magazines, veuillez vous connecter à votre compte.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.0,
                color: AppColors.black800,
              ),
            ),
          ),
          const SizedBox(height: 25.0),
          FractionallySizedBox(
            widthFactor: 0.7,
            child: ElevatedButton(
              onPressed: () {
                // Je reviens si j'ai le temps
              },
              style: ElevatedButton.styleFrom(
                elevation: 0.0,
                backgroundColor: AppColors.primaryColor,
                minimumSize: const Size(double.infinity, 50.0),
              ),
              child: const Text(
                "Je me connecte",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 15.0),
          FractionallySizedBox(
            widthFactor: 0.7,
            child: ElevatedButton(
              onPressed: () {
                // Je reviens si j'ai le temps
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                minimumSize: const Size(double.infinity, 50.0),
              ),
              child: const Text(
                "Se connecter avec Apple",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 15.0),
          FractionallySizedBox(
            widthFactor: 0.7,
            child: ElevatedButton(
              onPressed: () {
                // Je reviens si j'ai le temps
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 27, 9, 188),
                minimumSize: const Size(double.infinity, 50.0),
              ),
              child: const Text(
                "Continuer avec Facebook",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Vous n'avez pas encore...",
                style: TextStyle(
                  fontSize: 16.0,
                  color: AppColors.black800,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Je vais revenir si j'ai le temps
                },
                child: const Text(
                  "Je m'inscris",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
