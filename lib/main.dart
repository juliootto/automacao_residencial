import 'package:automacao_residencial/classes/casa.dart';
import 'package:automacao_residencial/classes/comodo.dart';
import 'package:automacao_residencial/services/persistence_service.dart';
import 'package:automacao_residencial/widgets/grid_comodos.dart';
import 'package:flutter/material.dart';

// O ponto de entrada principal da aplicação Flutter.
void main() {
  runApp(const MyApp());
}

// MyApp é o widget raiz da aplicação.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Automação Residencial',
      theme: ThemeData(
        // Define o esquema de cores da aplicação, usando uma semente de cor.
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 14, 37, 141),
        ),
      ),
      home: const MyHomePage(title: 'Automação Residencial'),
    );
  }
}

// MyHomePage é o widget da página inicial que exibe a lista de cômodos.
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// A instância da casa que contém os cômodos.
  late Casa casa; 
  /// Flag para indicar se os dados estão sendo carregados.
  bool _isLoading = true; 
  /// Serviço para persistência de dados (salvar e carregar a casa).
  final PersistenceService _persistenceService = PersistenceService();


  @override
  void initState() {
    super.initState();
    _loadData(); // Carrega os dados quando a tela é iniciada
  }

  // Função para carregar os dados
  /// Carrega os dados da casa usando o [PersistenceService].
  ///
  /// Atualiza o estado da UI com os dados carregados e define [_isLoading] como `false`.
  Future<void> _loadData() async {
    final loadedCasa = await _persistenceService.loadCasa();
    setState(() {
      casa = loadedCasa;
      _isLoading = false;
    });
  }

  /// Salva os dados da casa usando o [PersistenceService].
  Future<void> _saveData() async {
    await _persistenceService.saveCasa(casa);
  }

  /// Altera um cômodo existente na casa.
  ///
  /// [comodoAntigo] é o cômodo a ser alterado.
  /// [nome] é o novo nome do cômodo.
  /// [icone] é o novo ícone do cômodo.

  // Adiciona um novo cômodo à casa e salva os dados.
  void alterarComodo(Comodo comodoAntigo, String nome, IconData icone) {
    setState(() {
      casa.alterarComodo(comodoAntigo, nome, icone);
    });
    _saveData(); // SALVA AQUI!
  }

  /// Adiciona um novo cômodo à casa.
  ///
  /// [nome] é o nome do novo cômodo.
  /// [icone] é o ícone do novo cômodo.
  void adicionarComodo(String nome, IconData icone) {
    setState(() {
      casa.adicionarComodo(nome, icone);
    });
    _saveData(); // SALVA AQUI!
  }

  /// Exibe um diálogo para adicionar um novo cômodo.
  ///
  /// Permite ao usuário inserir um nome e selecionar um ícone para o cômodo.
  /// Ao confirmar, chama [adicionarComodo] para adicionar o novo cômodo.
  Future<void> _dialogoAdicionarComodo() async {
    final TextEditingController nomeComodoController = TextEditingController();

    // Lista de ícones que o usuário pode escolher
    final List<IconData> iconesDisponiveis = [
      Icons.home_outlined,
      Icons.bed_outlined,
      Icons.room_outlined,
      Icons.room_service_outlined,
      Icons.dining_outlined,
      Icons.kitchen_outlined,
      Icons.living_outlined,
      Icons.bathtub_outlined,
      Icons.garage_outlined,
      Icons.deck_outlined,
      Icons.balcony_outlined,
      Icons.local_laundry_service_outlined,
      Icons.chair_outlined,
    ];

    // Variável para guardar o ícone selecionado
    IconData iconeSelecionado =
        iconesDisponiveis[0]; // Pré-seleciona o primeiro

    return showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        // StatefulBuilder permite que o conteúdo do diálogo tenha seu próprio estado
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Adicionar Novo Cômodo'),
              content: SingleChildScrollView(
                // Para evitar overflow se a tela for pequena
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Campo de texto para o nome
                    TextField(
                      controller: nomeComodoController,
                      autofocus: true,
                      decoration: const InputDecoration(hintText: "Ex: Quarto"),
                    ),
                    const SizedBox(height: 20),
                    // Grade de ícones para seleção
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: iconesDisponiveis.map((icone) {
                        final bool isSelected = icone == iconeSelecionado;
                        return InkWell(
                          onTap: () {
                            // Atualiza o estado DO DIÁLOGO para refletir a seleção
                            setDialogState(() {
                              iconeSelecionado = icone;
                            });
                          },
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Theme.of(context).primaryColorLight
                                  : Colors.transparent,
                              border: Border.all(
                                color: isSelected
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey.shade300,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              icone,
                              size: 32,
                              color: isSelected
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey.shade600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancelar'),
                  onPressed: () => Navigator.of(dialogContext).pop(),
                ),
                TextButton(
                  child: const Text('Adicionar'),
                  onPressed: () {
                    final String nome = nomeComodoController.text;
                    if (nome.isNotEmpty) {
                      // Passa o nome E o ícone selecionado para a função.
                      adicionarComodo(nome, iconeSelecionado);
                    }
                    Navigator.of(dialogContext).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  /// Exibe um diálogo para editar um cômodo existente.
  ///
  /// [comodo] é o cômodo a ser editado.
  /// Permite ao usuário alterar o nome e o ícone do cômodo.
  void _dialogoEditarComodo(Comodo comodo) {
    final TextEditingController nomeComodoController = TextEditingController();
    final Comodo comodoAntigo = comodo;

    // Lista de ícones que o usuário pode escolher
    final List<IconData> iconesDisponiveis = [
      Icons.home_outlined,
      Icons.bed_outlined,
      Icons.room_outlined,
      Icons.room_service_outlined,
      Icons.dining_outlined,
      Icons.kitchen_outlined,
      Icons.living_outlined,
      Icons.bathtub_outlined,
      Icons.garage_outlined,
      Icons.deck_outlined,
      Icons.balcony_outlined,
      Icons.local_laundry_service_outlined,
      Icons.chair_outlined,
    ];

    // Variável para guardar o ícone selecionado
    IconData iconeSelecionado =
        iconesDisponiveis[0]; // Pré-seleciona o primeiro
    nomeComodoController.text = comodo.nome;
    iconeSelecionado = comodo.icone;

    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        // StatefulBuilder permite que o conteúdo do diálogo tenha seu próprio estado
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Editar Cômodo'),
              content: SingleChildScrollView(
                // Para evitar overflow se a tela for pequena
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Campo de texto para o nome
                    TextField(
                      controller: nomeComodoController,
                      autofocus: true,
                      decoration: const InputDecoration(hintText: "Ex: Quarto"),
                    ),
                    const SizedBox(height: 20),
                    // Grade de ícones para seleção
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: iconesDisponiveis.map((icone) {
                        final bool isSelected = icone == iconeSelecionado;
                        return InkWell(
                          onTap: () {
                            // Atualiza o estado DO DIÁLOGO para refletir a seleção
                            setDialogState(() {
                              iconeSelecionado = icone;
                            });
                          },
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Theme.of(context).primaryColorLight
                                  : Colors.transparent,
                              border: Border.all(
                                color: isSelected
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey.shade300,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              icone,
                              size: 32,
                              color: isSelected
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey.shade600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancelar'),
                  onPressed: () => Navigator.of(dialogContext).pop(),
                ),
                TextButton(
                  child: const Text('Salvar'),
                  onPressed: () {
                    final String nome = nomeComodoController.text;
                    if (nome.isNotEmpty) {
                      // Passa o nome E o ícone selecionado para a função.
                      alterarComodo(comodoAntigo, nome, iconeSelecionado);
                    }
                    Navigator.of(dialogContext).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  /// Exibe um diálogo de confirmação para remover um cômodo.
  ///
  /// [comodo] é o cômodo a ser removido.
  /// Se confirmado, remove o cômodo da casa e salva os dados.
  void _dialogoRemoverComodo(Comodo comodo) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Deletar Cômodo?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                // Aqui, estamos alterando o nome do objeto interruptor existente
                casa.removerComodo(comodo);
                // Opcional: Mostra uma mensagem de confirmação
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('"${comodo.nome}" foi removido.'),
                    backgroundColor: Colors.red,
                  ),
                );
              });

              Navigator.pop(context);
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );

    _saveData(); // Salva o estado atualizado após a remoção
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior da aplicação.
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Automação Residencial'),
      ),
      // Corpo da aplicação: mostra um indicador de progresso ou a grade de cômodos.
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridComodos(
              casa: casa,
              onDataChanged: _saveData,
              onComodoRemoved: _dialogoRemoverComodo,
              onComodoEdit: _dialogoEditarComodo,
            ),
      floatingActionButton: FloatingActionButton(
        // Botão para adicionar um novo cômodo.
        onPressed: _dialogoAdicionarComodo,
        tooltip: 'Adicionar Cômodo',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
