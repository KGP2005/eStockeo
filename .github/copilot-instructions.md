# eStockeo Flutter App - AI Coding Assistant Instructions

## Project Overview
**eStockeo** is a Flutter e-commerce app for fashion browsing and purchasing in Latin America. Key tech stack:
- **Backend**: Supabase (auth + database)
- **State Management**: ChangeNotifier pattern with controllers
- **UI**: TikTok-like vertical feed for product discovery
- **Navigation**: Custom bottom navigation with badge system

## Architecture Patterns

### Page-Controller Structure
Every major page follows this pattern:
```
lib/Pages/[FeatureName]/
├── [feature]_page.dart          # UI (StatefulWidget)
├── [feature]_controller.dart    # State management (ChangeNotifier)
└── steps/                       # Multi-step flows (optional)
```

**Example**: `lib/Pages/Carrito/carrito_page.dart` + `carrito_controller.dart`

### Service Layer
Located in `lib/Services/` - handles external integrations:
- `login_service.dart` - Supabase authentication pattern
- `Assistant/` - AI integration services
- Pattern: Return `Map<String, dynamic>` with `success: bool` + error handling

### Navigation Architecture
- **Main Entry**: `LoginPage` → `HomeExplorador` (post-auth)
- **Home Structure**: PageView with custom `NavBar` component
- **Controller Sharing**: `HomeExploradorController` manages `CarritoController` for cart badge updates
- **No Named Routes**: Direct `Navigator.push` with `MaterialPageRoute`

## Development Conventions

### Import Strategy
- **Relative imports** for internal files: `import '../../Services/Assistant/assistant_api.dart'`
- **Package imports** for external dependencies: `import 'package:supabase_flutter/supabase_flutter.dart'`

### State Management Pattern
```dart
class FeatureController extends ChangeNotifier {
  // Private state
  final List<Type> _data = [];
  
  // Public getters
  List<Type> get data => _data;
  
  // Actions with notifyListeners()
  void updateData() {
    // logic
    notifyListeners();
  }
}
```

### Error Handling Pattern
```dart
try {
  // API call
  return {'success': true, 'data': result};
} catch (e) {
  print('=== ERROR GENERAL ===');
  print('Error: $e');
  return {'success': false, 'error': e.toString()};
}
```

## Key Integrations

### Supabase Setup
Initialized in `main.dart` with hardcoded credentials. Auth state managed in `LoginService`.

### UI Patterns
- **Colors**: Primary `Color(0xFF673AB7)` (deep purple), secondary `Colors.deepPurple`
- **Loading States**: `CircularProgressIndicator` with `setState(_loading = true)`
- **Forms**: `TextEditingController` + validation patterns in login/register flows
- **Feed UI**: Vertical `PageView` with overlay controls (inspired by TikTok)

### Data Structures
Products use `Map<String, dynamic>` format:
```dart
{
  'title': String,
  'price': double,
  'image': String,
  'size': String,
  'color': String,
  'cantidad': int,
  'seleccionado': bool
}
```

## Critical Workflows

### Development Setup
```bash
flutter pub get
flutter run
```

### Git Workflow (per README.md)
```bash
git checkout [branch-name]
git pull origin main
# make changes
git add .
git commit -m "descriptive message"
git push origin [branch-name]
# merge to main when ready
```

### Adding New Features
1. Create page-controller pair in `lib/Pages/[Feature]/`
2. Follow `ChangeNotifier` pattern for state
3. Import services with relative paths
4. Handle errors with consistent pattern
5. Update navigation in relevant controllers

### Assistant Integration
New AI features go in `lib/Services/Assistant/`:
- `assistant_contract.dart` - Abstract interface
- `assistant_api.dart` - OpenAI implementation
- Follow existing service error handling patterns

## Testing
- Test files in `test/` directory
- Primary test: `widget_test.dart`
- Use `flutter test` for execution