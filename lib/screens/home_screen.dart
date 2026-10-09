import 'package:flutter/material.dart';

import '../data/pet_service.dart';
import '../models/pet.dart';
import '../models/adoption_request.dart';
import '../routes.dart';
import '../widgets/pet_card.dart';
import '../widgets/category_chips.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Pet> pets = [];
  final Set<String> favouriteIds = {};
  final Map<String, AdoptionRequest> applications = {};

  String selectedCategory = 'All';
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    _loadPets();
  }

  Future<void> _loadPets() async {
    try {
      final result = await fetchPets();

      if (!mounted) return;

      setState(() {
        pets = result;
        isLoading = false;
        hasError = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
        hasError = true;
      });
    }
  }

  List<Pet> get filteredPets {
    if (selectedCategory == 'Dogs') {
      return pets.where((pet) => pet.type == 'Dog').toList();
    }

    if (selectedCategory == 'Cats') {
      return pets.where((pet) => pet.type == 'Cat').toList();
    }

    if (selectedCategory == 'Birds') {
      return pets.where((pet) => pet.type == 'Bird').toList();
    }

    return pets;
  }

  Future<void> _openPet(Pet pet) async {
    final request = await Navigator.pushNamed<AdoptionRequest>(
      context,
      AppRoutes.petDetail,
      arguments: pet,
    );

    if (!context.mounted) return;

    if (request != null) {
      setState(() {
        applications[request.petId] = request;
        pet.adoptedBy = request.fullName;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${request.petName} adoption application submitted!'),
        ),
      );
    }
  }

  void _toggleFavourite(Pet pet) {
    setState(() {
      if (favouriteIds.contains(pet.id)) {
        favouriteIds.remove(pet.id);
      } else {
        favouriteIds.add(pet.id);
      }
    });
  }

  Future<void> _openApplications() async {
    await Navigator.pushNamed(
      context,
      AppRoutes.applications,
      arguments: applications.values.toList(),
    );

    if (!context.mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Paws & Homes',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _openApplications,
            tooltip: 'My applications',
            icon: const Icon(Icons.assignment_outlined),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Text(
              'Find your new best friend',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: colors.onSurface,
              ),
            ),
          ),
          CategoryChips(
            selectedCategory: selectedCategory,
            onCategorySelected: (category) {
              setState(() {
                selectedCategory = category;
              });
            },
          ),
          const SizedBox(height: 8),
          Expanded(child: _buildPetList(colors)),
        ],
      ),
    );
  }

  Widget _buildPetList(ColorScheme colors) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator(color: colors.primary));
    }

    if (hasError) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Unable to load pets.'),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isLoading = true;
                  hasError = false;
                });
                _loadPets();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final visiblePets = filteredPets;

    if (visiblePets.isEmpty) {
      return const Center(child: Text('No pets found.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: visiblePets.length,
      itemBuilder: (context, index) {
        final pet = visiblePets[index];

        return PetCard(
          pet: pet,
          isFavourite: favouriteIds.contains(pet.id),
          onFavouriteTap: () => _toggleFavourite(pet),
          onTap: () => _openPet(pet),
        );
      },
    );
  }
}
