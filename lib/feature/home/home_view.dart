import 'package:flutter/material.dart';
import 'package:flutter_firebase_news_app/product/constants/color_constants.dart';
import 'package:flutter_firebase_news_app/product/constants/string_contants.dart';
import 'package:flutter_firebase_news_app/product/enums/index.dart';
import 'package:flutter_firebase_news_app/product/widgets/text/sub_title_text.dart';
import 'package:flutter_firebase_news_app/product/widgets/text/title_text.dart';
import 'package:kartal/kartal.dart';
part './sub_view/home_chips.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: ListView(
          padding: context.paddingNormal,
          children: const [
            _Header(),
            _CustomField(),
            _TagListView(),
            _BrowserHorizontalListView(),
            _RecommendedHeader(),
            _RecommendedListView(),
          ],
        ),
      ),
    );
  }
}

class _CustomField extends StatelessWidget {
  const _CustomField();

  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.mic_outlined),
        prefixIcon: Icon(Icons.search_outlined),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        fillColor: ColorsConstants.grayLighter,
        hintText: StringContants.homeSearchHint,
      ),
    );
  }
}

class _TagListView extends StatelessWidget {
  const _TagListView();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.dynamicHeight(0.1),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          if (index.isOdd) {
            return const _ActiveChip();
          }
          return const _PassiveChip();
        },
      ),
    );
  }
}

class _BrowserHorizontalListView extends StatelessWidget {
  const _BrowserHorizontalListView();
  static const dummyImage =
      'https://media.cnn.com/api/v1/images/stellar/prod/230501223639-wind-turbines-texas-022023.jpg?c=16x9&q=h_720,w_1280,c_fill/f_webp';
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.dynamicHeight(0.25),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          return const _HorizontalCard(dummyImage: dummyImage);
        },
      ),
    );
  }
}

class _HorizontalCard extends StatelessWidget {
  const _HorizontalCard({
    required this.dummyImage,
  });

  final String dummyImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: context.onlyRightPaddingNormal,
          child: Image.network(
            errorBuilder: (context, error, stackTrace) => const Placeholder(),
            dummyImage,
          ),
        ),
        Positioned.fill(
          child: Padding(
            padding: context.paddingLow,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.bookmark_outline,
                    color: ColorsConstants.white,
                    size: WidgetSize.iconNormal.value.toDouble(),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: context.paddingLow,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SubTitleText(
                        value: 'POLITICS',
                        color: ColorsConstants.grayLighter,
                      ),
                      Text(
                        'The latest situation in the presidential election',
                        style: context.textTheme.headlineSmall?.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _RecommendedHeader extends StatelessWidget {
  const _RecommendedHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.onlyTopPaddingLow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(child: TitleText(value: StringContants.homeTitle)),
          TextButton(
            onPressed: () {},
            child: const SubTitleText(value: StringContants.homeSeeAll),
          ),
        ],
      ),
    );
  }
}

class _RecommendedListView extends StatelessWidget {
  const _RecommendedListView();
  static const dummyImage =
      'https://firebasestorage.googleapis.com/v0/b/flutter-full-news-6c99d.appspot.com/o/simple_tricke.png?alt=media&token=3f597b8e-a926-4748-a314-0c26e1c22401';
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) {
        return const _RecommendedCard(dummyImage: dummyImage);
      },
    );
  }
}

class _RecommendedCard extends StatelessWidget {
  const _RecommendedCard({
    required this.dummyImage,
  });

  final String dummyImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.onlyTopPaddingLow,
      child: Row(
        children: [
          Image.network(
            dummyImage,
            height: ImageSizes.normal.value.toDouble(),
            errorBuilder: (context, error, stackTrace) => const Placeholder(),
          ),
          const Expanded(
            child: ListTile(
              title: Text('UI/UX Design'),
              subtitle: Text('A Simple Trick For Creating Color Palettes Quickly'),
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleText(value: StringContants.homeBrowse),
        Padding(
          padding: context.onlyTopPaddingLow,
          child: const SubTitleText(
            value: StringContants.homeMessage,
          ),
        ),
      ],
    );
  }
}

























// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_firebase_news_app/product/models/news.dart';
// import 'package:flutter_firebase_news_app/product/utility/exception/custom_exception.dart';
// import 'package:kartal/kartal.dart';

// class HomeView extends StatefulWidget {
//   const HomeView({super.key});

//   @override
//   State<HomeView> createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: const _HomeListView(),
//     );
//   }
// }

// class _HomeListView extends StatelessWidget {
//   const _HomeListView();

//   @override
//   Widget build(BuildContext context) {
//     CollectionReference news = FirebaseFirestore.instance.collection('news');
//     final response = news.withConverter(
//       fromFirestore: (snapshot, options) {
//         return const News().fromFirebase(snapshot);
//       },
//       toFirestore: (value, options) {
//         if (value == null) throw FireBaseCustomException('$value not null');
//         return value.toJson();
//       },
//     ).get();
//     return FutureBuilder(
//       future: response,
//       builder: (context, AsyncSnapshot<QuerySnapshot<News?>> snapshot) {
//         switch (snapshot.connectionState) {
//           case ConnectionState.none:
//             return const Placeholder();
//           case ConnectionState.waiting:
//           case ConnectionState.active:
//             return const LinearProgressIndicator();
//           case ConnectionState.done:
//             if (snapshot.hasData) {
//               final values = snapshot.data!.docs.map((e) => e.data()).toList();
//               return ListView.builder(
//                 itemCount: values.length,
//                 itemBuilder: (context, index) {
//                   return Card(
//                     child: Column(
//                       children: [
//                         Image.network(
//                           values[index]?.backgroundImage ?? '',
//                           height: context.dynamicHeight(.1),
//                         ),
//                         Text(
//                           values[index]?.title ?? '',
//                           style: context.textTheme.labelLarge,
//                         )
//                       ],
//                     ),
//                   );
//                 },
//               );
//             } else {
//               return const SizedBox();
//             }
//         }
//       },
//     );
//   }
// }
