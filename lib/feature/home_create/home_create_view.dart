import 'package:flutter/material.dart';
import 'package:flutter_firebase_news_app/product/constants/color_constants.dart';
import 'package:kartal/kartal.dart';

class HomeCreateView extends StatelessWidget {
  const HomeCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Add new item'),
      ),
      body: Padding(
        padding: context.paddingLow,
        child: ListView(
          children: [
            const TextField(
              decoration: InputDecoration(
                hintText: 'Category',
                border: OutlineInputBorder(),
              ),
            ),
            context.emptySizedHeightBoxLow,
            const TextField(
              decoration: InputDecoration(
                hintText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            context.emptySizedHeightBoxLow,
            SizedBox(
              height: context.dynamicHeight(0.2),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorsConstants.grayPrimary,
                  ),
                ),
                child: const Icon(Icons.add_a_photo_outlined),
              ),
            )
          ],
        ),
      ),
    );
  }
}
