# Eventos Underground App

Una aplicación móvil para promocionar bandas underground y juntadas electro, funcionando como una red social.

## Características

- Registro y autenticación de usuarios
- Lista de eventos con detalles
- Mapa integrado para ubicaciones
- Sistema de calificaciones (rating)
- Subida de imágenes
- Funcionalidades sociales (en desarrollo)

## Requisitos

- Flutter SDK instalado
- Android Studio o Xcode para emuladores
- Proyecto Firebase configurado

## Configuración

1. Instalar Flutter: https://flutter.dev/docs/get-started/install
2. Crear proyecto Firebase: https://console.firebase.google.com/
3. Agregar google-services.json (Android) y GoogleService-Info.plist (iOS) a las carpetas correspondientes
4. Obtener API key de Google Maps y agregarla a AndroidManifest.xml y Info.plist
5. Ejecutar `flutter pub get`
6. Ejecutar `flutter run`

## Estructura del Proyecto

- lib/models: Modelos de datos (Event, User)
- lib/providers: Providers para state management (Auth, Events)
- lib/screens: Pantallas de la app (Login, Home, etc.)
- lib/widgets: Widgets reutilizables

## Próximos Pasos

- Implementar funcionalidades sociales completas
- Mejorar UI/UX
- Agregar notificaciones push
- Integrar pagos para tickets
