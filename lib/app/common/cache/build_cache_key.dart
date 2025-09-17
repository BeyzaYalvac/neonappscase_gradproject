import 'dart:convert';

String buildCacheKey(
  String method,
  Uri uri, {
  Map<String, dynamic>? query,
  dynamic bodyForKey,
}) {
  final qp = <String, dynamic>{...?query};
  final entries = qp.entries.toList()
    ..sort((a, b) => a.key.compareTo(b.key));
  final queryStr = entries.map((e) => '${e.key}=${e.value}').join('&');

  final bodyStr = bodyForKey == null ? '' : jsonEncode(bodyForKey);

  final cleanUri = uri.replace(queryParameters: const {});
  return '${method.toUpperCase()}|$cleanUri|$queryStr|$bodyStr';
}
