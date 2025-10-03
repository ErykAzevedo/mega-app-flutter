# Instruções para o Agente Copilot - Projeto Flutter Mega App

## Visão Geral do Projeto
Este é um projeto Flutter moderno seguindo as melhores práticas da comunidade Dart/Flutter. O projeto está configurado com Dart SDK 3.9.2+ e Flutter na versão mais recente.

## Arquitetura e Estrutura de Pastas

### Estrutura Recomendada
Mantenha e expanda a seguinte estrutura de pastas conforme o projeto cresce:

```
lib/
  ├── core/                    # Funcionalidades centrais do app
  │   ├── constants/          # Constantes globais (colors, strings, etc.)
  │   ├── errors/             # Classes de erro customizadas
  │   ├── network/            # Configuração de rede (Dio, interceptors)
  │   ├── theme/              # Tema da aplicação
  │   └── utils/              # Utilitários e helpers
  ├── data/                   # Camada de dados
  │   ├── datasources/        # Data sources (API, local storage)
  │   ├── models/             # Modelos de dados
  │   └── repositories/       # Implementações de repositórios
  ├── domain/                 # Regras de negócio
  │   ├── entities/           # Entidades de domínio
  │   ├── repositories/       # Interfaces de repositórios
  │   └── usecases/           # Casos de uso
  ├── presentation/           # Camada de apresentação
  │   ├── pages/              # Páginas/telas do app
  │   ├── widgets/            # Widgets reutilizáveis
  │   ├── bloc/               # Gerenciamento de estado (BLoC)
  │   └── providers/          # Providers (se usando Provider)
  └── main.dart               # Ponto de entrada da aplicação
```

## Padrões de Código e Melhores Práticas

### 1. Nomenclatura
- **Classes**: Use `PascalCase` (ex: `MyHomePage`, `UserRepository`)
- **Métodos e variáveis**: Use `camelCase` (ex: `getUserData`, `isLoading`)
- **Arquivos**: Use `snake_case` (ex: `user_repository.dart`, `home_page.dart`)
- **Constantes**: Use `SCREAMING_SNAKE_CASE` (ex: `API_BASE_URL`, `DEFAULT_TIMEOUT`)

### 2. Estrutura de Classes
```dart
class MyWidget extends StatelessWidget {
  // 1. Construtores sempre primeiro
  const MyWidget({
    super.key,
    required this.title,
    this.subtitle,
  });

  // 2. Propriedades finais
  final String title;
  final String? subtitle;

  // 3. Propriedades estáticas
  static const double defaultPadding = 16.0;

  // 4. Métodos override
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  // 5. Métodos privados por último
  void _privateMethod() {}
}
```

### 3. Widgets Responsivos
Sempre considere diferentes tamanhos de tela:

```dart
class ResponsiveWidget extends StatelessWidget {
  const ResponsiveWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          return _buildDesktopLayout();
        } else if (constraints.maxWidth > 600) {
          return _buildTabletLayout();
        } else {
          return _buildMobileLayout();
        }
      },
    );
  }
}
```

### 4. Gerenciamento de Estado
Prefira **BLoC** ou **Riverpod** para gerenciamento de estado complexo:

```dart
// Exemplo com BLoC
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState()) {
    on<CounterIncrement>(_onIncrement);
    on<CounterDecrement>(_onDecrement);
  }

  void _onIncrement(CounterIncrement event, Emitter<CounterState> emit) {
    emit(state.copyWith(count: state.count + 1));
  }

  void _onDecrement(CounterDecrement event, Emitter<CounterState> emit) {
    emit(state.copyWith(count: state.count - 1));
  }
}
```

### 5. Modelos de Dados
Use classes imutáveis com `copyWith` e `toJson/fromJson`:

```dart
class User {
  const User({
    required this.id,
    required this.name,
    required this.email,
  });

  final String id;
  final String name;
  final String email;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
}
```

## Dependências Recomendadas

### Core Dependencies
```yaml
dependencies:
  # Estado
  flutter_bloc: ^8.1.6
  # ou
  riverpod: ^2.4.9
  
  # Networking
  dio: ^5.4.0
  
  # Navegação
  go_router: ^13.2.0
  
  # Injeção de dependência
  get_it: ^7.6.7
  
  # Storage local
  shared_preferences: ^2.2.2
  hive: ^2.2.3
  
  # Utils
  freezed_annotation: ^2.4.1
  json_annotation: ^4.8.1

dev_dependencies:
  # Geração de código
  build_runner: ^2.4.7
  freezed: ^2.4.7
  json_serializable: ^6.7.1
  
  # Testes
  mockito: ^5.4.4
  bloc_test: ^9.1.5
```

## Tratamento de Erros

