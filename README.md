# Jardim Virtual

## Descrição

Jardim Virtual é um aplicativo mobile desenvolvido em Flutter com o objetivo de auxiliar no gerenciamento de plantas. O sistema permite cadastrar plantas, visualizar suas informações detalhadas, registrar cuidados realizados e consultar o histórico de manutenção de cada planta.

---

## Funcionalidades

### Cadastro de Plantas

O usuário pode registrar uma nova planta informando:

- Nome da planta;
- Espécie;
- Data de aquisição;
- Local onde a planta está armazenada;
- Foto da planta.

---

### Visualização da Ficha da Planta

Ao selecionar uma planta cadastrada, é exibida uma ficha contendo:

- Nome;
- Espécie;
- Data de aquisição;
- Local;
- Foto da planta;
- Histórico de cuidados realizados.

---

### Registro de Cuidados

Para cada planta é possível registrar cuidados, contendo:

- Tipo de cuidado (rega, poda, adubação, entre outros);
- Data em que o cuidado foi realizado;
- Observações adicionais.

---

### Histórico de Cuidados

Todos os cuidados registrados ficam armazenados no banco de dados e podem ser consultados posteriormente na ficha da planta.

---

## Tecnologias Utilizadas

- Flutter;
- Dart;
- SQLite (sqflite);
- Image Picker.

---

## Estrutura do Projeto

```text
lib/
│
├── controllers/
│   ├── planta_controller.dart
│   └── cuidado_controller.dart
│
├── database/
│   └── db_helper.dart
│
├── models/
│   ├── planta_model.dart
│   └── cuidado_model.dart
│
├── screens/
│   ├── home_screen.dart
│   ├── add_planta_screen.dart
│   ├── planta_detail_screen.dart
│   └── add_cuidado_screen.dart
│
└── main.dart
```

---

## Banco de Dados

O aplicativo utiliza SQLite para armazenamento local das informações.

### Tabela `plantas`

| Campo | Tipo | Descrição |
|---------|---------|-------------|
| id | INTEGER | Identificador da planta |
| nome | TEXT | Nome da planta |
| especie | TEXT | Espécie da planta |
| dataAquisicao | TEXT | Data de aquisição |
| local | TEXT | Local onde a planta está armazenada |
| foto | TEXT | Caminho da foto da planta |

---

### Tabela `cuidados`

| Campo | Tipo | Descrição |
|---------|---------|-------------|
| id | INTEGER | Identificador do cuidado |
| plantaId | INTEGER | Identificador da planta |
| tipo | TEXT | Tipo de cuidado realizado |
| data | TEXT | Data do cuidado |
| observacoes | TEXT | Observações adicionais |

---

## Relacionamento entre as Tabelas

O relacionamento entre as tabelas é do tipo **um para muitos (1:N)**.

Uma planta pode possuir diversos cuidados registrados, enquanto cada cuidado pertence a apenas uma planta.

```text
Planta (1) ────────── (N) Cuidados
```

---

## Requisitos Funcionais

- RF01: Permitir o cadastro de plantas;
- RF02: Permitir a visualização das informações de uma planta;
- RF03: Permitir o registro de cuidados para uma planta;
- RF04: Permitir a consulta do histórico de cuidados;
- RF05: Permitir o armazenamento de foto da planta.

---

## Requisitos Não Funcionais

- RNF01: O aplicativo deve ser desenvolvido utilizando Flutter;
- RNF02: Os dados devem ser armazenados localmente utilizando SQLite;
- RNF03: A interface deve ser simples e de fácil utilização;
- RNF04: O aplicativo deve funcionar em dispositivos Android.

---

## Instalação e Execução

### Pré-requisitos

- Flutter SDK instalado;
- Android SDK configurado;
- Emulador Android ou dispositivo físico.

### Instalação das dependências

```bash
flutter pub get
```

### Execução do projeto

```bash
flutter run
```

---

## Dependências Utilizadas

```yaml
dependencies:
  flutter:
    sdk: flutter

  sqflite: ^2.4.2
  path: ^1.9.1
  image_picker: ^1.1.2
```

---

## Fluxo de Utilização

```text
Tela Inicial
      ↓
Cadastrar Planta
      ↓
Selecionar Planta
      ↓
Visualizar Ficha da Planta
      ↓
Registrar Cuidado
      ↓
Atualizar Histórico de Cuidados
```

---
