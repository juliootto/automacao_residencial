import 'package:automacao_residencial/classes/comodo.dart';
import 'package:flutter/material.dart';

class CardComodo extends StatefulWidget {
  /// Widget que exibe um cartão representativo de um cômodo.
  ///
  /// Ele mostra o ícone e o nome do cômodo, além de botões para editar e deletar o cômodo.
  const CardComodo({super.key, required this.comodo, required this.onEdit, required this.onDelete});
  /// O objeto [Comodo] que este cartão representa.
  final Comodo comodo;
  /// Callback a ser chamado quando o botão de edição for pressionado.
  ///
  /// Permite que o widget pai reaja à intenção do usuário de editar o cômodo.
  final VoidCallback onEdit;
  /// Callback a ser chamado quando o botão de deleção for pressionado.
  ///
  /// Permite que o widget pai reaja à intenção do usuário de deletar o cômodo.
  final VoidCallback onDelete;
 @override
  State<StatefulWidget> createState() => _CardComodoState();
}

class _CardComodoState extends State<CardComodo> {
  /// Getter para acessar o objeto [Comodo] do widget.
  Comodo get comodo {
    return widget.comodo;
  }

  @override
  Widget build(BuildContext context) {
    // Um Row é usado para organizar o Card do cômodo e os botões de ação lado a lado.
    return Row(
      children: [
        Expanded(
          child: Card(
            elevation: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Ícone representativo do cômodo.
                Icon(
                  comodo.icone,
                  size: 40,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(height: 8),
                // Nome do cômodo.
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
        // Coluna para os botões de edição e deleção.
        Column(
          children: [
            // Botão de ícone para editar o cômodo.
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              iconSize: 28,
              onPressed: widget.onEdit,
            ),
            // Botão de ícone para deletar o cômodo.
            IconButton(
              icon: const Icon(Icons.delete_outlined),
              iconSize: 28,
              onPressed: widget.onDelete,
            ),
          ],
        ),
      ],
    );
  }
  
 
}
