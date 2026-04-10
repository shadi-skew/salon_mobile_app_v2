import 'package:flutter/material.dart';
import 'package:salon_mobile_app_v2/core/resources/color_manager.dart';

/// Filter options for the My Formulas list
enum FormulaFilter { all, recent, favorites }

/// Hair color brand options for the formula calculator
enum HairBrand { wella, loreal, schwarzkopf, redken, matrix, pravana }

extension HairBrandExtension on HairBrand {
  String get label {
    switch (this) {
      case HairBrand.wella:
        return 'Wella';
      case HairBrand.loreal:
        return "L'Oréal";
      case HairBrand.schwarzkopf:
        return 'Schwarzkopf';
      case HairBrand.redken:
        return 'Redken';
      case HairBrand.matrix:
        return 'Matrix';
      case HairBrand.pravana:
        return 'Pravana';
    }
  }

  String get initials {
    switch (this) {
      case HairBrand.wella:
        return 'W';
      case HairBrand.loreal:
        return 'L';
      case HairBrand.schwarzkopf:
        return 'S';
      case HairBrand.redken:
        return 'R';
      case HairBrand.matrix:
        return 'M';
      case HairBrand.pravana:
        return 'P';
    }
  }
}

/// Represents a saved hair color formula
class Formula {
  const Formula({
    required this.id,
    required this.name,
    required this.currentLevel,
    required this.targetLevel,
    required this.brand,
    required this.processingTime,
    this.isFavorite = false,
    this.tags = const [],
    required this.createdAt,
  });

  final String id;
  final String name;

  /// Hair level 1–10 representing current client hair
  final int currentLevel;

  /// Hair level 1–10 representing the desired target
  final int targetLevel;

  final String brand;
  final String processingTime;
  final bool isFavorite;
  final List<String> tags;
  final DateTime createdAt;

  Formula copyWith({
    String? id,
    String? name,
    int? currentLevel,
    int? targetLevel,
    String? brand,
    String? processingTime,
    bool? isFavorite,
    List<String>? tags,
    DateTime? createdAt,
  }) {
    return Formula(
      id: id ?? this.id,
      name: name ?? this.name,
      currentLevel: currentLevel ?? this.currentLevel,
      targetLevel: targetLevel ?? this.targetLevel,
      brand: brand ?? this.brand,
      processingTime: processingTime ?? this.processingTime,
      isFavorite: isFavorite ?? this.isFavorite,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Formula && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

/// Returns the description string for a hair level (1–10)
String hairLevelDescription(int level) {
  switch (level) {
    case 1:
      return 'Black';
    case 2:
      return 'Very Dark Brown';
    case 3:
      return 'Dark Brown';
    case 4:
      return 'Medium Dark Brown';
    case 5:
      return 'Light Brown';
    case 6:
      return 'Ash Brown';
    case 7:
      return 'Medium Blonde';
    case 8:
      return 'Light Blonde';
    case 9:
      return 'Very Light Blonde';
    case 10:
      return 'Lightest Blonde';
    default:
      return 'Unknown';
  }
}

/// Returns the hair swatch color for a given level (1–10)
Color hairLevelColor(int level) {
  switch (level) {
    case 1:
      return ColorManager.hairLevel1;
    case 2:
      return ColorManager.hairLevel2;
    case 3:
      return ColorManager.hairLevel3;
    case 4:
      return ColorManager.hairLevel4;
    case 5:
      return ColorManager.hairLevel5;
    case 6:
      return ColorManager.hairLevel6;
    case 7:
      return ColorManager.hairLevel7;
    case 8:
      return ColorManager.hairLevel8;
    case 9:
      return ColorManager.hairLevel9;
    case 10:
      return ColorManager.hairLevel10;
    default:
      return ColorManager.hairLevel5;
  }
}
