import 'package:automacao_residencial/classes/interruptor.dart';
import 'package:flutter/material.dart';

class InterruptorTile extends StatefulWidget {
  /// O objeto Interruptor que este tile representa.
  final Interruptor interruptor;

  /// Callback a ser chamado quando o botão de edição for pressionado.
  ///
  /// Permite que o widget pai reaja à intenção do usuário de editar o interruptor.
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const InterruptorTile({
    /// Chave para identificar este widget.
    super.key,
    required this.interruptor,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  State<InterruptorTile> createState() => _InterruptorTileState();
}

class _InterruptorTileState extends State<InterruptorTile> {
  /// Estado local para controlar visualmente o estado do switch (ligado/desligado).
  late bool _estaLigado = false;

  @override
  void initState()  {
    super.initState();
    // Inicializa o estado local com o estado atual do interruptor.
     widget.interruptor.atualizaEstado().then((valorEstado){
      setState(() {
        _estaLigado = valorEstado;
      });
     });
     }
  

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      // Um ListTile é ideal para exibir um item em uma lista com título, ícone e ações.
      child: ListTile(
        // O Switch permite ao usuário alternar o estado do interruptor.
        leading: Switch(
          value: _estaLigado,
          onChanged: (novoEstado) {
            // Atualiza o estado local e o objeto Interruptor quando o switch é alterado.
            setState(()  {
              widget.interruptor.mudaInterruptor().then((onValue){
                _estaLigado = onValue;
              });
              // Persiste a mudança de estado no objeto Interruptor.
            });
          },
        ),
        // Título do ListTile, exibindo o nome do interruptor.
        title: Row(
          children: [
            Text(
              widget.interruptor.nome,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 10),
            Icon(
              _estaLigado ? Icons.lightbulb : Icons.lightbulb_outline,
              color: _estaLigado ? Colors.amber : Colors.grey,
              size: 30,
            ),
          ],
        ),
        // trailing: Contém widgets que aparecem no final do ListTile, como o Switch e o botão de edição.
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Ícone principal que muda de aparência dependendo do estado do interruptor.

            // Botão de ícone para iniciar a edição do interruptor.
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: widget.onEdit, // Chama a função passada pelo pai
            ),

            IconButton(
              icon: const Icon(Icons.delete_outlined),
              onPressed: widget.onDelete, // Chama a função passada pelo pai
            ),
          ],
        ),
      ),
    );
  }
}
