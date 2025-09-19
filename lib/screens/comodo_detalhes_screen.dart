import 'package:automacao_residencial/classes/comodo.dart';
import 'package:automacao_residencial/classes/interruptor.dart';
import 'package:automacao_residencial/widgets/interruptor_tile.dart';
import 'package:flutter/material.dart';

/// Uma tela que exibe os detalhes de um cômodo específico.
///
/// Permite ao usuário visualizar, adicionar e editar interruptores
/// associados a este cômodo.
class ComodoDetalhesScreen extends StatefulWidget {
  /// O objeto [Comodo] cujos detalhes serão exibidos.
  final Comodo comodo;

  /// Callback para notificar que os dados foram alterados e precisam ser salvos.
  final VoidCallback onDataChanged;

  const ComodoDetalhesScreen({
    super.key,
    required this.comodo,
    required this.onDataChanged,
  });

  @override
  State<ComodoDetalhesScreen> createState() => _ComodoDetalhesScreenState();
}

class _ComodoDetalhesScreenState extends State<ComodoDetalhesScreen> {
  /// Exibe um diálogo para adicionar um novo interruptor ao cômodo.
  ///
  /// O usuário pode inserir o nome e o IP do novo interruptor.
  /// Se o nome não for vazio, o interruptor é adicionado e os dados são salvos.
  void _mostrarDialogoAdicionarInterruptor() {
    final TextEditingController nomeController = TextEditingController();
    final TextEditingController ipController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Adicionar Novo Interruptor'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Campo de texto para o nome do interruptor
            TextField(
              controller: nomeController,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Nome do interruptor',
              ),
            ),
            // Campo de texto para o IP do interruptor
            TextField(
              controller: ipController,
              decoration: const InputDecoration(
                hintText: 'IP do interruptor (opcional)',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              if (nomeController.text.isNotEmpty) {
                setState(() {
                  widget.comodo.adicionarInterruptor(
                    Interruptor(
                      nome: nomeController.text,
                      estado: false,
                      url: ipController.text,
                    ),
                  );
                  widget.onDataChanged();
                });
              }
              Navigator.pop(context);
            },
            child: const Text('Adicionar'),
          ),
        ],
      ),
    );
  }

  /// Exibe um diálogo para editar um interruptor existente.
  ///
  /// O usuário pode modificar o nome e o IP do interruptor.
  /// As alterações são salvas no objeto [Interruptor] e os dados são persistidos.
  void _mostrarDialogoEditarInterruptor(Interruptor interruptor) {
    final TextEditingController nomeController = TextEditingController(
      text: interruptor.nome,
    );
    final TextEditingController ipController = TextEditingController(
      text: interruptor.url,
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar Interruptor'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Campo de texto para o novo nome do interruptor
            TextField(
              controller: nomeController,
              autofocus: true,
              decoration: const InputDecoration(hintText: 'Novo nome'),
            ),
            // Campo de texto para o novo IP do interruptor
            TextField(
              controller: ipController,
              decoration: const InputDecoration(hintText: 'IP do interruptor'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              if (nomeController.text.isNotEmpty) {
                setState(() {
                  // Aqui, estamos alterando o nome do objeto interruptor existente
                  interruptor.nome = nomeController.text;
                  interruptor.url = ipController.text;
                  widget.onDataChanged();
                });
              }
              Navigator.pop(context);
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  void _mostrarDialogoDeletarInterruptor(Interruptor interruptor) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Deletar Interruptor?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                // Aqui, estamos alterando o nome do objeto interruptor existente
                widget.comodo.removerInterruptor(interruptor);
                widget.onDataChanged();
              });

              Navigator.pop(context);
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.comodo.nome), // Exibe o nome do cômodo na AppBar
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: widget.comodo.interruptores.isEmpty
          ? const Center(
              child: Text(
                'Nenhum interruptor adicionado.\nClique no "+" para adicionar um.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: widget.comodo.interruptores.length,
              itemBuilder: (context, index) {
                final interruptor = widget.comodo.interruptores[index];
                return InterruptorTile(
                  interruptor: interruptor,
                  onEdit: () => _mostrarDialogoEditarInterruptor(interruptor),
                  onDelete: () =>
                      _mostrarDialogoDeletarInterruptor(interruptor),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarDialogoAdicionarInterruptor,
        tooltip: 'Adicionar Interruptor',
        child: const Icon(Icons.add),
      ),
    );
  }
}
