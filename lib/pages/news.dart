import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:news_app/modul/news_data.dart';
import 'package:news_app/pages/artical_detail_page.dart';

import '../api_services.dart';
import '../provider/favourite_provider.dart';
class News extends ConsumerStatefulWidget {
  const News({super.key});

  @override
  ConsumerState<News> createState() => _NewsState();
}

class _NewsState extends ConsumerState<News> {
  final apiService = ApiServices();
  late List<Articles> articles;
   List<Articles> favorite =[];
  bool isLoading = false;
  DateFormat formatter = DateFormat('EEEE, MMMM d, y HH:mm');



  void showInSnackBar(String value) {
    const snackBar = SnackBar(
      content: Text('value'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }



  void getArticles() async{
  isLoading = true;
  var response =  await apiService.getNewsData();
  if(response.status == 'ok'){
    articles = response.articles;
    isLoading = false;
  }else{
    showInSnackBar(response.status);
  }
  setState(() {

  });
  }

  @override
  void initState() {
    getArticles();
    super.initState();
  }






  @override
  Widget build(BuildContext context) {
    favorite = ref.watch(favoriteNotifier);

    return SingleChildScrollView(
      child:
      Column(
        children: [
          isLoading ?   Container(
            margin: EdgeInsets.only(top: 40.h),
            height: 50.h,
            width: 50.w,
            child:  const CircularProgressIndicator(),
          ):  ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: articles.length,
              itemBuilder: (context, index){

                return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.r),
                      color: Colors.red.shade200 ,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5), // Shadow color
                          spreadRadius: 5, // Spread radius
                          blurRadius: 7, // Blur radius
                          offset: Offset(0, 3), // Offset in x and y directions
                        ),
                      ]
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child:   Dismissible(
                       onDismissed: (onDismissed){
                         favorite.add(articles[index]);
                       },
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red.shade200,
                         // width: 100.w,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container

                              (
                              margin: EdgeInsets.symmetric(vertical: 20.h,horizontal: 20.w),
                              width: 60.w,
                              child: Column(
                                //  crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Icon(Icons.favorite,color: Colors.red,size: 40,),
                                  Text('Add To Favorite',
                                    textAlign: TextAlign.end,
                                    maxLines: 2,style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700)),

                                ],
                              ),
                            ),
                          )
                        ),
                       // secondaryBackground:  Container(),
                        onResize: (){
                          print('re');
                          print('rese');
                        },
                        resizeDuration: Duration(seconds: 1),
                        key:Key('$index') , child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ArticleDetail(articleDetail: articles[index]) ));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10.w
                              ),
                              height: 90.h,
                              width: 80.w,
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(10.r),
                                image: DecorationImage(
                                    image: NetworkImage(articles[index].urlToImage),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 235.w,
                                  child: Text(articles[index].title,maxLines: 2,style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 15,fontWeight: FontWeight.w700),),
                                ),
                                SizedBox(
                                  width: 235.w,
                                  child: Text(articles[index].description,maxLines: 2,style: Theme.of(context).textTheme.bodyMedium,),
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_month,color: Colors.grey,),
                                    Text('${formatter.format(DateTime.parse(articles[index].publishedAt).toUtc())} GMT',maxLines: 2,style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey,fontSize: 10,fontWeight: FontWeight.w700),)
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )),
                  ),
                ) ;
              })
        ],
      ),
    );
  }
}
