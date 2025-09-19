import 'package:automacao_residencial/classes/casa.dart';
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Automação Residencial',
      theme: ThemeData(
        // Define o esquema de cores da aplicação, usando uma semente de cor.
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 182, 191, 233),
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
  late Casa casa; // A instância da casa que contém os cômodos.
  bool _isLoading = true; // Flag para indicar se os dados estão sendo carregados.
  // Serviço para persistência de dados (salvar e carregar a casa).
  final PersistenceService _persistenceService = PersistenceService(); 

  @override
  void initState() {
    super.initState();
    _loadData(); // Carrega os dados quando a tela é iniciada
  }

  // Função para carregar os dados
  Future<void> _loadData() async { 
    final loadedCasa = await _persistenceService.loadCasa();
    setState(() {
      casa = loadedCasa;
      _isLoading = false;
    });
  }

  // Função para salvar os dados
  Future<void> _saveData() async { 
    await _persistenceService.saveCasa(casa);
  }

  // Adiciona um novo cômodo à casa e salva os dados.
  void adicionarComodo(String nome, IconData icone) {
    setState(() {
      casa.adicionarComodo(nome, icone);
    });
    _saveData(); // SALVA AQUI!
  }

  // Função para mostrar o diálogo de adição de cômodo
  Future<void> _mostrarDialogoAdicionarComodo() async {
    final TextEditingController nomeComodoController = TextEditingController(); 

    // Lista de ícones que o usuário pode escolher
    final List<IconData> iconesDisponiveis = [
      Icons.bed,
      Icons.home,
      Icons.room,
      Icons.room_service,
      Icons.king_bed_outlined,
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
          : GridComodos(casa: casa,onDataChanged: _saveData),
      floatingActionButton: FloatingActionButton(
        // Botão para adicionar um novo cômodo.
        onPressed: _mostrarDialogoAdicionarComodo,
        tooltip: 'Adicionar Cômodo',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
