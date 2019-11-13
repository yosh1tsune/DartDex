import 'package:angular_router/angular_router.dart';

import 'route_paths.dart';
import 'pokemon/pokemon.template.dart' as poke;
import 'pokemon_list/pokemon_list.template.dart' as poke_list;
import 'favorites/favorites.template.dart' as fav;

export 'route_paths.dart';

class Routes {

  static final pokemon = RouteDefinition(
    routePath: RoutePaths.pokemon,
    component: poke.PokemonComponentNgFactory,
  );

  static final pokemon_list = RouteDefinition(
    routePath: RoutePaths.pokemon_list,
    component: poke_list.ListComponentNgFactory,
  );

  static final favorites = RouteDefinition(
    routePath: RoutePaths.favorites,
    component: fav.ListComponentNgFactory,
  );
  static final all = <RouteDefinition>[
    pokemon_list,
    pokemon,
    favorites,
    RouteDefinition.redirect(
      path: '',
      redirectTo: RoutePaths.pokemon_list.toUrl(),
    ),
  ];
}
