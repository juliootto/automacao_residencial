import 'package:automacao_residencial/classes/interruptor.dart';
import 'package:flutter/material.dart';

class InterruptorTile extends StatefulWidget {
  /// O objeto Interruptor que este tile representa.
  final Interruptor interruptor;

  /// Callback a ser chamado quando o botão de edição for pressionado.
  ///
  /// Permite que o widget pai reaja à intenção do usuário de editar o interruptor.
  final VoidCallback onEdit;

  const InterruptorTile({
    /// Chave para identificar este widget.
    super.key,
    required this.interruptor,
    required this.onEdit,
  });

  @override
  State<InterruptorTile> createState() => _InterruptorTileState();
}

class _InterruptorTileState extends State<InterruptorTile> {
  /// Estado local para controlar visualmente o estado do switch (ligado/desligado).
  late bool _estaLigado;

  @override
  void initState() {
    super.initState();
    // Inicializa o estado local com o estado atual do interruptor.
    _estaLigado = widget.interruptor.estado;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      // Um ListTile é ideal para exibir um item em uma lista com título, ícone e ações.
      child: ListTile(
        // Ícone principal que muda de aparência dependendo do estado do interruptor.
        leading: Icon(
          _estaLigado ? Icons.lightbulb : Icons.lightbulb_outline,
          color: _estaLigado ? Colors.amber : Colors.grey,
          size: 30,
        ),
        // Título do ListTile, exibindo o nome do interruptor.
        title: Text(widget.interruptor.nome, style: const TextStyle(fontWeight: FontWeight.bold)),
        // trailing: Contém widgets que aparecem no final do ListTile, como o Switch e o botão de edição.
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // O Switch permite ao usuário alternar o estado do interruptor.
            Switch(
              value: _estaLigado,
              onChanged: (novoEstado) {
                // Atualiza o estado local e o objeto Interruptor quando o switch é alterado.
                setState(() {
                  _estaLigado = novoEstado;
                  // Persiste a mudança de estado no objeto Interruptor.
                  widget.interruptor.estado = novoEstado;
                });
                // TODO: Adicionar lógica para enviar comando via URL, se necessário
                // Esta é uma área para futura implementação de comunicação com hardware.
              },
            ),
            // Botão de ícone para iniciar a edição do interruptor.
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: widget.onEdit, // Chama a função passada pelo pai
            ),
          ],
        ),
      ),
    );
  }
}