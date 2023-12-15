import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stocks_tracker/helpers/data_time_helper.dart';
import 'package:stocks_tracker/helpers/images/image_helper.dart';
import 'package:stocks_tracker/models/arguments.dart';
import 'package:stocks_tracker/models/news.dart';
import 'package:stocks_tracker/navigation/route_names.dart';
import 'package:stocks_tracker/widgets/screens/news/controller/news_controller.dart';

class NewsView extends StatefulWidget {
  const NewsView({super.key});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  late final _newsController = NewsController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ImageHelper.getImage(ImageNames.bgAll).image,
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Text(
                'News',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: _newsController,
                  builder: (context, value, child) {
                    if (value.isLoading) {
                      return const _LoadingState();
                    } else {
                      if (value.errorMessage != null) {
                        return _ErrorState(
                          errorMessage: value.errorMessage!,
                          refresh: _newsController.refresh,
                        );
                      } else {
                        return _LoadedState(
                          news: value.news,
                          refresh: _newsController.refresh,
                        );
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CupertinoActivityIndicator(radius: 20),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String errorMessage;
  final VoidCallback? refresh;
  const _ErrorState({required this.errorMessage, this.refresh});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Error has occured: $errorMessage',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 20),
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: refresh,
          child: const Icon(Icons.refresh_outlined, size: 30),
        ),
      ],
    );
  }
}

class _LoadedState extends StatelessWidget {
  final List<News> news;
  final VoidCallback? refresh;
  const _LoadedState({
    required this.news,
    this.refresh,
  });

  @override
  Widget build(BuildContext context) {
    return news.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Data could not be retrieved.\nPlease, try again',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 20),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: refresh,
                  child: const Icon(Icons.refresh_outlined, size: 30),
                ),
              ],
            ),
          )
        : ListView.separated(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 20,
            ),
            itemBuilder: (context, index) => _NewsCard(
              news: news[index],
              onPressed: () {
                Navigator.of(context).pushNamed(
                  RouteNames.newView,
                  arguments: NewViewArguments(article: news[index]),
                );
              },
            ),
            separatorBuilder: (context, index) => const SizedBox(height: 15),
            itemCount: news.length,
          );
  }
}

class _NewsCard extends StatelessWidget {
  final News news;
  final VoidCallback? onPressed;
  const _NewsCard({
    required this.news,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final hours = DateTimeHelper.getHours(news.date);

    final minutes = DateTimeHelper.getMinutes(news.date);
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 16,
                bottom: 19,
              ),
              child: Column(
                children: [
                  Text(
                    news.title,
                    maxLines: 2,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.black),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  SizedBox(
                    height: 78,
                    child: Text(
                      news.body,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(color: Colors.black.withOpacity(0.42)),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Today, ${hours}:$minutes',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(color: Colors.black.withOpacity(0.42)),
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
}
