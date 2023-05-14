import 'package:flutter/material.dart';
import 'package:flutter_firebase_news_app/feature/home_create/home_logic.dart';
import 'package:flutter_firebase_news_app/product/constants/color_constants.dart';
import 'package:flutter_firebase_news_app/product/constants/string_contants.dart';
import 'package:flutter_firebase_news_app/product/enums/index.dart';
import 'package:flutter_firebase_news_app/product/models/category.dart';
import 'package:kartal/kartal.dart';
//import 'package:flutter/foundation.dart';

class HomeCreateView extends StatefulWidget {
  const HomeCreateView({super.key});

  @override
  State<HomeCreateView> createState() => _HomeCreateViewState();
}

class _HomeCreateViewState extends State<HomeCreateView> with Loading {
  late final HomeLogic _homeLogic;

  @override
  void initState() {
    super.initState();
    _homeLogic = HomeLogic();
    _fetchInitialCategory();
  }

  Future<void> _fetchInitialCategory() async {
    await _homeLogic.fetchAllCategory();
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _homeLogic.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(
                color: ColorsConstants.white,
              ),
            )
        ],
        centerTitle: false,
        title: const Text(StringContants.addItemTitle),
      ),
      body: Form(
        onChanged: () {
          _homeLogic.checkValidateAndSave(
            (value) {
              setState(() {});
            },
          );
        },
        key: _homeLogic.fromKey,
        autovalidateMode: AutovalidateMode.always,
        child: Padding(
          padding: context.paddingLow,
          child: ListView(
            children: [
              _HomeCategoryDropDown(
                categories: _homeLogic.categories,
                onSelected: _homeLogic.updateCategory,
              ),
              const _EmptySizeBox(),
              TextFormField(
                controller: _homeLogic.titleController,
                validator: (value) => value.isNullOrEmpty ? 'Not Empty' : null,
                decoration: const InputDecoration(
                  hintText: StringContants.dropDownTitle,
                  border: OutlineInputBorder(),
                ),
              ),
              const _EmptySizeBox(),
              InkWell(
                onTap: () async {
                  await _homeLogic.pickAndCheck((value) {
                    setState(() {});
                  });
                },
                child: SizedBox(
                  height: context.dynamicHeight(0.2),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorsConstants.grayPrimary,
                      ),
                    ),
                    child: _homeLogic.selectedFileBytes != null
                        ? Image.memory(_homeLogic.selectedFileBytes!)
                        : const Icon(
                            Icons.add_a_photo_outlined,
                          ),
                  ),
                ),
              ),
              const _EmptySizeBox(),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size.fromHeight(
                    WidgetSize.buttonNomal.value.toDouble(),
                  ),
                ),
                onPressed: !_homeLogic.isValidateAllForm
                    ? null
                    : () async {
                        changeLoading();
                        final response = await _homeLogic.save();
                        changeLoading();
                        if (!mounted) {
                          await context.pop<bool>(response);
                        }
                      },
                icon: const Icon(Icons.send_rounded),
                label: const Text(StringContants.buttonSave),
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

class _HomeCategoryDropDown extends StatelessWidget {
  const _HomeCategoryDropDown({
    required this.categories,
    required this.onSelected,
  });
  final List<CategoryModel> categories;
  final ValueSetter<CategoryModel> onSelected;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<CategoryModel>(
      validator: (value) => value == null ? 'Not Empty' : null,
      items: categories.map((e) {
        return DropdownMenuItem<CategoryModel>(
          value: e,
          child: Text(e.name ?? ''),
        );
      }).toList(),
      hint: const Text(StringContants.dropDownHint),
      onChanged: (value) {
        if (value == null) return;
        onSelected.call(value);
      },
    );
  }
}

mixin Loading on State<HomeCreateView> {
  bool isLoading = false;
  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }
}
