import 'package:flutter/material.dart';

/// Mapa que associa o `codePoint` de um ícone à sua instância `IconData` constante.
///
/// Usado para converter o ícone salvo localmente (como um número inteiro) de volta
/// para um objeto `IconData` que o Flutter pode renderizar,
/// garantindo a compatibilidade com a otimização de "tree shaking".
final Map<int, IconData> iconMap = {
  Icons.home_outlined.codePoint: Icons.home_outlined,
  Icons.bed_outlined.codePoint: Icons.bed_outlined,
  Icons.room_outlined.codePoint: Icons.room_outlined,
  Icons.room_service_outlined.codePoint: Icons.room_service_outlined,
  Icons.dining_outlined.codePoint: Icons.dining_outlined,
  Icons.kitchen_outlined.codePoint: Icons.kitchen_outlined,
  Icons.living_outlined.codePoint: Icons.living_outlined,
  Icons.bathtub_outlined.codePoint: Icons.bathtub_outlined,
  Icons.garage_outlined.codePoint: Icons.garage_outlined,
  Icons.deck_outlined.codePoint: Icons.deck_outlined,
  Icons.balcony_outlined.codePoint: Icons.balcony_outlined,
  Icons.local_laundry_service_outlined.codePoint: Icons.local_laundry_service_outlined,
  Icons.chair_outlined.codePoint: Icons.chair_outlined,
};

/// Obtém a instância `IconData` correspondente a um `codePoint`.
///
/// Se o `codePoint` não for encontrado no mapa, retorna um ícone padrão
/// (`Icons.home_outlined`) para evitar erros.
IconData getIconFromCodePoint(int codePoint) {
  return iconMap[codePoint] ?? Icons.home_outlined;
}