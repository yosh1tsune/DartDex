import 'package:angular_router/angular_router.dart';

const idParam = 'id';

class RoutePaths {
  static final pokemon = RoutePath(path: 'pokemon');
  static final pokemon_list = RoutePath(path: 'pokemon_list');
  static final favorites = RoutePath(path: 'favorites');

}

int getId(Map<String, String> parameters) {
  final id = parameters[idParam];
  return id == null ? null : int.tryParse(id);
}
