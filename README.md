 

# Flutter Pokteam

Este é um aplicativo simples construído com Flutter para consumir dados da [Pokémon API](https://pokeapi.co/) e exibir informações sobre Pokémon, como nome, habilidade e imagem. A arquitetura adotada para o projeto é baseada no padrão **Clean Architecture**, proporcionando uma separação clara das responsabilidades.

## Arquitetura

A arquitetura do projeto segue o padrão **Clean Architecture**, que organiza o código em camadas bem definidas para separar as responsabilidades e promover a escalabilidade e a testabilidade.

### Camadas da Arquitetura:

1. **Data** (ou Camada de Dados):
   - Esta camada é responsável por obter os dados da fonte de dados (no caso, a API do Pokémon).
   - Implementa os repositórios e fontes de dados, como o `PokemonApi` que se comunica com a API e retorna os dados.

   **Responsabilidades:**
   - Conectar-se com fontes externas (API, banco de dados, arquivos locais).
   - Fazer o parsing dos dados recebidos para um formato utilizável.
   - Implementar interfaces de repositório.

2. **Domain** (ou Camada de Domínio):
   - A camada de domínio é responsável pelas regras de negócio e pelos casos de uso. Ela contém a lógica que define o que o sistema pode fazer.
   - No nosso caso, temos o **caso de uso** `GetPokemonInfo`, que chama o repositório para obter informações sobre um Pokémon.

   **Responsabilidades:**
   - Definir a lógica de negócio.
   - Manter as entidades do domínio, como o modelo `Pokemon`.
   - Definir os casos de uso que o aplicativo precisa, como buscar dados do Pokémon.

3. **Presentation** (ou Camada de Apresentação):
   - A camada de apresentação é responsável pela interação com o usuário e pelo gerenciamento de estado.
   - Utilizamos o `ChangeNotifier` para gerenciar o estado da aplicação, notificando a interface sempre que há uma atualização nos dados.
   - A camada de apresentação também inclui as telas e widgets responsáveis por exibir os dados.

   **Responsabilidades:**
   - Exibir a interface do usuário.
   - Gerenciar o estado da interface (com o `ChangeNotifier` e `Provider`).
   - Notificar a interface sobre mudanças no estado.

### Fluxo de Dados

1. O **Widget de UI** solicita informações sobre um Pokémon para a **Camada de Apresentação**.
2. A **Camada de Apresentação** chama o **Caso de Uso** da **Camada de Domínio** (ex: `GetPokemonInfo`).
3. O **Caso de Uso** solicita dados para a **Camada de Dados**, que se comunica com a API (via `PokemonApi`).
4. A **Camada de Dados** obtém os dados e os envia de volta para a **Camada de Domínio**.
5. O **Caso de Uso** passa os dados para a **Camada de Apresentação**, que notifica a UI através do `ChangeNotifier`.
6. A **UI** exibe os dados para o usuário.

## Vídeo de Demonstração

Confira o vídeo de demonstração do projeto:

[Link para o vídeo no Loom](https://www.loom.com/share/19a3efab3a6647b0938141de5ae9a90e?sid=e0d52316-39bf-404c-82d8-4d07167b08b1)

 