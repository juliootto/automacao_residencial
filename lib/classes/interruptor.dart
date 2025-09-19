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

}