### 1. Classes de Erro Customizadas
```dart
abstract class AppException implements Exception {
  const AppException(this.message);
  final String message;
}

class NetworkException extends AppException {
  const NetworkException(super.message);
}

class ValidationException extends AppException {
  const ValidationException(super.message);
}
```

### 2. Result Pattern
```dart
sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  const Success(this.data);
  final T data;
}

class Failure<T> extends Result<T> {
  const Failure(this.exception);
  final AppException exception;
}
```

## Acessibilidade (a11y)

Sempre inclua suporte a acessibilidade:

```dart
Widget build(BuildContext context) {
  return Semantics(
    label: 'Incrementar contador',
    button: true,
    child: FloatingActionButton(
      onPressed: _incrementCounter,
      tooltip: 'Incrementar',
      child: const Icon(Icons.add),
    ),
  );
}
```

## Testes

### 1. Estrutura de Testes
```
test/
  ├── unit/                   # Testes unitários
  │   ├── data/
  │   ├── domain/
  │   └── presentation/
  ├── widget/                 # Testes de widgets
  └── integration/            # Testes de integração
```

### 2. Exemplo de Teste de Widget
```dart
testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  await tester.pumpWidget(const MyApp());

  expect(find.text('0'), findsOneWidget);
  expect(find.text('1'), findsNothing);

  await tester.tap(find.byIcon(Icons.add));
  await tester.pump();

  expect(find.text('0'), findsNothing);
  expect(find.text('1'), findsOneWidget);
});
```

## Performance

### 1. Otimizações de Build
- Use `const` constructors sempre que possível
- Evite criar widgets desnecessários no método `build()`
- Use `ListView.builder()` para listas grandes

### 2. Lazy Loading
```dart
class LazyList extends StatelessWidget {
  const LazyList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(items[index].title),
        );
      },
    );
  }
}
```

## Segurança

### 1. Validação de Inputs
```dart
String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email é obrigatório';
  }
  
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!emailRegex.hasMatch(value)) {
    return 'Email inválido';
  }
  
  return null;
}
```

### 2. Armazenamento Seguro
```dart
// Para dados sensíveis, use flutter_secure_storage
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

await storage.write(key: 'token', value: 'jwt_token_here');
String? token = await storage.read(key: 'token');
```

## Internacionalização (i18n)

Configure suporte a múltiplos idiomas desde o início:

```dart
// pubspec.yaml
dependencies:
  flutter_localizations:
    sdk: flutter
  intl: any

// main.dart
MaterialApp(
  localizationsDelegates: const [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: const [
    Locale('en', ''),
    Locale('pt', 'BR'),
  ],
)
```

## Configuração de Ambiente

Use diferentes configurações para dev/prod:

```dart
enum Environment { development, staging, production }

class Config {
  static Environment get environment {
    const env = String.fromEnvironment('ENV', defaultValue: 'development');
    return Environment.values.firstWhere(
      (e) => e.name == env,
      orElse: () => Environment.development,
    );
  }

  static String get apiBaseUrl {
    switch (environment) {
      case Environment.development:
        return 'https://dev-api.example.com';
      case Environment.staging:
        return 'https://staging-api.example.com';
      case Environment.production:
        return 'https://api.example.com';
    }
  }
}
```

## Comandos Úteis

```bash
# Análise de código
flutter analyze

# Formatação
dart format .

# Testes
flutter test

# Build para produção
flutter build apk --release
flutter build ios --release

# Geração de código
dart run build_runner build --delete-conflicting-outputs
```

## Linting Rules Adicionais

Adicione ao `analysis_options.yaml`:

```yaml
linter:
  rules:
    # Estilo
    prefer_single_quotes: true
    require_trailing_commas: true
    prefer_const_constructors: true
    prefer_const_declarations: true
    
    # Performance
    avoid_function_literals_in_foreach_calls: true
    prefer_for_elements_to_map_fromIterable: true
    
    # Segurança
    avoid_web_libraries_in_flutter: true
    
    # Manutenibilidade
    avoid_catches_without_on_clauses: true
    avoid_catching_errors: true
```

## Diretrizes Específicas para o Copilot

1. **Sempre use `const` constructors** quando os widgets são imutáveis
2. **Prefira composition over inheritance** ao criar widgets customizados
3. **Mantenha métodos `build()` simples** - extraia widgets complexos
4. **Use `late` apenas quando necessário** e sempre inicialize
5. **Implemente `toString()`, `==` e `hashCode`** em classes de dados
6. **Use `sealed classes` para enums complexos** no Dart 3.0+
7. **Sempre trate null safety** adequadamente
8. **Documente APIs públicas** com dartdoc comments
9. **Use `extension methods`** para funcionalidades auxiliares
10. **Implemente testes** para toda nova funcionalidade

Lembre-se: **Simplicidade, Legibilidade e Performance** são os pilares do bom código Flutter!