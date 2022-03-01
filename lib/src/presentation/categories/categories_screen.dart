import 'package:chuck_norris/src/common/app_module.dart';
import 'package:chuck_norris/src/presentation/categories/bloc/categories_bloc.dart';
import 'package:chuck_norris/src/presentation/categories/categories_data.dart';
import 'package:chuck_norris/src/presentation/common/base_page.dart';
import 'package:chuck_norris/src/presentation/common/reusable_widgets/loading_indicator.dart';
import 'package:chuck_norris/src/presentation/common/theme/colors.dart';
import 'package:chuck_norris/src/presentation/common/theme/font_sizes.dart';
import 'package:chuck_norris/src/presentation/common/theme/paddings.dart';
import 'package:chuck_norris/src/presentation/common/theme/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget with BasePage {
  CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        CategoriesBloc bloc = injector.get<CategoriesBloc>();
        bloc.getData();
        return bloc;
      },
      child: BlocBuilder<CategoriesBloc, CategoriesData>(
        builder: (context, CategoriesData data) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(GetPadding.padding_20),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  _BuildTitle(),
                  const SizedBox(
                    height: Sizes.space_24,
                  ),
                  _BuildSearchField(),
                  const SizedBox(
                    height: Sizes.space_24,
                  ),
                  _BuildSmallTitle(
                    textFieldFocus: data.textFieldFocused,
                  ),
                  const SizedBox(
                    height: Sizes.space_24,
                  ),
                  data.loading
                      ? const LoadingIndicator()
                      : _BuildGridView(
                          categories: data.categories,
                          textFieldFocus: data.textFieldFocused,
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _BuildTitle extends StatelessWidget with BasePage {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        getStrings().chuckNorris.toUpperCase(),
        style: const TextStyle(
          color: GetColors.orange,
          fontSize: FontSizes.font_20,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _BuildSearchField extends StatelessWidget with BasePage {
  _BuildSearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: GetPadding.padding_8),
          child: Icon(
            Icons.search,
            color: Colors.grey,
            size: Sizes.iconSize,
          ),
        ),
        SizedBox(
          width: getScreenSize(context).width * Sizes.searchFieldWidth,
          child: Focus(
            onFocusChange: (hasFocus) {
              BlocProvider.of<CategoriesBloc>(context).focusChanged();
            },
            child: TextField(
              cursorColor: Colors.grey,
              autocorrect: false,
              decoration: InputDecoration(
                hintText: getStrings().searchForJoke,
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: FontSizes.font_20,
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
              ),
              onSubmitted: (String value) {
                if (value.isNotEmpty) {
                  BlocProvider.of<CategoriesBloc>(context).getRandomJokes();
                }
              },
              style: const TextStyle(
                color: Colors.grey,
                fontSize: FontSizes.font_20,
                fontWeight: FontWeight.w400,
              ),
              onChanged: (String value) {
                BlocProvider.of<CategoriesBloc>(context).searchQuery(value);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _BuildSmallTitle extends StatelessWidget with BasePage {
  final bool textFieldFocus;

  _BuildSmallTitle({Key? key, required this.textFieldFocus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        textFieldFocus
            ? getStrings().searchForJoke
            : getStrings().orChooseCategory,
        style: const TextStyle(
          fontSize: FontSizes.font_12,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

class _BuildGridView extends StatelessWidget with BasePage {
  final List<String> categories;
  final bool textFieldFocus;

  _BuildGridView({
    Key? key,
    required this.categories,
    required this.textFieldFocus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: textFieldFocus ? 0.0 : 1.0,
      duration: const Duration(milliseconds: 200),
      child: GridView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        padding: const EdgeInsets.only(bottom: GetPadding.padding_8),
        itemCount: categories.length,
        itemBuilder: (BuildContext ctx, index) {
          return _BuildCategoryCard(
            categoryName: categories[index],
            onPressed: () {
              BlocProvider.of<CategoriesBloc>(context)
                  .getJoke(categories[index]);
            },
          );
        },
      ),
    );
  }
}

class _BuildCategoryCard extends StatelessWidget {
  final String categoryName;
  final VoidCallback onPressed;

  const _BuildCategoryCard({
    Key? key,
    required this.categoryName,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.35),
            spreadRadius: 0.5,
            blurRadius: 1,
            offset: const Offset(0, 1.1),
          )
        ]),
        child: Center(
          child: Text(
            categoryName,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
