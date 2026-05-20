# Análise Completa e Arquitetura do Sistema ChoppOn

## 1. Visão Geral do Sistema Atual

O sistema **ChopponERP** é uma plataforma PHP/MySQL que gerencia estabelecimentos de chopp self-service (TAPs). O sistema possui um painel administrativo web e uma API REST que se comunica com o aplicativo Android atual (**ChopponAndroid**) e com os dispositivos ESP32 nas torneiras (TAPs).

### 1.1. Estrutura do Banco de Dados

O banco de dados relacional (MySQL) possui as seguintes tabelas principais:

*   **`users`**: Usuários do sistema administrativo (Admin Geral, Gerente, Operador, Visualizador).
*   **`estabelecimentos`**: Lojas/franquias cadastradas no sistema.
*   **`user_estabelecimento`**: Relacionamento N:N entre usuários e estabelecimentos.
*   **`clientes`**: Clientes finais (consumidores) com dados completos (nome, CPF, email, telefone, endereço, data de nascimento, pontos de cashback, total consumido).
*   **`clientes_consumo`**: Histórico de consumo dos clientes (pedido, bebida, quantidade, valor, pontos ganhos).
*   **`bebidas`**: Cadastro de bebidas disponíveis.
*   **`tap`**: Cadastro das torneiras (TAPs), vinculadas a bebidas e estabelecimentos, com controle de volume, status e MAC address do ESP32.
*   **`order`**: Pedidos/vendas realizadas.
*   **`payment`**: Configurações de pagamento (SumUp, PIX, etc.).
*   **`cashback_regras`**, **`cashback_historico`**, **`cashback_config`**: Sistema completo de fidelidade e pontuação.

### 1.2. Regras de Negócio Identificadas

1.  **Hierarquia de Acesso**: O sistema possui um Admin Geral (acesso a tudo) e usuários vinculados a estabelecimentos específicos.
2.  **Sistema de Cashback/Pontos**: Clientes acumulam pontos baseados em regras configuráveis (percentual, valor fixo, pontos por real) e podem resgatá-los.
3.  **Consumo**: O consumo é medido em mililitros (ml) e o valor é calculado com base no preço da bebida configurada na TAP.
4.  **Pagamentos**: Integração com SumUp (cartão) e PIX (Mercado Pago/Stripe/Cora).
5.  **Acesso Master (Easter Egg)**: O app atual possui um acesso técnico oculto (7 cliques na logo) que permite login com credenciais de admin para configurar TAPs, calibrar pulsos e gerenciar pagamentos.

### 1.3. Estrutura da API Atual

A API atual (`/api/`) é baseada em scripts PHP individuais (ex: `login.php`, `bebidas.php`, `taps.php`, `create_order.php`). A autenticação é feita via JWT (JSON Web Tokens), com o token sendo passado no header `Token`.

---

## 2. Arquitetura Proposta para o Novo App Flutter

O novo aplicativo Flutter será construído utilizando **Clean Architecture** para garantir escalabilidade, testabilidade e manutenção a longo prazo.

### 2.1. Padrões e Tecnologias

*   **Framework**: Flutter (Dart)
*   **Gerenciamento de Estado**: Riverpod (recomendado por ser robusto e seguro em tempo de compilação)
*   **Injeção de Dependência**: GetIt
*   **Navegação**: GoRouter
*   **Cliente HTTP**: Dio (com interceptors para JWT)
*   **Armazenamento Local**: Hive ou SharedPreferences (para cache offline e tokens)
*   **Notificações**: Firebase Cloud Messaging (FCM)
*   **Analytics/Crashlytics**: Firebase

### 2.2. Camadas da Clean Architecture

1.  **Domain (Regras de Negócio)**
    *   `Entities`: Modelos de dados puros (ex: `User`, `Cliente`, `Consumo`, `Tap`).
    *   `Repositories`: Interfaces (contratos) para acesso a dados.
    *   `UseCases`: Casos de uso da aplicação (ex: `LoginUseCase`, `GetExtratoUseCase`).

2.  **Data (Acesso a Dados)**
    *   `Models`: Extensões das entidades com métodos `fromJson` e `toJson`.
    *   `RepositoriesImpl`: Implementação das interfaces do Domain.
    *   `DataSources`: Fontes de dados (Remote via Dio, Local via Hive).

3.  **Presentation (Interface do Usuário)**
    *   `Pages/Screens`: Telas do aplicativo.
    *   `Widgets`: Componentes reutilizáveis.
    *   `Providers/Controllers`: Gerenciadores de estado (Riverpod) que conectam a UI aos UseCases.

### 2.3. Estrutura de Diretórios (Flutter)

