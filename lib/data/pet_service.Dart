
import '../models/pet.dart';

Future<List<Pet>> fetchPets() async {
  try {
    await Future.delayed(const Duration(seconds: 2));

    return [
      Dog(
        id: '1',
        name: 'Bruno',
        breed: 'Labrador',
        ageInYears: 2,
        gender: 'Male',
        weightKg: 28,
        imagePath: 'assets/images/bruno.jpg',
        description: 'A friendly Labrador looking for a loving home.',
        isVaccinated: true,
        isNew: true,
      ),
      Cat(
        id: '2',
        name: 'Coco',
        breed: 'Persian',
        ageInYears: 1,
        gender: 'Female',
        weightKg: 3.5,
        imagePath: 'assets/images/coco.jpg',
        description: 'A gentle Persian cat who loves attention.',
        isVaccinated: true,
      ),
      Dog(
        id: '3',
        name: 'Max',
        breed: 'Indie',
        ageInYears: 4,
        gender: 'Male',
        weightKg: 18,
        imagePath: 'assets/images/max.jpg',
        description: 'An active Indie dog ready for a new family.',
        isVaccinated: true,
      ),
      Bird(
        id: '4',
        name: 'Kiwi',
        breed: 'Budgie',
        ageInYears: 1,
        gender: 'Female',
        weightKg: 0.04,
        imagePath: 'assets/images/kiwi.jpg',
        description: 'A cheerful little budgie looking for a caring owner.',
        isNew: true,
      ),
      Cat(
        id: '5',
        name: 'Luna',
        breed: 'Siamese',
        ageInYears: 3,
        gender: 'Female',
        weightKg: 4,
        imagePath: 'assets/images/luna.jpg',
        description: 'A curious Siamese cat who enjoys companionship.',
      ),
      Dog.puppy(
        id: '6',
        name: 'Rocky',
        breed: 'Beagle',
        gender: 'Male',
        weightKg: 6,
        imagePath: 'assets/images/rocky.jpg',
        description: 'A playful Beagle puppy looking for a family.',
      ),
    ];
  } catch (e) {
    rethrow;
  }
}
