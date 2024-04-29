import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../modul/news_data.dart';

final favoriteNotifier = StateNotifierProvider<FavoriteNotifier,List<Articles>>((ref){
  return FavoriteNotifier();
});


class FavoriteNotifier extends StateNotifier<List<Articles>>{
  FavoriteNotifier() : super([]);

  void addFavoriteArticles(Articles articles){
    state = [...state, articles];
  }
}