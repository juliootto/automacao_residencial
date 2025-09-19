import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:automacao_residencial/classes/casa.dart';

class PersistenceService {
  /// Chave estática usada para armazenar e recuperar os dados da casa no SharedPreferences.
  static const _key = 'casa_data'; // Chave para salvar os dados

  /// Salva o estado atual do objeto [Casa] no armazenamento persistente.
  ///
  /// Converte o objeto [Casa] em um formato JSON e o armazena usando
  /// [SharedPreferences].
  ///
  /// Parâmetros:
  /// - [casa]: O objeto [Casa] a ser salvo.
  Future<void> saveCasa(Casa casa) async {
    // Obtém uma instância do SharedPreferences.
    final prefs = await SharedPreferences.getInstance();
    // 1. Converte o objeto Casa para um Map (toJson)
    // 2. Codifica o Map em uma string JSON
    String casaJson = jsonEncode(casa.toJson());
    // 3. Salva a string no SharedPreferences
    await prefs.setString(_key, casaJson);
  }

  /// Carrega o estado da casa a partir do armazenamento persistente.
  ///
  /// Recupera a string JSON do [SharedPreferences], decodifica-a e
  /// reconstrói um objeto [Casa]. Se não houver dados salvos,
  /// retorna uma nova instância de [Casa.vazia()].
  ///
  /// Retorna: Um [Future] que resolve para o objeto [Casa] carregado.
  Future<Casa> loadCasa() async {
    final prefs = await SharedPreferences.getInstance();
    // 1. Tenta obter a string JSON associada à chave '_key'.
    String? casaJson = prefs.getString(_key);

    if (casaJson != null) {
      // 2. Decodifica a string JSON para um Map
      // 3. Converte o Map de volta para um objeto Casa (fromJson)
      return Casa.fromJson(jsonDecode(casaJson));
    } else {
      // Se não houver dados salvos, retorna uma casa nova e vazia
      return Casa.vazia(); // Retorna uma casa vazia se nenhum dado for encontrado.
    }
  }
}