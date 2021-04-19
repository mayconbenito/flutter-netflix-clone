import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflixhomeclone/models/content_model.dart';

class ContentList extends StatelessWidget {
  final String title;
  final bool isOriginals;
  final List<Content> contentList;

  const ContentList(
      {Key key,
      @required this.title,
      this.isOriginals = false,
      @required this.contentList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold)),
          ),
          Container(
            height: isOriginals ? 500.0 : 220.0,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                itemCount: contentList.length,
                itemBuilder: (BuildContext context, int index) {
                  final content = contentList[index];
                  return GestureDetector(
                      onTap: () => print(content.name),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        height: isOriginals ? 400.0 : 200.0,
                        width: isOriginals ? 200.0 : 130.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(content.imageUrl),
                                fit: BoxFit.cover)),
                      ));
                }),
          )
        ],
      ),
    );
  }
}