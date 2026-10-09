class AdoptionRequest {
  AdoptionRequest({
    required this.petId,
    required this.petName,
    required this.fullName,
    required this.phone,
    required this.email,
    required this.address,
    required this.reason,
    required this.submittedAt,
  });

  final String petId;
  final String petName;
  final String fullName;
  final String phone;
  final String email;
  final String address;
  final String reason;
  final DateTime submittedAt;
}
