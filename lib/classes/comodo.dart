import 'package:automacao_residencial/classes/interruptor.dart';
import 'package:flutter/material.dart';
import 'package:automacao_residencial/utils/icon_mapper.dart'; 
/// Representa um Cômodo onde pode ser adicionado interruptores.
///

class Comodo {
  /// O nome do cômodo (ex: "Sala", "Quarto").
  String nome;

  /// Uma lista de interruptores associados a este cômodo.
  List<Interruptor> interruptores = [];

  /// O ícone que representa visualmente o cômodo.
  IconData icone;
  
  /// Construtor para criar uma instância de [Comodo].
  ///
  /// [nome] é o nome de exibição do cômodo.
  /// [icone] é o ícone que representa o cômodo (padrão: [Icons.home]).
  Comodo({
    required this.nome , this.icone = Icons.home,
  });

  /// Adiciona um novo [interruptor] à lista de interruptores do cômodo.
  void adicionarInterruptor(Interruptor interruptor) {
    interruptores.add(interruptor);
  }
  /// Adiciona um novo [interruptor] à lista de interruptores do cômodo.
  void removerInterruptor(Interruptor interruptor) {
    interruptores.remove(interruptor);
  }
  /// Converte um objeto [Comodo] em um [Map] para serialização JSON.
  ///
  /// Retorna um [Map] contendo o nome do cômodo,
  /// uma lista de interruptores serializados e
  /// o código e a família da fonte do ícone.
  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      // Converte cada interruptor da lista para o formato JSON
      // Usamos .map para converter cada Interruptor da lista em JSON
      'interruptores': interruptores.map((i) => i.toJson()).toList(),
      // Armazenamos o código do ícone, que é um int
      'icone_codePoint': icone.codePoint,
    };
  }

  /// Cria um objeto [Comodo] a partir de um [Map] desserializado de JSON.
  ///
  /// Este é um construtor de fábrica que reconstrói um objeto [Comodo]
  /// a partir dos dados armazenados em um [Map].
  factory Comodo.fromJson(Map<String, dynamic> json) {
    // Converte a lista de mapas JSON de volta para uma lista de objetos Interruptor
    var listaDeInterruptoresJson = json['interruptores'] as List;
    List<Interruptor> listaDeInterruptores =
        listaDeInterruptoresJson.map((i) => Interruptor.fromJson(i)).toList();

    return Comodo(
      nome: json['nome'],
      icone: getIconFromCodePoint(json['icone_codePoint']),
    )..interruptores = listaDeInterruptores; // Atribui a lista de interruptores reconstruída
  }
}