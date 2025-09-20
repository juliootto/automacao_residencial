import 'package:http/http.dart' as http;
/// Representa um interruptor inteligente em um cômodo.
///
/// Cada interruptor possui um [nome], um [estado] (ligado/desligado)
/// e uma [url] para comunicação com o dispositivo físico.
class Interruptor {
  String nome;
  bool estado;
  String url;

  /// Construtor para criar uma instância de [Interruptor].
  ///
  /// [nome] é o nome de exibição do interruptor.
  /// [estado] indica se o interruptor está ligado (`true`) ou desligado (`false`).
  /// [url] é o endereço para controlar o interruptor (opcional, padrão vazio).
  Interruptor({
    required this.nome,
    required this.estado,
    this.url = '',
  });

  /// Converte um objeto [Interruptor] em um [Map] para serialização JSON.
  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'estado': estado,
      'url': url,
    };
  }

  /// Cria um objeto [Interruptor] a partir de um [Map] desserializado de JSON.
  factory Interruptor.fromJson(Map<String, dynamic> json) {
    return Interruptor(
      nome: json['nome'],
      estado: json['estado'],
      url: json['url'],
    );
  }


/// Alterna o estado do interruptor (ligado/desligado) e interage com a API do dispositivo.
///
/// Primeiro, verifica o estado atual do dispositivo através da API. Se o estado local
/// estiver dessincronizado com o estado real do dispositivo, ele é atualizado.
/// Em seguida, envia um comando para a URL do interruptor para mudar seu estado.
///
/// Retorna um [Future<bool>] que resolve para o novo estado do interruptor após a tentativa de mudança.
Future<bool> mudaInterruptor() async {
  // Declaração da variável para a URL da API.
  Uri urlParse;
  // Obtém o estado atual do interruptor diretamente do dispositivo.
  bool estadoAtual = await atualizaEstado();
  // Se o estado local estiver diferente do estado real do dispositivo, sincroniza.
  if (estado!=estadoAtual) {
    estado = estadoAtual;
    return estado;
  }
  
  // Determina a URL da API com base no estado atual (para ligar ou desligar).
  if (!estado) {
    urlParse = Uri.parse('http://$url/relay?do=on');
  }
    else{
      urlParse = Uri.parse('http://$url/relay?do=off');
  }

  try { // Tenta fazer a requisição HTTP.
    // Envia a requisição GET para a URL do dispositivo.
    final response = await http.get(urlParse);

    // Verifica se a requisição foi bem-sucedida (statusCode 200 significa OK)
    if (response.statusCode == 200) {
      // Se a resposta for OK, alterna o estado
      estado = !estado;
      return estado;
    }  
     return estado;
  } catch (e) { // Em caso de erro na requisição, retorna o estado sem alteração.
    return estado;
  }
}

/// Consulta o estado atual do interruptor diretamente do dispositivo via API.
///
/// Envia uma requisição GET para a URL de status do interruptor e atualiza
/// o estado local (`estado`) com base na resposta.
///
/// Retorna um [Future<bool>] que resolve para o estado atualizado do interruptor.
Future<bool> atualizaEstado() async {
  // Declaração da variável para a URL da API.
  Uri urlParse;
  // Constrói a URL para obter o status do dispositivo.
  urlParse = Uri.parse('http://$url/getStatus');
   try { // Tenta fazer a requisição HTTP.
    // Envia a requisição GET para a URL de status.
    final response = await http.get(urlParse);
    // Verifica se a requisição foi bem-sucedida (código de status 200).
    if (response.statusCode == 200) {
      if (response.body=='ON') {
        estado = true;
      }
      else{
        estado = false;
      }
      return estado;
    }  
     return estado;
  } catch (e) { // Em caso de erro na requisição, retorna o estado atual sem alteração.
    return estado;
  }
}
}
