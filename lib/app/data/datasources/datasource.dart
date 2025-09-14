/*
final api = ApiClient(
  baseUrl: 'https://api.themoviedb.org/3',
  headers: {'Accept': 'application/json'},
).safe;

final res = await api.get<Map<String, dynamic>>(
  '/movie/popular',
  query: {'api_key': '<KEY>'},
);

Beklenen çıktı: 
[REQUEST] GET https://api.themoviedb.org/3/movie/popular?...    (HTTP)
[RESPONSE] 200 GET https://api.themoviedb.org/3/movie/popular  (HTTP)


Hata durumunda:
[ERROR] GET https://... -> 401 : Unauthorized                  (HTTP)

*/