import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../model_class/news_data.dart';

class ArticleDetail extends StatefulWidget {
  final Articles articleDetail;
  const ArticleDetail({required this.articleDetail ,super.key});

  @override
  State<ArticleDetail> createState() => _ArticleDetailState();
}

class _ArticleDetailState extends State<ArticleDetail> {
  late Articles articleDetail;
  DateFormat formatter = DateFormat('EEEE, MMMM d, y HH:mm');

  @override
  void initState() {
    articleDetail = widget.articleDetail;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      title: IconButton(
        icon: Row(
          children: [
            const Icon(Icons.arrow_back_ios),
            Text('Back',style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 15,fontWeight: FontWeight.bold),)
          ],
        ),
        onPressed: () {
          // Define your action here, such as navigating back
          Navigator.pop(context);
        },

      ),
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(

                    height: 150.h,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(10.r),
                      image: DecorationImage(
                          image: NetworkImage(articleDetail.urlToImage),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                      top: 10.h,
                      bottom: 120.h,
                      left: 220.h,
                      right: 0.h,
                      child: const Icon(Icons.favorite,color: Colors.red,size: 40,)),


                ],
              ),
              SizedBox(height: 10.h,),
              Text(articleDetail.title,style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
              SizedBox(height: 5.h,),
              Row(
                children: [
                  const Icon(Icons.calendar_month,color: Colors.grey,),
                  Text('${formatter.format(DateTime.parse(articleDetail.publishedAt).toUtc())} GMT',maxLines: 2,style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.grey.shade400,fontSize: 13,fontWeight: FontWeight.w700),)
                ],
              ),
              SizedBox(height: 20.h,),
              HtmlWidget(articleDetail.content),
            //  Text(articleDetail.content,style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),

        ),
      ),
    );
  }
}
