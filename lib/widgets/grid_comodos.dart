import 'package:automacao_residencial/classes/casa.dart';
import 'package:automacao_residencial/screens/comodo_detalhes_screen.dart'; // Importe a nova tela
import 'package:automacao_residencial/widgets/card_comodo.dart';
import 'package:flutter/material.dart';

/// Um widget que exibe uma grade de cartões de cômodos.
///
/// Permite a navegação para a tela de detalhes de cada cômodo
/// e exibe uma mensagem se não houver cômodos adicionados.
class GridComodos extends StatelessWidget {
  /// Construtor para [GridComodos].
  const GridComodos({super.key, required this.casa,required this.onDataChanged,});

  final Casa casa; /// A instância da casa contendo a lista de cômodos.
  final VoidCallback onDataChanged; /// Callback para notificar mudanças nos dados.

  @override
  Widget build(BuildContext context) {
    if (casa.comodos.isEmpty) {
      // Retorna um widget mais informativo quando a lista está vazia
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            'Nenhum cômodo adicionado.\nClique no botão "+" para começar.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }
    // Usa GridView.builder para construir a grade de forma eficiente.
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Dois itens por linha
        crossAxisSpacing: 16, // Espaçamento horizontal entre os cartões
        mainAxisSpacing: 16, // Espaçamento vertical entre os cartões
        childAspectRatio: 1.5, // Proporção da largura pela altura de cada cartão
      ),
      padding: const EdgeInsets.all(16), // Preenchimento em torno da grade
      itemCount: casa.comodos.length, // Número total de cômodos a serem exibidos
      itemBuilder: (context, index) {
        final comodo = casa.comodos[index];
        // GestureDetector para tornar o CardComodo clicável.
        return GestureDetector(
          onTap: () => Navigator.push(
            // Navega para a tela de detalhes do cômodo ao tocar no cartão.
            context,
            MaterialPageRoute(
              // Navega para a tela de detalhes, passando o cômodo clicado
              builder: (_) => ComodoDetalhesScreen(comodo: comodo,onDataChanged: onDataChanged,),
            ),
          ),
          child: CardComodo(comodo: comodo),
        );
      },
    );
  }
}