import 'package:flutter/material.dart';

import '../models/pet.dart';
import '../models/adoption_request.dart';
import '../utils/validators.dart';

class AdoptScreen extends StatefulWidget {
  const AdoptScreen({super.key});

  @override
  State<AdoptScreen> createState() => _AdoptScreenState();
}

class _AdoptScreenState extends State<AdoptScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _reasonController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  void _submitForm(Pet pet) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final request = AdoptionRequest(
      petId: pet.id,
      petName: pet.name,
      fullName: _nameController.text.trim(),
      phone: _phoneController.text.trim(),
      email: _emailController.text.trim(),
      address: _addressController.text.trim(),
      reason: _reasonController.text.trim(),
      submittedAt: DateTime.now(),
    );

    Navigator.pop<AdoptionRequest>(context, request);
  }

  @override
  Widget build(BuildContext context) {
    final pet = ModalRoute.of(context)!.settings.arguments as Pet;

    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text('Adopt ${pet.name}')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                'Let’s find a home for ${pet.name}!',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Fill in your details to apply for adoption.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: 24),

              TextFormField(
                controller: _nameController,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Full name',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: Validators.validateName,
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: const InputDecoration(
                  labelText: 'Phone number',
                  prefixIcon: Icon(Icons.phone_outlined),
                  counterText: '',
                ),
                validator: Validators.validatePhone,
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                validator: Validators.validateEmail,
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _addressController,
                keyboardType: TextInputType.streetAddress,
                textCapitalization: TextCapitalization.sentences,
                maxLines: 3,
                minLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  alignLabelWithHint: true,
                  prefixIcon: Icon(Icons.home_outlined),
                ),
                validator: Validators.validateAddress,
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _reasonController,
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                minLines: 3,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Why do you want to adopt ${pet.name}?',
                  alignLabelWithHint: true,
                  prefixIcon: const Icon(Icons.favorite_outline),
                ),
                validator: Validators.validateReason,
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () => _submitForm(pet),
                child: const Text('Submit application'),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
