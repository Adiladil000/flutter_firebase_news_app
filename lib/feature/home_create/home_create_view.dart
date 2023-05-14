import 'package:flutter/material.dart';
import 'package:flutter_firebase_news_app/product/constants/color_constants.dart';
import 'package:flutter_firebase_news_app/product/enums/index.dart';
import 'package:flutter_firebase_news_app/product/models/category.dart';
import 'package:flutter_firebase_news_app/product/utility/firebase/firebase_collections.dart';
import 'package:flutter_firebase_news_app/product/utility/firebase/firebase_utility.dart';
import 'package:kartal/kartal.dart';
//import 'package:flutter/foundation.dart';

class HomeCreateView extends StatefulWidget {
  const HomeCreateView({super.key});

  @override
  State<HomeCreateView> createState() => _HomeCreateViewState();
}

class _HomeCreateViewState extends State<HomeCreateView> with FirebaseUtility {
  List<CategoryModel> _category = [];
  CategoryModel? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _fetchInitialCategory();
  }

  Future<void> _fetchInitialCategory() async {
    final response = await fetchList<CategoryModel, CategoryModel>(CategoryModel(), FirebaseCollections.category);

    setState(() {
      _category = response ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Add new item'),
      ),
      body: Form(
        child: Padding(
          padding: context.paddingLow,
          child: ListView(
            children: [
              DropdownButtonFormField<CategoryModel>(
                items: _category.map((e) {
                  return DropdownMenuItem<CategoryModel>(
                    child: ListTile(title: Text(e.name ?? '')),
                  );
                }).toList(),
                value: _selectedCategory,
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              const _EmptySizeBox(),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const _EmptySizeBox(),
              InkWell(
                onTap: () {},
                child: SizedBox(
                  height: context.dynamicHeight(0.2),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorsConstants.grayPrimary,
                      ),
                    ),
                    child: const Icon(Icons.add_a_photo_outlined),
                  ),
                ),
              ),
              const _EmptySizeBox(),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(fixedSize: Size.fromHeight(WidgetSize.buttonNomal.value.toDouble())),
                onPressed: () {},
                icon: const Icon(Icons.send_rounded),
                label: const Text('Save'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptySizeBox extends StatelessWidget {
  const _EmptySizeBox();

  @override
  Widget build(BuildContext context) {
    return context.emptySizedHeightBoxLow;
  }
}
