import 'package:flutter/material.dart';
import 'package:stocks_tracker/helpers/data_time_helper.dart';
import 'package:stocks_tracker/helpers/images/image_helper.dart';
import 'package:stocks_tracker/models/arguments.dart';
import 'package:stocks_tracker/models/news.dart';
import 'package:stocks_tracker/widgets/components/article_cover.dart';
import 'package:stocks_tracker/widgets/components/custom_back_button.dart';

class NewView extends StatelessWidget {
  final NewViewArguments news;
  NewView({super.key, required this.news});

  factory NewView.create(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as NewViewArguments;
    return NewView(news: arguments);
  }

  News get _article => news.article;

  @override
  Widget build(BuildContext context) {
    final hours = DateTimeHelper.getHours(_article.date);
    final minutes = DateTimeHelper.getMinutes(_article.date);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomBackButton(),
              SizedBox(height: 30),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                _article.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.black),
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Today, ${hours}:$minutes',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(color: Colors.black),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          _article.body,
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(color: Colors.black),
                        ),
                        SizedBox(height: 30),
                        Container(
                          width: double.infinity,
                          height: 300,
                          child: ArtcileCover(url: _article.imageUrl),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
