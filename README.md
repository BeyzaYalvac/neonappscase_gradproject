# CloudIt 📂☁️

CloudIt, Flutter ile geliştirilmiş **Google Drive benzeri bir bulut depolama uygulamasıdır**.  
Uygulama **Clean Architecture** prensipleri, **Dependency Injection (DI)** ve **offline cache** desteği ile tasarlanmıştır.  

---

## 🚀 Özellikler

- 📂 **Klasör Yönetimi**
  - Klasör oluşturma, listeleme, silme
  - Favorilere ekleme/silme (Hive ile kalıcı)
- 📑 **Dosya Yönetimi**
  - Dosya yükleme, indirme, taşıma
  - Silme ve yeniden adlandırma
- 🖼️ **Resim Yönetimi**
  - Galeri görünümü
  - Filtreleme ve önizleme
- 🔍 **Arama**
  - Dosya, klasör ve resimler için ayrı filtreleme
- 📶 **Offline Desteği**
  - İnternet bağlantısı yokken cache üzerinden çalışma
- 🌗 **Tema Yönetimi**
  - Light/Dark theme (Hive üzerinden kalıcı)
- 🔔 **Network Durumu Takibi**
  - ConnectivityPlus ile bağlantı değişikliklerini izleme
- 🎮 **Gelişmiş UI**
  - DraggableScrollableSheet tabanlı bottom sheet
  - Expandable FAB (Floating Action Button)
  - Animasyonlu widget’lar ve Lottie animasyonları

---

## 🛠 Teknolojiler ve Kullanılan Paketler

### Çekirdek
- [Flutter](https://flutter.dev)
- [Dart](https://dart.dev)

### State Management
- [flutter_bloc](https://pub.dev/packages/flutter_bloc)

### Dependency Injection
- [get_it](https://pub.dev/packages/get_it)

### Cache & Persistence
- [hive](https://pub.dev/packages/hive)
- [hive_flutter](https://pub.dev/packages/hive_flutter)

### Network
- [dio](https://pub.dev/packages/dio)  
  - LoggerInterceptor  
  - CacheInterceptor  
  - RetryInterceptor  
  - ErrorLoggingInterceptor  

### Connectivity
- [connectivity_plus](https://pub.dev/packages/connectivity_plus)
- [internet_connection_checker_plus](https://pub.dev/packages/internet_connection_checker_plus)

### Routing
- [auto_route](https://pub.dev/packages/auto_route)

### UI/UX
- [lottie](https://pub.dev/packages/lottie)  
- Custom Expandable FAB  
- DraggableScrollableSheet  
- Custom SearchBar  

### Ortam Değişkenleri
- [flutter_dotenv](https://pub.dev/packages/flutter_dotenv)

---

## 🏗 Mimari

Uygulama **Clean Architecture** ile katmanlı yapıya sahiptir:

- **Data Layer**
  - Datasource (Remote: ddownload API, Local: Hive)
  - Repository implementasyonları
- **Domain Layer**
  - Repository interface’leri
  - Model ve UseCase’ler
- **Presentation Layer**
  - Cubit/Bloc state management
  - UI widget’ları

### Dependency Injection

`get_it` kullanılarak tüm servisler merkezi olarak yönetilir:

```dart
if (!_instance.isRegistered<AppRouter>()) {
  _instance.registerSingleton<AppRouter>(AppRouter());
}
