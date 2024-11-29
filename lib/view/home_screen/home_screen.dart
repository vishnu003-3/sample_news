import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_news/controller/home_screen_controller.dart';
import 'package:sample_news/utils/color_constants.dart';
import 'package:sample_news/view/news_details_screen/news_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  final List<String> categories = [
    'general',
    'business',
    'entertainment',
    'health',
    'science',
    'sports',
    'technology'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categories.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        final category = categories[_tabController.index];

        context.read<HomeScreenController>().getNews(category);
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeScreenController>().getNews(categories[0]);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        backgroundColor: ColorConstants.BackgroundColor,
        appBar: AppBar(
          backgroundColor: ColorConstants.AccentTextColor,
          title: const Text('Top Headlines'),
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: categories
                .map((category) => Tab(text: category.toUpperCase()))
                .toList(),
            onTap: (index) {
              context.read<HomeScreenController>().getNews(categories[index]);
            },
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  context.read<HomeScreenController>().searchArticles(value);
                },
                decoration: InputDecoration(
                  hintText: 'Search news...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Consumer<HomeScreenController>(
                builder: (context, homeController, child) {
                  if (homeController.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final filteredArticles = homeController.filteredArticles;

                  if (filteredArticles == null || filteredArticles.isEmpty) {
                    return const Center(child: Text("No articles found."));
                  }

                  return ListView.builder(
                    itemCount: filteredArticles!.length,
                    itemBuilder: (context, index) {
                      final article = filteredArticles[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ArticleScreen(article: article),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 12.0),
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: ColorConstants.CardBackgroundColor,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              article.urlToImage != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        article.urlToImage!,
                                        width: 200,
                                        height: 120,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Container(
                                      width: 100,
                                      height: 80,
                                      color: Colors.grey[300],
                                      child: const Icon(
                                        Icons.image_not_supported,
                                        color: Colors.grey,
                                      ),
                                    ),
                              const SizedBox(width: 12.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      article.title ?? 'No Title',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4.0),
                                    Text(
                                      article.source?.name ?? '',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
