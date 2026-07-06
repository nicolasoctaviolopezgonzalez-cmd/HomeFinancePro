# HomeFinance Pro

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue.svg)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.0+-blue.svg)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

## Descripción

HomeFinance Pro es una aplicación profesional de gestión de finanzas personales desarrollada en Flutter. Proporciona herramientas completas para rastrear ingresos, gastos, establecer presupuestos, crear metas financieras y analizar el comportamiento de gastos con gráficos interactivos.

## Características

✅ **Gestión de Transacciones**
- Registro de ingresos y gastos
- Categorización automática
- Etiquetas personalizadas
- Búsqueda y filtros avanzados

✅ **Presupuestos Inteligentes**
- Crear presupuestos por categoría
- Alertas de límites
- Análisis de cumplimiento
- Recomendaciones basadas en historial

✅ **Análisis y Reportes**
- Gráficos circulares y de barras
- Comparativas mes a mes
- Exportación a PDF
- Resumen de actividad

✅ **Metas Financieras**
- Establecer objetivos de ahorro
- Seguimiento de progreso
- Notificaciones automáticas
- Historial de metas completadas

✅ **Multi-plataforma**
- Android
- iOS
- Web

✅ **Base de Datos Local**
- SQLite sincronizado
- Sin necesidad de conexión a internet
- Sincronización opcional con Firebase

## Requisitos

- Flutter 3.0 o superior
- Dart 3.0 o superior
- Android SDK 21+ (para Android)
- iOS 12+ (para iOS)
- Navegador moderno (para Web)

## Instalación

### 1. Clonar el repositorio

```bash
git clone https://github.com/nicolasoctaviolopezgonzalez-cmd/HomeFinancePro.git
cd HomeFinancePro
```

### 2. Obtener dependencias

```bash
flutter pub get
```

### 3. Generar código

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 4. Ejecutar la aplicación

```bash
# Android
flutter run -d android

# iOS
flutter run -d ios

# Web
flutter run -d web
```

## Estructura del Proyecto

```
lib/
├── main.dart                 # Punto de entrada
├── config/
│   ├── app_config.dart
│   ├── database_config.dart
│   └── firebase_config.dart
├── core/
│   ├── constants/
│   ├── extensions/
│   ├── theme/
│   └── utils/
├── data/
│   ├── datasources/
│   ├── models/
│   ├── repositories/
│   └── local/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
├── presentation/
│   ├── bloc/
│   ├── pages/
│   ├── widgets/
│   └── routes/
└── services/
    ├── database_service.dart
    ├── auth_service.dart
    └── notification_service.dart
```

## Arquitectura

El proyecto sigue la arquitectura limpia con capas:

- **Presentation Layer**: Widgets, Pages, BLoC
- **Domain Layer**: Entities, Repositories (interfaces), UseCases
- **Data Layer**: Modelos, Repositorio (implementación), DataSources
- **Core Layer**: Utilidades, Constantes, Temas

## Contribuir

Las contribuciones son bienvenidas. Para cambios mayores, abre un issue primero para discutir qué te gustaría cambiar.

## Licencia

MIT License - Ver [LICENSE](LICENSE) para más detalles

## Autor

Nicolás Octavio López González

## Soporte

Para reportar bugs o sugerir características, abre un [GitHub Issue](https://github.com/nicolasoctaviolopezgonzalez-cmd/HomeFinancePro/issues)
