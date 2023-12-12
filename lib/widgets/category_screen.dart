import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:news_app/Repo/repo.dart';
import 'package:news_app/widgets/deatils_screen.dart';
import 'package:news_app/widgets/homescreen.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({super.key});

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> {
  CategoryNewsRepo categoryNewsRepo = CategoryNewsRepo();
  final time = DateFormat('MMMM dd, yyyy');

  String categoryname = 'general';

  List<String> categoryList = [
    'general',
    'business',
    'entertainment',
    'health',
    'science',
    'sports',
    'technology'
  ];
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: 40,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoryList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () {
                        categoryname = categoryList[index];
                        setState(() {});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: categoryname == categoryList[index]
                                ? Colors.blue[600]
                                : Colors.blueGrey,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(18))),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(categoryList[index].toString()),
                        )),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
            child: Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final categ = ref.watch(categoryProvider(categoryname));

                return categ.when(
                    data: (data) {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: data.articles!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          DateTime dateTime = DateTime.parse(
                              data.articles![index].publishedAt.toString());
                          final imageUrl =
                              data.articles![index].urlToImage?.toString();
                          if (kDebugMode) {
                            print('Image URL: $imageUrl');
                          }
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DeatilScreen(
                                      newsImages: data
                                          .articles![index].urlToImage
                                          .toString(),
                                      newsTitle: data.articles![index].title
                                          .toString(),
                                      newsDate: data
                                          .articles![index].publishedAt
                                          .toString(),
                                      newsAuthor: toString(),
                                      newsConten: data.articles![index].content
                                          .toString(),
                                      newsSoorce: data
                                          .articles![index].source!.name
                                          .toString(),
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl: data.articles![index].urlToImage
                                          .toString(),
                                      fit: BoxFit.cover,
                                      height: height * .18,
                                      width: width * .3,
                                      placeholder: (context, url) =>
                                          Container(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                        Icons.error_outline,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: height * .18,
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Column(
                                        children: [
                                          Text(
                                            data.articles![index].title
                                                .toString(),
                                            maxLines: 3,
                                          ),
                                          const Spacer(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  data.articles![index].source!
                                                      .name
                                                      .toString(),
                                                ),
                                              ),
                                              Text(
                                                time.format(dateTime),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    error: (error, stack) {
                      return Image.asset('assets/images/404.webp');
                    },
                    loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ));
              },
            ),
          )
        ],
      )),
    );
  }
}
