import 'package:flutter/material.dart';

// 1. Crie o mapa com todos os ícones que você disponibiliza para o usuário
final Map<int, IconData> iconMap = {
  // Mapeia o codePoint de cada ícone para sua instância constante
  Icons.king_bed_outlined.codePoint: Icons.king_bed_outlined,
  Icons.kitchen_outlined.codePoint: Icons.kitchen_outlined,
  Icons.living_outlined.codePoint: Icons.living_outlined,
  Icons.bathtub_outlined.codePoint: Icons.bathtub_outlined,
  Icons.garage_outlined.codePoint: Icons.garage_outlined,
  Icons.deck_outlined.codePoint: Icons.deck_outlined,
  Icons.balcony_outlined.codePoint: Icons.balcony_outlined,
  Icons.local_laundry_service_outlined.codePoint: Icons.local_laundry_service_outlined,
  Icons.chair_outlined.codePoint: Icons.chair_outlined,
  Icons.home.codePoint: Icons.home, // Adicione um ícone padrão
  // 'iconesDisponiveis'
};


IconData getIconFromCodePoint(int codePoint) {
  // Procura o ícone no mapa. Se não encontrar, retorna um ícone padrão.
  return iconMap[codePoint] ?? Icons.home;
}