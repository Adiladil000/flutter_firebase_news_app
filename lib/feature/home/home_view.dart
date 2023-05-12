import 'package:flutter/material.dart';
import 'package:flutter_firebase_news_app/feature/home/home_provider.dart';
import 'package:flutter_firebase_news_app/feature/home/sub_view/home_search_delegate.dart';
import 'package:flutter_firebase_news_app/feature/home_create/home_create_view.dart';
import 'package:flutter_firebase_news_app/product/constants/color_constants.dart';
import 'package:flutter_firebase_news_app/product/constants/string_contants.dart';
import 'package:flutter_firebase_news_app/product/models/tag.dart';
import 'package:flutter_firebase_news_app/product/widgets/card/home_news_card.dart';
import 'package:flutter_firebase_news_app/product/widgets/card/recommended.dart';
import 'package:flutter_firebase_news_app/product/widgets/text/sub_title_text.dart';
import 'package:flutter_firebase_news_app/product/widgets/text/title_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

part './sub_view/home_chips.dart';

final _homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier();
});

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final TextEditingController _controller = TextEditingController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(_homeProvider.notifier).fetchAndLoad();
    });

    ref.read(_homeProvider.notifier).addListener((state) {
      if (state.selectedTag != null) {
        _controller.text = state.selectedTag?.name ?? '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.navigateToPage(const HomeCreateView(), type: SlideType.BOTTOM);
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              padding: context.paddingNormal,
              children: [
                const _Header(),
                _CustomField(_controller),
                const _TagListView(),
                const _BrowserHorizontalListView(),
                const _RecommendedHeader(),
                const _RecommendedListView(),
              ],
            ),
            if (ref.watch(_homeProvider).isLoading ?? false)
              const Center(
                child: CircularProgressIndicator(),
              )
          ],
        ),
      ),
    );
  }
}

class _CustomField extends ConsumerWidget {
  const _CustomField(this.controller);
  final TextEditingController controller;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      controller: controller,
      onTap: () async {
        final response = await showSearch<Tag?>(
          context: context,
          delegate: HomeSearchDelegate(
            ref.read(_homeProvider.notifier).fullTagList,
          ),
        );
        ref.read(_homeProvider.notifier).updateSelectedTag(response);
      },
      decoration: const InputDecoration(
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

class _TagListView extends ConsumerWidget {
  const _TagListView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsItems = ref.watch(_homeProvider).tags ?? [];
    return SizedBox(
      height: context.dynamicHeight(0.1),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: newsItems.length,
        itemBuilder: (context, index) {
          final tagItem = newsItems[index];
          if (tagItem.active ?? false) {
            return _ActiveChip(tagItem);
          }
          return _PassiveChip(tagItem);
        },
      ),
    );
  }
}

class _BrowserHorizontalListView extends ConsumerWidget {
  const _BrowserHorizontalListView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsItems = ref.watch(_homeProvider).news;
    return SizedBox(
      height: context.dynamicHeight(0.3),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: newsItems?.length ?? 0,
        itemBuilder: (context, index) {
          return HomeNewsCard(newsItem: newsItems?[index]);
        },
      ),
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

class _RecommendedListView extends ConsumerWidget {
  const _RecommendedListView();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final values = ref.watch(_homeProvider).recommended ?? [];
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: values.length,
      itemBuilder: (context, index) {
        return RecommendedCard(recommended: values[index]);
      },
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
