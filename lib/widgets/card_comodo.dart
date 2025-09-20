import 'package:automacao_residencial/classes/comodo.dart';
import 'package:flutter/material.dart';

class CardComodo extends StatelessWidget {
  /// Widget que exibe um cartão representativo de um cômodo.
  ///
  /// Ele mostra o ícone e o nome do cômodo.
  const CardComodo({super.key, required this.comodo});
  final Comodo comodo;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
            elevation: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  comodo.icone,
                  size: 40,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(height: 8),
                Text(
                  comodo.nome,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
        Column(
          children: [
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              iconSize: 28,
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.delete_outlined),
              iconSize: 28,
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
