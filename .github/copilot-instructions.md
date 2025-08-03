# Copilot Instructions for Appointment Flutter App

## Architecture Overview

This Flutter app follows a strict **inside/outside** separation pattern for testability:

- **Outside Layer** (`lib/outside/`): Singletons instantiated in `appRunner()` - client providers, effect providers, repositories
- **Inside Layer** (`lib/inside/`): Widget tree components - blocs, cubits, UI, routes  
- **Shared Layer** (`lib/shared/`): Common utilities and mixins
- **App Layer** (`lib/app/`): Bootstrap and configuration

All outside dependencies must pass through the "front door" (`appBuilder()`) to enable mocking in Flow Tests.

## Key Development Patterns

### State Management
- Uses `flutter_bloc` with strict separation: Blocs for application state, Cubits for entity state
- All state classes use `equatable` for comparison
- Effect providers handle side effects (analytics, auth changes)
- Repositories handle data access and business logic

### Code Generation
- **Build Runner**: Generates JSON serialization, auto_route files
- **Slang**: Generates i18n translations from `lib/inside/i18n/*.i18n.yaml`
- Always run `[App] Build Runner (Watch)` during development

### Naming Conventions
- Files/classes use underscore naming: `Auth_Bloc`, `auth_state.dart`
- Effect methods in providers return `Effect` objects
- Repository methods are async and handle business logic

### Widget Implementation
- **All widgets MUST be implemented as classes, never as helper methods**
- This ensures proper widget lifecycle, key handling, and performance optimization

## Essential Development Workflow

### Starting Development
1. Run `[App] Prebuild (Once)` - cleans, gets deps, runs slang + build_runner
2. Run `[Supabase] Start` - starts local Supabase stack
3. Run `[App] Build Runner (Watch)` - watches for code generation
4. Run `[App] Slang (Watch)` - watches for i18n changes

### Testing with Flow Tests
- Flow tests use `packages/flow_test` for integration testing
- Tests start with `testAppBuilder()` which mocks outside dependencies
- Run `[App] Test Gallery (Serve)` to view test screenshots at localhost:8001
- Use Code Lens "FlowTest" button to run individual tests

## Critical Integration Points

### Supabase Integration
- Configuration in `lib/outside/client_providers/supabase/`
- Auth state managed by `Auth_Bloc` listening to Supabase auth changes
- Local development uses `supabase start` for local stack

### Routing (auto_route)
- Router defined in `lib/inside/routes/router.dart` with `@AutoRouteConfig`
- Guards handle auth-based route protection
- Deep linking handled via `deep_link_handler.dart`

### Internationalization
- Uses `slang` package, config in `slang.yaml`
- Translations in `lib/inside/i18n/translations.i18n.yaml`
- Generated files: `translations.g.dart`

## Project Structure Specifics

```
app/lib/
├── app/           # Bootstrap, runner, builder, configurations
├── inside/        # Widget tree: blocs, routes, i18n, utils
├── outside/       # Singletons: client_providers, effect_providers, repositories, theme
└── shared/        # Common mixins, models
```

## VS Code Tasks Reference

- `[App] Prebuild (Once)` - Full clean build setup
- `[App] Build Runner (Watch)` - Live code generation
- `[Supabase] Start/Stop` - Local database stack
- `[App] Test Gallery (Serve)` - View Flow Test results
- `[Project] Documentation (Serve)` - MkDocs at localhost:8000

## Testing Strategy

- **Flow Tests**: End-to-end integration tests using widget testing
- **Unit Tests**: Individual component testing with mocktail
- **Golden Tests**: UI snapshot testing with golden_toolkit
- All outside dependencies are mockable through dependency injection

When implementing features, follow the inside/outside boundary strictly - instantiate singletons in `appRunner()`, pass through `appBuilder()`, and use proper state management patterns with flutter_bloc.
