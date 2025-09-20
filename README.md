# Automação Residencial 🏡

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)

Um aplicativo de automação residencial desenvolvido em Flutter para controlar múltiplos cômodos e dispositivos de forma simples e intuitiva. O projeto demonstra conceitos chave do Flutter, como gerenciamento de estado, persistência de dados local e consumo de APIs.

## ✨ Funcionalidades

-   **Gerenciamento de Cômodos:**
    -   Adicionar novos cômodos com nome e ícone personalizados.
    -   Editar as informações de cômodos existentes.
    -   Remover os cômodos que não são mais necessários.
-   **Controle de Dispositivos (Interruptores):**
    -   Adicionar múltiplos interruptores a cada cômodo.
    -   Ligar e desligar os interruptores individualmente.
    -   Editar o nome e configuração de cada interruptor.
-   **Persistência de Dados:**
    -   Todo o layout da casa (cômodos e estado dos interruptores) é salvo localmente.
    -   Ao fechar e reabrir o aplicativo, sua configuração é restaurada automaticamente.
-   **Comunicação com Hardware (Próximo Passo):**
    -   A estrutura está pronta para que cada interruptor envie requisições HTTP para controlar dispositivos reais (como ESP8266).

## 🚀 Tecnologias Utilizadas

-   **Framework:** [Flutter](https://flutter.dev/)
-   **Linguagem:** [Dart](https://dart.dev/)

## 📂 Estrutura do Projeto

O projeto segue uma arquitetura modular para facilitar a manutenção e escalabilidade.

-   **`main.dart`**: Ponto de entrada da aplicação e tela principal (`MyHomePage`).
-   **`screens/`**: Contém as telas principais da aplicação.
    -   `comodo_detalhes_screen.dart`: Tela que exibe os interruptores de um cômodo específico.
-   **`widgets/`**: Contém os widgets reutilizáveis.
    -   `grid_comodos.dart`: A grade que exibe todos os cômodos na tela inicial.
    -   `card_comodo.dart`: O widget individual para cada cômodo na grade.
    -   `interruptor_tile.dart`: O widget para cada interruptor na tela de detalhes.
-   **`classes/`**: Contém as classes e modelos da aplicação.
    -   `casa.dart`: Representa a casa, contendo uma lista de cômodos.
    -   `comodo.dart`: Representa um cômodo, com nome, ícone e lista de interruptores.
    -   `interruptor.dart`: Representa um dispositivo, com nome, estado (ligado/desligado) e URL para o comando.
-   **`services/`**:
    -   `persistence_service.dart`: Isola a lógica de salvar e carregar os dados da casa usando `shared_preferences`.

## 🏁 Como Executar o Projeto

1.  **Clone este repositório:**
    ```sh
    git clone https://github.com/juliootto/automacao_residencial.git
    ```
2.  **Entre no diretório do projeto:**
    ```sh
    cd automacao-residencial
    ```
3.  **Instale as dependências:**
    ```sh
    flutter pub get
    ```
4.  **Execute o aplicativo:**
    ```sh
    flutter run
    ```

## 🔮 Próximos Passos

-   [ ] Adicionar animações para uma experiência de usuário mais fluida.
-   [ ] Implementar um backend (como Firebase) para sincronizar a casa entre múltiplos dispositivos.

---

*Este projeto foi desenvolvido por Julio Otto como um exercício prático em Flutter.*