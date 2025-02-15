

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/pages/home_page/model/home_page_api.dart';

final homePageProvider = AsyncNotifierProvider<HomePageProvider, List<HomePageAPIResponse>>(HomePageProvider.new);

class HomePageProvider extends AsyncNotifier<List<HomePageAPIResponse>> {

  List<HomePageAPIResponse> home=[];

  @override
  FutureOr< List<HomePageAPIResponse>> build() async {
    // TODO: implement build
    await Future.delayed(const Duration(seconds: 2));

    fetchDataFromAPI();
    return await fetchDataFromAPI();
  }

  Future<List<HomePageAPIResponse>> fetchDataFromAPI() async {
    await _simulatingAPI();
    return home;
  }

  Future<void> _simulatingAPI() async {

    Map<String,String> data = {
     "image":'assets/images/lol.png',
      "name":"Ramesses II",
      "information":"Ramesses II, commonly known as Ramesses the Great, was an Egyptian pharaoh. He was the third ruler of the Nineteenth Dynasty."
   };

    for(int i =0; i<7;i++){
      home.add(HomePageAPIResponse.fromJson(data));
    }
 }

}