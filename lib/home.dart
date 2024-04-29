import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_app/pages/favourites.dart';
import 'package:news_app/pages/news.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: DefaultTabController(length: 2,
      child: Scaffold(

        appBar:  AppBar(
          toolbarHeight: 10.h,
         bottom: PreferredSize(
             preferredSize: Size.fromHeight(55.h),
             child:  TabBar(
               padding: EdgeInsets.symmetric(vertical: 10.h),
                 dividerColor: Colors.transparent,
                 indicatorColor: Colors.transparent,
                 splashFactory: NoSplash.splashFactory,
                 indicator: BoxDecoration(
                     color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10.r)
                 ),
                 tabs: [
                   Tab(
                     child:  Row(
                       crossAxisAlignment: CrossAxisAlignment.center,
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         const Icon(
                           Icons.menu_rounded,
                           color: Colors.black,
                           size: 40,
                         ),
                         SizedBox(
                           width: 5.w,
                         ),
                         Text('News',style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700))
                       ],
                     ),
                   ),
                   Tab(
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         const Icon(
                             Icons.favorite,
                           color: Colors.red,
                           size: 40,
                         ),
                         SizedBox(
                           width: 5.w,
                         ),
                         Text('Favs',style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),)
                       ],
                     ),
                   )
                 ])
         )




        ),
        body: const TabBarView(
          children: [
            News(),
            Favourites()
          ],
        ),
      ),

    ));
  }
}