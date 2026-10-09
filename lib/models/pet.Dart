
abstract class Pet {
  Pet({
    required this.id,
    required this.name,
    required this.breed,
    required this.ageInYears,
    required this.gender,
    required this.weightKg,
    required this.imagePath,
    required this.description,
    this.isVaccinated = false,
    this.isNew = false,
  });

  final String id;
  final String name;
  final String breed;
  final int ageInYears;
  final String gender;
  final double weightKg;
  final String imagePath;
  final String description;
  final bool isVaccinated;
  final bool isNew;

  String? adoptedBy;

  bool get isAdopted => adoptedBy != null;

  String get type;

  String careTip();
}

class Dog extends Pet {
  Dog({
    required super.id,
    required super.name,
    required super.breed,
    required super.ageInYears,
    required super.gender,
    required super.weightKg,
    required super.imagePath,
    required super.description,
    super.isVaccinated,
    super.isNew,
  });

  Dog.puppy({
    required String id,
    required String name,
    required String breed,
    required String gender,
    required double weightKg,
    required String imagePath,
    required String description,
  }) : this(
          id: id,
          name: name,
          breed: breed,
          ageInYears: 0,
          gender: gender,
          weightKg: weightKg,
          imagePath: imagePath,
          description: description,
          isNew: true,
        );

  @override
  String get type => 'Dog';

  @override
  String careTip() =>
      'Take me for daily walks and give me regular exercise.';
}

class Cat extends Pet {
  Cat({
    required super.id,
    required super.name,
    required super.breed,
    required super.ageInYears,
    required super.gender,
    required super.weightKg,
    required super.imagePath,
    required super.description,
    super.isVaccinated,
    super.isNew,
  });

  @override
  String get type => 'Cat';

  @override
  String careTip() =>
      'Keep my litter box clean and provide daily playtime.';
}

class Bird extends Pet {
  Bird({
    required super.id,
    required super.name,
    required super.breed,
    required super.ageInYears,
    required super.gender,
    required super.weightKg,
    required super.imagePath,
    required super.description,
    super.isVaccinated,
    super.isNew,
  });

  @override
  String get type => 'Bird';

  @override
  String careTip() =>
      'Keep my cage clean and give me fresh water and daily interaction.';
}
