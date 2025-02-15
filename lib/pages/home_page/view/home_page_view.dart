

import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/pages/home_page/view_model/homePageProvider.dart';

class HomePageView extends ConsumerWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final homePageElement=ref.watch(homePageProvider);

    return Scaffold(
      body: homePageElement.when(
        data: (data) =>    Column(
          //image
          children: [
            CarouselSlider(
        options: CarouselOptions(
        height: 400,
          aspectRatio: 16/9,
          viewportFraction: 0.8,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: false,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          enlargeFactor: 0.3,
          scrollDirection: Axis.horizontal,
        ),
              items:data.map((element){
                return Builder(builder: (context) {
                  return Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Positioned.fill(
                        child: Image.asset(element.image,
                          fit: BoxFit.fill,
                        ),
                      ),

                      Align(
                        alignment: AlignmentDirectional.bottomCenter,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFFFBEEE9),
                            ),
                            color: Color(0xFFFBEEE9),
                          ),
                          height: 30,
                          width:double.maxFinite,
                          child: Align(child: Text(element.name,),alignment: AlignmentDirectional.center,),
                        ),
                      ),
                    ],
                  );
                },);
              }).toList(),
            ),


          ],
        ),


        error: (err, stack) => Container(width: 200,height: 200,color: Colors.red,),
        loading: () => CircularProgressIndicator(),
      )


    );
  }
}
