# ChoppOn - Aplicativo Cliente (Flutter)

Aplicativo oficial de fidelidade e consumo para clientes da rede ChoppOn.

## Arquitetura
O projeto foi desenvolvido utilizando **Clean Architecture** e **Riverpod** para gerenciamento de estado, garantindo escalabilidade e fácil manutenção.

## Funcionalidades
- **Login e Autenticação JWT**: Segurança completa com tokens.
- **Dashboard Gamificado**: Visualização de pontos, saldo e últimos consumos.
- **Sistema de Pontos e Cashback**: Histórico completo de entradas e saídas.
- **Extrato de Consumo**: Detalhamento de cada chopp consumido.
- **Ranking**: Competição nacional e por cidade.
- **Unidades**: Mapa com geolocalização das lojas mais próximas.
- **Acesso Master (Easter Egg)**: 7 cliques na logo da tela de login abrem o painel técnico para configuração de TAPs.

## Como Executar
1. Certifique-se de ter o Flutter SDK instalado (versão 3.19+).
2. Clone o repositório.
3. Execute `flutter pub get` para instalar as dependências.
4. Execute `flutter run` para iniciar o aplicativo.

## Estrutura de Pastas
- `lib/core/`: Configurações globais, rotas, temas e utilitários.
- `lib/features/`: Módulos do aplicativo separados por domínio (auth, dashboard, points, etc).
  - `data/`: Modelos, repositórios e fontes de dados (API).
  - `domain/`: Entidades e casos de uso (regras de negócio).
  - `presentation/`: Telas, widgets e provedores de estado.
