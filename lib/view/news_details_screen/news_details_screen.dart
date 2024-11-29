import 'package:flutter/material.dart';

import 'package:sample_news/model/home_screen_model.dart';
import 'package:sample_news/view/full_article_screen/full_article_screen.dart';

class ArticleScreen extends StatelessWidget {
  final Article article;

  const ArticleScreen({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String formattedDate = formatDate(article.publishedAt.toString());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Article Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            article.urlToImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      article.urlToImage!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 250,
                    ),
                  )
                : Container(
                    color: Colors.grey[300],
                    width: double.infinity,
                    height: 250,
                    child: const Icon(Icons.image_not_supported),
                  ),
            const SizedBox(height: 16.0),
            Text(
              article.title ?? 'No Title',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Text(
                  article.source?.name ?? 'Unknown Source',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 8.0),
                Text(
                  formattedDate,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Text(
              article.content ?? 'No Content Available.',
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20.0),
            if (article.url != null)
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullArticleScreen(
                            articleUrl: article.url.toString()),
                      ));
                },
                child: Row(
                  children: const [
                    Icon(Icons.link, color: Colors.blue),
                    SizedBox(width: 4.0),
                    Text(
                      'Read full article',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  String formatDate(String? date) {
    if (date == null) return 'Unknown Date';
    final DateTime parsedDate = DateTime.parse(date);
    return '${parsedDate.day}/${parsedDate.month}/${parsedDate.year}';
  }
}
