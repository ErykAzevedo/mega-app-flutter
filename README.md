# Mega App

Um projeto Flutter moderno seguindo as melhores práticas da comunidade Dart/Flutter.

## 🚀 Configuração do Ambiente

### Pré-requisitos
- Flutter SDK (versão estável mais recente)
- Dart SDK 3.9.2+
- IDE com suporte a Flutter (VS Code, Android Studio, IntelliJ)

### Instalação
```bash
# Clone o repositório
git clone <repository-url>
cd mega_app

# Instale as dependências
flutter pub get

# Execute a aplicação
flutter run
```

## 📁 Estrutura do Projeto

```
lib/
├── core/                    # Funcionalidades centrais
│   ├── constants/          # Constantes globais
│   ├── errors/             # Classes de erro
│   ├── network/            # Configuração de rede
│   ├── theme/              # Tema da aplicação
│   └── utils/              # Utilitários
├── data/                   # Camada de dados
├── domain/                 # Regras de negócio
├── presentation/           # UI e gerenciamento de estado
└── main.dart
```

## 🛠️ Scripts de Desenvolvimento

```bash
# Análise de código
flutter analyze

# Formatação
dart format .

# Testes
flutter test

# Cobertura de testes
flutter test --coverage

# Build para produção
flutter build apk --release    # Android
flutter build ios --release    # iOS
flutter build web --release    # Web

# Limpeza e reinstalação
flutter clean && flutter pub get
```

## 📋 Padrões de Código

### Convenções de Nomenclatura
- **Classes**: PascalCase (`UserRepository`)
- **Métodos/Variáveis**: camelCase (`getUserData`)
- **Arquivos**: snake_case (`user_repository.dart`)
- **Constantes**: SCREAMING_SNAKE_CASE (`API_BASE_URL`)

### Estrutura de Classes
1. Construtores primeiro
2. Propriedades finais
3. Propriedades estáticas
4. Métodos override
5. Métodos privados por último

### Widgets
- Use `const` constructors sempre que possível
- Prefira composition over inheritance
- Mantenha métodos `build()` simples
- Extraia widgets complexos

## 🧪 Testes

```bash
# Executar todos os testes
flutter test

# Testes com cobertura
flutter test --coverage

# Testes específicos
flutter test test/unit/
flutter test test/widget/
```

## 🔧 Configuração do Analysis Options

O projeto está configurado com regras de linting rigorosas em `analysis_options.yaml`:

- Prefer single quotes
- Require trailing commas
- Prefer const constructors
- E muito mais...

## 📚 Recursos Úteis

- [COPILOT_INSTRUCTIONS.md](./COPILOT_INSTRUCTIONS.md) - Instruções detalhadas para desenvolvimento
- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Flutter Best Practices](https://docs.flutter.dev/development/best-practices)

## 🚀 Deployment

### Android
```bash
flutter build apk --release
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## 🤝 Contribuindo

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.
