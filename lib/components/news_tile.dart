import 'package:flutter/material.dart';
import '../Models/models_news.dart';

class NewsTile extends StatelessWidget {
  final News news;
  const NewsTile({
    Key? key,
    required this.news,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 20),
        Image.asset(
          news.imagePath,
          height: 100,
          width: 70,
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 5,
            ),
            Wrap(
              children: [
                Text(
                  news.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  news.descrition,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 1,
              color: Color.fromARGB(255, 28, 27, 27),
            ),
          ],
        ),
      ],
    );
  }
}