```text
lib/
├── core/
│   ├── constants/       # Cores, temas, strings
│   ├── error/           # Tratamento de exceções e falhas
│   ├── network/         # Configuração do Dio, Interceptors
│   ├── routes/          # Configuração do GoRouter
│   └── utils/           # Funções utilitárias, formatadores (CPF, Moeda)
├── features/
│   ├── auth/            # Autenticação (Login, Recuperar Senha)
│   ├── profile/         # Cadastro e Perfil do Cliente
│   ├── dashboard/       # Tela inicial, saldo, atalhos
│   ├── points/          # Sistema de pontos e cashback
│   ├── history/         # Extrato de consumo
│   ├── ranking/         # Ranking nacional e por cidade
│   ├── locations/       # Unidades e geolocalização
│   └── admin/           # Acesso Master (Easter Egg)
└── main.dart            # Ponto de entrada
```

---

## 3. Nova Estrutura de API REST (PHP)

Para suportar o novo aplicativo de forma organizada, será criada uma nova estrutura de API versionada (`/api/v1/`), mantendo a compatibilidade com o sistema existente.

### 3.1. Endpoints Propostos (`/api/v1/`)

**Autenticação (`/api/v1/auth/`)**
*   `POST /login`: Autenticação de clientes (CPF e senha).
*   `POST /admin-login`: Autenticação de técnicos/admins (Email e senha).
*   `POST /refresh`: Atualização do token JWT.
*   `POST /logout`: Invalidação do token.

**Clientes (`/api/v1/clientes/`)**
*   `POST /register`: Cadastro de novo cliente.
*   `GET /profile`: Obter dados do perfil.
*   `PUT /profile`: Atualizar dados do perfil.
*   `POST /avatar`: Upload de foto de perfil.

**Pontos e Cashback (`/api/v1/pontos/`)**
*   `GET /saldo`: Obter saldo atual e pontos a expirar.
*   `GET /historico`: Histórico de entradas e saídas de pontos.

**Extrato (`/api/v1/extrato/`)**
*   `GET /consumo`: Histórico de consumo (com paginação e filtros).
*   `GET /consumo/{id}/pdf`: Exportar recibo em PDF.

**Ranking (`/api/v1/ranking/`)**
*   `GET /nacional`: Top 10 usuários do sistema.
*   `GET /cidade`: Top 10 usuários da cidade do cliente.

**Unidades (`/api/v1/unidades/`)**
*   `GET /list`: Listar unidades próximas (baseado em lat/lng).
*   `GET /{id}`: Detalhes da unidade (status, horário, endereço).

**Notificações (`/api/v1/notificacoes/`)**
*   `POST /device-token`: Registrar token do FCM.
*   `GET /list`: Histórico de notificações do usuário.

### 3.2. Segurança e Validações

*   **JWT**: Tokens com expiração curta e Refresh Tokens.
*   **Middleware**: Verificação de token e permissões em todas as rotas protegidas.
*   **Validação de Dados**: Reutilização das regras de negócio do Laravel/PHP (validação de CPF, email único, etc.).
*   **Rate Limiting**: Proteção contra brute force nos endpoints de login.

---

## 4. Fluxos Principais do Aplicativo

### 4.1. Fluxo de Login e Acesso Master
1.  Tela inicial exibe logo da ChoppOn e campos para CPF e Senha.
2.  Login normal: Autentica na rota `/api/v1/auth/login` e direciona para o Dashboard.
3.  Acesso Master: Usuário clica 7 vezes na logo. A tela muda para Email e Senha. Autentica na rota `/api/v1/auth/admin-login` e direciona para o painel técnico (ServiceTools).

### 4.2. Fluxo de Cadastro
1.  Usuário preenche formulário completo (Nome, CPF, Email, Telefone, Endereço, etc.).
2.  App valida CPF e CEP localmente.
3.  Envia para `/api/v1/clientes/register`.
4.  Backend valida duplicidade e regras de negócio.
5.  Retorna sucesso e faz login automático.

### 4.3. Fluxo de Dashboard e Gamificação
1.  App busca perfil, saldo de pontos e últimos consumos.
2.  Exibe saudação dinâmica e foto de perfil.
3.  Exibe barra de progresso para o próximo nível/medalha.
4.  Permite navegação rápida para Extrato, Ranking e Unidades.

## 5. Próximos Passos

1.  **Fase 3**: Criar a estrutura base do projeto Flutter (pastas, dependências, rotas).
2.  **Fase 4**: Desenvolver os endpoints da API REST (`/api/v1/`) no servidor PHP.
3.  **Fase 5**: Implementar as telas e lógica de Autenticação e Cadastro no Flutter.
4.  **Fase 6**: Implementar Dashboard, Pontos, Extrato e Ranking.
5.  **Fase 7**: Implementar Unidades, Notificações e Acesso Master.
6.  **Fase 8**: Documentação final e guias de deploy.
