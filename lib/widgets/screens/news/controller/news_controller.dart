 import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stocks_tracker/models/news.dart';
import 'package:stocks_tracker/service/news_api_service.dart';

class NewsController extends ValueNotifier<ArticlesState> {
  NewsController() : super(ArticlesState.inital()) {
    _init();
  }

  final _newsApiService = GetIt.instance<NewsApiService>();

  Future<void> _init() async {
    try {
      value = value.copyWith(isLoading: true);
      final news = await _newsApiService.getNews();
      value = value.copyWith(isLoading: false, news: news);
    } catch (e) {
      value = value.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> refresh() async => await _init();
}

class ArticlesState {
  final List<News> news;
  final bool isLoading;
  final String? errorMessage;

  const ArticlesState({
    required this.news,
    required this.isLoading,
    this.errorMessage,
  });

  factory ArticlesState.inital() => const ArticlesState(
        news: [],
        isLoading: false,
      );

  ArticlesState copyWith({
    List<News>? news,
    bool? isLoading,
    String? errorMessage,
  }) =>
      ArticlesState(
        news: news ?? this.news,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
