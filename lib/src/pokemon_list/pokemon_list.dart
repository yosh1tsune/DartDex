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
    NgClass, 
    NgFor
  ],
  providers: [materialProviders]
)

class ListComponent{
  List poke = list.poke;
  List all_types = List();
  List type = List();
  List regions = List();
  String typeSelect = 'All';
  String regionSelect = 'All';
  String url = 'https://pokeapi.co/api/v2/pokemon/';

  getData() async{
    HttpRequest request2 = await HttpRequest.request('https://pokeapi.co/api/v2/type/', method: 'GET');
    HttpRequest request3 = await HttpRequest.request('https://pokeapi.co/api/v2/region/', method: 'GET');
    all_types = json.decode(request2.responseText)['results'];
    regions = json.decode(request3.responseText)['results'];
    
    setCurrentClasses();
  }

  ListComponent(){
    getData();
  }

  getDetails(String id){
    window.sessionStorage['id'] = id;
  }

  String PokeUrl() => RoutePaths.pokemon.toUrl();

  void setCurrentClasses() {
    for(Map p in poke){
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