import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflixhomeclone/cubits/app_bar/app_bar_cubit.dart';
import 'package:netflixhomeclone/data/data.dart';
import 'package:netflixhomeclone/widgets/content_header.dart';
import 'package:netflixhomeclone/widgets/content_list.dart';
import 'package:netflixhomeclone/widgets/custom_app_bar.dart';
import 'package:netflixhomeclone/widgets/previews.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        context.bloc<AppBarCubit>().setOffset(_scrollController.offset);
      });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[850],
        child: const Icon(Icons.cast),
        onPressed: () => print('Cast'),
      ),
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 50.0),
        child: BlocBuilder<AppBarCubit, double>(
          builder: (context, scrollOffset) {
            return CustomAppBar(scrollOffset: scrollOffset);
          },
        ),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: ContentHeader(
              featuredContent: sintelContent,
            ),
          ),
          SliverPadding(
              padding: const EdgeInsets.only(top: 20.0),
              sliver: SliverToBoxAdapter(
                  child: Previews(
                      key: PageStorageKey('previews'),
                      title: 'Previews',
                      contentList: previews))),
          SliverPadding(
              padding: const EdgeInsets.only(top: 20.0),
              sliver: SliverToBoxAdapter(
                  child: ContentList(
                      key: PageStorageKey('myList'),
                      title: 'My List',
                      contentList: myList))),
          SliverPadding(
              padding: const EdgeInsets.only(top: 20.0),
              sliver: SliverToBoxAdapter(
                  child: ContentList(
                      key: PageStorageKey('netflixOriginals'),
                      title: 'Netflix Originals',
                      isOriginals: true,
                      contentList: originals))),
          SliverPadding(
              padding: const EdgeInsets.only(top: 20.0),
              sliver: SliverToBoxAdapter(
                  child: ContentList(
                      key: PageStorageKey('trending'),
                      title: 'Trending',
                      contentList: trending)))
        ],
      ),
    );
  }
}
