import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'src/routes.dart';

@Component(
  selector: 'my-app',
  template: '''
    <router-outlet [routes]="Routes.all"></router-outlet>
    <footer><center>Pokémon images & names © 1995-2019 Nintendo/Game Freak.</center></footer>
  ''',
  styleUrls: ['app_component.css'],
  directives: [routerDirectives],
  exports: [RoutePaths, Routes],
)
class AppComponent {
  final title = 'DartDex';
}
