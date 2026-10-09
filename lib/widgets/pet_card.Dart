
import 'package:flutter/material.dart';
import '../models/pet.dart';

class PetCard extends StatelessWidget {
  const PetCard({
    super.key,
    required this.pet,
    required this.isFavourite,
    required this.onFavouriteTap,
    required this.onTap,
  });

  final Pet pet;
  final bool isFavourite;
  final VoidCallback onFavouriteTap;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
        debugPrint('PET CARD TAPPED');
        onTap?.call();
      },
        child: Row(
          children: [
            SizedBox(
              width: 115,
              height: 125,
              child: Image.asset(
                pet.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: colors.surfaceContainerHighest,
                    child: Icon(
                      Icons.pets,
                      size: 40,
                      color: colors.primary,
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            pet.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: onFavouriteTap,
                          icon: Icon(
                            isFavourite
                                ? Icons.favorite
                                : Icons.favorite_border,
                          ),
                          color: isFavourite
                              ? colors.error
                              : colors.onSurfaceVariant,
                          tooltip: 'Toggle favourite',
                        ),
                      ],
                    ),
                    Text(
                      '${pet.breed} · ${pet.ageInYears} '
                      '${pet.ageInYears == 1 ? 'yr' : 'yrs'}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: [
                        if (pet.isNew && !pet.isAdopted)
                          _PetBadge(
                            label: 'NEW',
                            color: colors.tertiaryContainer,
                            textColor: colors.onTertiaryContainer,
                          ),
                        if (pet.isAdopted)
                          _PetBadge(
                            label: 'ADOPTED',
                            color: colors.secondaryContainer,
                            textColor: colors.onSecondaryContainer,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PetBadge extends StatelessWidget {
  const _PetBadge({
    required this.label,
    required this.color,
    required this.textColor,
  });

  final String label;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
