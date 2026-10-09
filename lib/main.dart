import 'package:flutter/material.dart';

import 'routes.dart';
//import 'theme.dart';
import 'screens/home_screen.dart';
import 'screens/pet_detail_screen.dart';
import 'screens/adopt_screen.dart';
import 'screens/applications_screen.dart';
import 'models/adoption_request.dart';

void main() {
  runApp(const PawsAndHomesApp());
}

class PawsAndHomesApp extends StatelessWidget {
  const PawsAndHomesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Paws & Homes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.home,

      onGenerateRoute: (settings) {
        switch (settings.name) {
          case AppRoutes.home:
            return MaterialPageRoute<void>(
              settings: settings,
              builder: (_) => const HomeScreen(),
            );

          case AppRoutes.petDetail:
            return MaterialPageRoute<AdoptionRequest?>(
              settings: settings,
              builder: (_) => const PetDetailScreen(),
            );

          case AppRoutes.adopt:
            return MaterialPageRoute<AdoptionRequest?>(
              settings: settings,
              builder: (_) => const AdoptScreen(),
            );

          case AppRoutes.applications:
            return MaterialPageRoute<void>(
              settings: settings,
              builder: (_) => const ApplicationsScreen(),
            );

          default:
            return null;
        }
      },
    );
  }
}
