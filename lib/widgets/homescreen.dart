import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:news_app/Model/catregory_model.dart';
import 'package:news_app/Model/news_model.dart';
import 'package:news_app/Repo/repo.dart';
import 'package:news_app/widgets/category_screen.dart';
import 'package:news_app/widgets/deatils_screen.dart';

enum FillterList { bbcNews, indiaNews, cnnNews }

final fillterlistProvider = StateProvider<FillterList?>((ref) {
  return null;
});

final categoryProvider =
    FutureProvider.family<CategoryModel, String>((ref, category) async {
  final repo = CategoryNewsRepo();
  return repo.fetchCategoryNewsModelApi(category);
});

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  bool internetnot = true;
  NewsRepo newsrepo = NewsRepo();
  CategoryNewsRepo categoryNewsRepo = CategoryNewsRepo();

  Future<void> checkinternet() async {
    var result = await Connectivity().checkConnectivity();
    setState(() {
      internetnot = ConnectivityResult.none != result;
    });
  }

  @override
  void initState() {
    checkinternet();
    super.initState();
  }

  FillterList? selectedMenu;

  final time = DateFormat('MMMM dd, yyyy');
  String name = 'us';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 1;
    final height = MediaQuery.of(context).size.height * 1;
    if (!internetnot) {
      return const Scaffold(
        body: Center(
          child: Text('internet is discountced'),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CategoryScreen()),
              );
            },
            child: const Icon(Icons.category),
          ),
          centerTitle: true,
          title: const Text(
            'News',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            PopupMenuButton<FillterList>(
              icon: const Icon(
                Icons.more_vert_outlined,
                color: Colors.black,
              ),
              onSelected: (FillterList item) {
                setState(() {
                  if (item == FillterList.bbcNews) {
                    name = 'us';
                  } else if (item == FillterList.indiaNews) {
                    name = 'in';
                  } else if (item == FillterList.cnnNews) {
                    name = 'de';
                  }
                });
              },
              initialValue: selectedMenu,
              itemBuilder: (context) => <PopupMenuEntry<FillterList>>[
                const PopupMenuItem(
                  value: FillterList.bbcNews,
                  child: Text('US'),
                ),
                const PopupMenuItem(
                  value: FillterList.indiaNews,
                  child: Text('India'),
                ),
                const PopupMenuItem(
                  value: FillterList.cnnNews,
                  child: Text('Germany'),
                ),
              ],
            )
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.55,
                  child: FutureBuilder<NewsHeadLinesModel>(
                    future: newsrepo.fetchNewsHeadLinesModel(name),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.none) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData) {
                        return const Center(child: Text('No data available'));
                      } else {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.blueAccent),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.articles!.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              DateTime dateTime = DateTime.parse(snapshot
                                  .data!.articles![index].publishedAt
                                  .toString());
                              final imageUrl = snapshot
                                  .data!.articles![index].urlToImage
                                  ?.toString();
                              if (kDebugMode) {
                                print('Image URL: $imageUrl');
                              }
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DeatilScreen(
                                        newsImages: snapshot
                                            .data!.articles![index].urlToImage
                                            .toString(),
                                        newsTitle: snapshot
                                            .data!.articles![index].title
                                            .toString(),
                                        newsDate: snapshot
                                            .data!.articles![index].publishedAt
                                            .toString(),
                                        newsAuthor: snapshot
                                            .data!.articles![index].author
                                            .toString(),
                                        newsConten: snapshot
                                            .data!.articles![index].content
                                            .toString(),
                                        newsSoorce: snapshot
                                            .data!.articles![index].source!.name
                                            .toString(),
                                      ),
                                    ),
                                  );
                                },
                                child: SizedBox(
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Container(
                                          height: height * 0.6,
                                          width: width * 0.8,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: CachedNetworkImage(
                                                fadeInDuration:
                                                    const Duration(seconds: 2),
                                                imageUrl: imageUrl.toString(),
                                                imageBuilder: (context,
                                                        imageProvider) =>
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit.cover,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      16)),
                                                    ),
                                                fit: BoxFit.cover,
                                                height: height * 0.6,
                                                width: width * 0.8,
                                                placeholder: (context, url) =>
                                                    const Center(),
                                                errorWidget:
                                                    (context, url, error) {
                                                  if (kDebugMode) {
                                                    print(
                                                        'Error loading image. URL: $url, Error: $error');
                                                  }
                                                  return const Icon(
                                                    Icons.error_outline,
                                                    color: Colors.red,
                                                  );
                                                }),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 20,
                                        child: Card(
                                          elevation: 5,
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Container(
                                            alignment: Alignment.bottomCenter,
                                            padding: const EdgeInsets.all(15),
                                            height: height * .22,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: width * 0.7,
                                                  child: Text(
                                                    snapshot.data!
                                                        .articles![index].title
                                                        .toString(),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                const Spacer(),
                                                SizedBox(
                                                  width: width * 0.7,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Flexible(
                                                        child: Text(
                                                          snapshot
                                                              .data!
                                                              .articles![index]
                                                              .source!
                                                              .name
                                                              .toString(),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      Text(
                                                        time
                                                            .format(dateTime)
                                                            .toString(),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                ),
                Column(
                  children: [
                    Consumer(
                      builder:
                          (BuildContext context, WidgetRef ref, Widget? child) {
                        final categ = ref.watch(categoryProvider('general'));

                        return categ.when(
                            data: (data) {
                              return AnimationLimiter(
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: data.articles!.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    DateTime dateTime = DateTime.parse(data
                                        .articles![index].publishedAt
                                        .toString());
                                    final imageUrl = data
                                        .articles![index].urlToImage
                                        ?.toString();
                                    if (kDebugMode) {
                                      print('Image URL: $imageUrl');
                                    }
                                    return AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration: const Duration(seconds: 1),
                                      child: SlideAnimation(
                                        verticalOffset: 50,
                                        child: FadeInAnimation(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        DeatilScreen(
                                                      newsImages: data
                                                          .articles![index]
                                                          .urlToImage
                                                          .toString(),
                                                      newsTitle: data
                                                          .articles![index]
                                                          .title
                                                          .toString(),
                                                      newsDate: data
                                                          .articles![index]
                                                          .publishedAt
                                                          .toString(),
                                                      newsAuthor: toString(),
                                                      newsConten: data
                                                          .articles![index]
                                                          .content
                                                          .toString(),
                                                      newsSoorce: data
                                                          .articles![index]
                                                          .source!
                                                          .name
                                                          .toString(),
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Row(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          imageUrl.toString(),
                                                      fit: BoxFit.cover,
                                                      height: height * .18,
                                                      width: width * .3,
                                                      placeholder:
                                                          (context, url) =>
                                                              Container(),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          const Icon(
                                                        Icons.error_outline,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      height: height * .18,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15),
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            data
                                                                .articles![
                                                                    index]
                                                                .title
                                                                .toString(),
                                                            maxLines: 3,
                                                          ),
                                                          const Spacer(),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  data
                                                                      .articles![
                                                                          index]
                                                                      .source!
                                                                      .name
                                                                      .toString(),
                                                                ),
                                                              ),
                                                              Text(
                                                                time.format(
                                                                    dateTime),
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
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                            error: (error, stack) {
                              return const Center(
                                  child: Text('No data availble'));
                            },
                            loading: () => const Center(
                                  child: CircularProgressIndicator(),
                                ));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
