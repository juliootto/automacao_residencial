import 'package:automacao_residencial/classes/comodo.dart';
import 'package:flutter/material.dart';

/// Representa a casa como um todo, contendo uma lista de cômodos.
///
/// Esta classe gerencia a coleção de [Comodo]s presentes na residência,
/// permitindo adicionar, remover e reordenar cômodos.
class Casa {
  /// A lista de cômodos que compõem a casa.
  List<Comodo> comodos = [];

  /// Construtor que inicializa a casa com uma lista de cômodos.
  Casa(this.comodos);

  /// Construtor nomeado para criar uma instância de [Casa] vazia.
  /// Útil para inicializar a aplicação sem dados pré-existentes.
  Casa.vazia();

  void adicionarComodo(String nome,IconData icone) {
    comodos.add(Comodo(nome:nome,icone:icone));
  }

  void removerComodo(Comodo comodo) {
    comodos.remove(comodo);  
  }

  void moverComodo(Comodo comodo, int novaPosicao) {
    if (comodos.contains(comodo)) {
      comodos.remove(comodo);
      if (novaPosicao >= 0 && novaPosicao <= comodos.length) {
        comodos.insert(novaPosicao, comodo);
      }
    }       
  }

  // Converte um objeto Casa em um Map
  Map<String, dynamic> toJson() {
    return {
      'comodos': comodos.map((c) => c.toJson()).toList(),
    };
  }

  // Cria um objeto Casa a partir de um Map
  factory Casa.fromJson(Map<String, dynamic> json) {
    var listaDeComodosJson = json['comodos'] as List;
    List<Comodo> listaDeComodos =
        listaDeComodosJson.map((c) => Comodo.fromJson(c)).toList();

    return Casa(listaDeComodos);
  }
  
}
