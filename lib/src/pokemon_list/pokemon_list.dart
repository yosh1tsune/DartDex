import 'dart:convert';
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular/core.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_components/angular_components.dart';

import 'data.dart' as list;

import '../route_paths.dart';

@Component(
  selector: 'pokemon_list',
  templateUrl: 'pokemon_list.html',
  styleUrls: ['pokemon_list.css'],
  directives: [ 
    coreDirectives, 
    routerDirectives, 
    materialInputDirectives,
    MaterialDropdownSelectComponent,
    MaterialSelectItemComponent,
    MaterialButtonComponent,
    NgClass, 
    NgFor
  ],
  providers: [materialProviders]
)

class ListComponent{
  get fav => window.localStorage['fav'] == null ? '' : window.localStorage['fav'];
  List poke = list.poke;
  List response = List();
  List pokemons_list = List();
  Map single_pokemon = Map();
  List all_types = List();
  List regions = List();
  String typeSelect = 'All';
  String regionSelect = 'All';
  String url = 'https://pokeapi.co/api/v2/pokemon';

  getData() async{
    HttpRequest pokemons_request = await HttpRequest.request('$url', method: 'GET');
    response = (json.decode(pokemons_request.responseText)['results']);
    // HttpRequest types_request = await HttpRequest.request('$url/type/', method: 'GET');
    // all_types = json.decode(types_request.responseText)['results'];
    // HttpRequest regions_request = await HttpRequest.request('$url/region/', method: 'GET');
    // regions = json.decode(regions_request.responseText)['results'];

    for(Map<String, dynamic> p in response){
      HttpRequest single_pokemon_request = await HttpRequest.request(p['url'], method: 'GET');
      single_pokemon = json.decode(single_pokemon_request.responseText);
      p.addAll({'image': single_pokemon['sprites']['front_default']});
      p.addAll({'number': single_pokemon['id'].toString()});
      p.addAll({"class": {}, "class2": {}});
      p.addAll({'type1': single_pokemon['types'][0]['type']['name']});
      if (single_pokemon['types'].length == 2) {
        p.addAll({'type2': single_pokemon['types'][1]['type']['name']});
      }
      pokemons_list.add(p);
    };

    print(pokemons_list);

    url = json.decode(pokemons_request.responseText)['next'];

    setCurrentClasses();
  }

  getSinglePokemon(p) async{
    HttpRequest single_pokemon_request = await HttpRequest.request(p['url'], method: 'GET');
    single_pokemon = json.decode(single_pokemon_request.responseText);
    p.addAll({'image': single_pokemon['sprites']['front_default']});
    p.addAll({'number': single_pokemon['id']});
    p.addAll({"class": {}, "class2": {}});
    p.addAll({'type1': single_pokemon['types'][0]['type']['name']});
    if (single_pokemon['types'].length == 2) {
      p.addAll({'type2': single_pokemon['types'][1]['type']['name']});
    }
    return p;
  }

  ListComponent(){
    getData();
  }

  scroll(){
    getData();
  }

  getDetails(String id){
    window.sessionStorage['id'] = id;
  }

  addFav(String id){
    if (window.localStorage['fav'] == null){
      window.localStorage['fav'] = jsonEncode([id]);
    }
    else {
      List fav_aux = json.decode(window.localStorage['fav']);
      if (fav_aux.contains(id)){
        fav_aux.remove(id);
        print('lul');
        window.localStorage['fav'] = jsonEncode(fav_aux);
      }
      else {
        fav_aux.add(id);
        window.localStorage['fav'] = jsonEncode(fav_aux);
      }
    } 
  }

  String PokeUrl() => RoutePaths.pokemon.toUrl();

  void setCurrentClasses() {
    for(Map p in pokemons_list){
      p['class'] = <String, bool>{
        'normal': p['type1'] == 'normal',
        'fire': p['type1'] == 'fire',
        'fighting': p['type1'] == 'fighting',
        'water': p['type1'] == 'water',''
        'flying': p['type1'] == 'flying',
        'grass': p['type1'] == 'grass',
        'poison': p['type1'] == 'poison',
        'electric': p['type1'] == 'electric',
        'ground': p['type1'] == 'ground',
        'psychic': p['type1'] == 'psychic',
        'rock': p['type1'] == 'rock',
        'ice': p['type1'] == 'ice',
        'bug': p['type1'] == 'bug',
        'dragon': p['type1'] == 'dragon',
        'ghost': p['type1'] == 'ghost',
        'dark': p['type1'] == 'dark',
        'steel': p['type1'] == 'steel',
        'fairy': p['type1'] == 'fairy'
      };
      if(p['type2'] != null){
        p['class2'] = <String, bool>{
          'normal': p['type2'] == 'normal', 
          'fire': p['type2'] == 'fire',
          'fighting': p['type2'] == 'fighting',
          'water': p['type2'] == 'water',''
          'flying': p['type2'] == 'flying',
          'grass': p['type2'] == 'grass',
          'poison': p['type2'] == 'poison',
          'electric': p['type2'] == 'electric',
          'ground': p['type2'] == 'ground',
          'psychic': p['type2'] == 'psychic',
          'rock': p['type2'] == 'rock',
          'ice': p['type2'] == 'ice',
          'bug': p['type2'] == 'bug',
          'dragon': p['type2'] == 'dragon',
          'ghost': p['type2'] == 'ghost',
          'dark': p['type2'] == 'dark',
          'steel': p['type2'] == 'steel',
          'fairy': p['type2'] == 'fairy'
        };
      }
    }
  }
}