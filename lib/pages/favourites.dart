import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';


import '../model_class/news_data.dart';
import '../provider/favourite_provider.dart';
import 'artical_detail_page.dart';
class Favourites extends ConsumerStatefulWidget {
  const Favourites({super.key});

  @override
  ConsumerState<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends ConsumerState<Favourites> {
  DateFormat formatter = DateFormat('EEEE, MMMM d, y HH:mm');
  List<Articles> favorite =[];

  @override
  void initState() {
    favorite = ref.read(favoriteNotifier);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<Articles> articles = ref.watch(favoriteNotifier);
    return SingleChildScrollView(
      child: Column(
        children: [
          articles.isEmpty? const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.heart_broken,size: 50,),
              Text('Favorites is empty!')
            ],
          ) :   ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: articles.length,
              itemBuilder: (context, index){
                return Dismissible(key:Key('$index') , child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ArticleDetail(articleDetail: articles[index]) ));
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5), // Shadow color
                              spreadRadius: 5, // Spread radius
                              blurRadius: 7, // Blur radius
                              offset: const Offset(0, 3), // Offset in x and y directions
                            ),
                          ]
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 10.h,vertical: 10.h),
                      height: 120.h,
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
                      )
                  ),
                ));
              })
        ],
      ),
    );
  }
}
