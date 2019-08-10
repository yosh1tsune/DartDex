import 'package:angular_router/angular_router.dart';

import 'route_paths.dart';
import 'pokemon/pokemon.template.dart' as poke;
import 'pokemon_list/pokemon_list.template.dart' as poke_list;

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
  static final all = <RouteDefinition>[
    pokemon_list,
    pokemon,
    RouteDefinition.redirect(
      path: '',
      redirectTo: RoutePaths.pokemon_list.toUrl(),
    ),
  ];
}
