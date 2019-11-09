import 'dart:convert';
import 'dart:html' hide Location;
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_components/angular_components.dart';

import '../pokemon_list/data.dart' as list;

import '../route_paths.dart';

@Component(
  selector: 'pokemon',
  templateUrl: 'pokemon.html',
  styleUrls: ['pokemon.css'],
  directives: [
    coreDirectives, 
    routerDirectives, 
    NgClass, 
    NgFor
  ],
  providers: [materialProviders]
)

class PokemonComponent{
  final Location _location;
  get id => int.parse(window.sessionStorage['id']);
  Map details = Map();
  List abilities = List();
  Map sprites = Map();
  String species = '';
  List types = List();
  Map type1 = Map();
  Map type2 = Map();
  Map evolution_chain = Map();
  List family = List();
  List poke = list.poke;

  PokemonComponent(this._location){
    getDetails();
  }

  getDetails() async{
    HttpRequest request =  await HttpRequest.request('https://pokeapi.co/api/v2/pokemon/$id', method: 'GET');
    details = json.decode(request.responseText);
    abilities = json.decode(request.responseText)['abilities'];
    sprites = json.decode(request.responseText)['sprites'];
    species = json.decode(request.responseText)['species']['url'];
    types = json.decode(request.responseText)['types'];
    type1 = types[0]['type'];
    if(types.length > 1) type2 = types[1]['type'];

    HttpRequest request1 = await HttpRequest.request('$species', method: 'GET');
    String evolution = json.decode(request1.responseText)['evolution_chain']['url'];
    HttpRequest request2 = await HttpRequest.request('$evolution', method: 'GET');
    evolution_chain = json.decode(request2.responseText);
    
    if(evolution_chain['chain'].isNotEmpty){
      if(evolution_chain['id'] == 67){
        family.add({'name': evolution_chain['chain']['species']['name']});
        evolution_chain['chain']['evolves_to'].forEach((f){
          family.add({'name': f['species']['name']});
        });

        family.forEach((f){
          poke.forEach((l){
            if (f['name'] == l['name']){
              f.addAll({'number': l['number']});
              f.addAll({'image': l['image']});
            }
          });
        });
      }else{
        if(evolution_chain['chain']['evolves_to'].isNotEmpty){
          poke.forEach((l){
            if (evolution_chain['chain']['species']['name'] == l['name']){
              family.add({'number': l['number'], 'name': l['name'], 'image': l['image']});
            }
          });
          poke.forEach((l){
            if (evolution_chain['chain']['evolves_to'][0]['species']['name'] == l['name']){
              print('lul');
              family.add({'number': l['number'], 'name': l['name'], 'image': l['image']});
            }
          });
          if(evolution_chain['chain']['evolves_to'][0]['evolves_to'].isNotEmpty){
            poke.forEach((l){
              if (evolution_chain['chain']['evolves_to'][0]['evolves_to'][0]['species']['name'] == l['name']){
                family.add({'number': l['number'], 'name': l['name'], 'image': l['image']});
              }
            });
          }
        }
      }
    }
    setCurrentClasses();
  }

  getPoke(String id) => window.sessionStorage['id'] = id;
  
  String PokeUrl() => RoutePaths.pokemon.toUrl();

  Map<String, bool> classes = <String, bool>{};
  Map<String, bool> classes2 = <String, bool>{};
  void setCurrentClasses() {
    classes = <String, bool>{
      'normal': type1['name'] == 'normal', 
      'fire': type1['name'] == 'fire',
      'fighting': type1['name'] == 'fighting',
      'water': type1['name'] == 'water',''
      'flying': type1['name'] == 'flying',
      'grass': type1['name'] == 'grass',
      'poison': type1['name'] == 'poison',
      'electric': type1['name'] == 'electric',
      'ground': type1['name'] == 'ground',
      'psychic': type1['name'] == 'psychic',
      'rock': type1['name'] == 'rock',
      'ice': type1['name'] == 'ice',
      'bug': type1['name'] == 'bug',
      'dragon': type1['name'] == 'dragon',
      'ghost': type1['name'] == 'ghost',
      'dark': type1['name'] == 'dark',
      'steel': type1['name'] == 'steel',
      'fairy': type1['name'] == 'fairy'
    };
    if(type2.isNotEmpty){
      classes2 = <String, bool>{
        'normal': type2['name'] == 'normal', 
        'fire': type2['name'] == 'fire',
        'fighting': type2['name'] == 'fighting',
        'water': type2['name'] == 'water',''
        'flying': type2['name'] == 'flying',
        'grass': type2['name'] == 'grass',
        'poison': type2['name'] == 'poison',
        'electric': type2['name'] == 'electric',
        'ground': type2['name'] == 'ground',
        'psychic': type2['name'] == 'psychic',
        'rock': type2['name'] == 'rock',
        'ice': type2['name'] == 'ice',
        'bug': type2['name'] == 'bug',
        'dragon': type2['name'] == 'dragon',
        'ghost': type2['name'] == 'ghost',
        'dark': type2['name'] == 'dark',
        'steel': type2['name'] == 'steel',
        'fairy': type2['name'] == 'fairy'
      };
    }
  }

  back() => _location.back();
}