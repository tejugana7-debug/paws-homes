import 'package:flutter/material.dart';

import '../models/pet.dart';
import '../models/adoption_request.dart';
import '../routes.dart';
import '../widgets/stat_tile.dart';

class PetDetailScreen extends StatelessWidget {
  const PetDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pet = ModalRoute.of(context)!.settings.arguments as Pet;

    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(pet.name)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 280,
                  child: Image.asset(
                    pet.imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: colors.surfaceContainerHighest,
                        child: Icon(
                          Icons.pets,
                          size: 80,
                          color: colors.primary,
                        ),
                      );
                    },
                  ),
                ),

                if (pet.isVaccinated)
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: colors.primaryContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.verified,
                            size: 18,
                            color: colors.onPrimaryContainer,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Vaccinated',
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: colors.onPrimaryContainer,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pet.name,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    '${pet.breed} · ${pet.type}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: StatTile(
                          label: 'Age',
                          value: pet.ageInYears == 0
                              ? 'Puppy'
                              : '${pet.ageInYears} '
                                    '${pet.ageInYears == 1 ? 'yr' : 'yrs'}',
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: StatTile(label: 'Gender', value: pet.gender),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: StatTile(
                          label: 'Weight',
                          value: '${pet.weightKg} kg',
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  Text(
                    'About me',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(pet.description, style: theme.textTheme.bodyLarge),

                  const SizedBox(height: 24),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colors.secondaryContainer,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Care tip',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colors.onSecondaryContainer,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          pet.careTip(),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colors.onSecondaryContainer,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: pet.isAdopted
                          ? null
                          : () async {
                              final request =
                                  await Navigator.pushNamed<AdoptionRequest>(
                                    context,
                                    AppRoutes.adopt,
                                    arguments: pet,
                                  );

                              if (!context.mounted) return;

                              if (request != null) {
                                Navigator.pop(context, request);
                              }
                            },
                      child: Text(
                        pet.isAdopted ? 'Already adopted' : 'Adopt me',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
