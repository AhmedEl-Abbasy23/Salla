import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shop/model/categories_model/get_categories_model.dart';
import 'package:shop/model/home_model/home_model.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/cubit/shop_cubit/shop_cubit.dart';
import 'package:shop/shared/cubit/shop_cubit/shop_states.dart';
import 'package:shop/shared/styles/colors.dart';

// ignore: use_key_in_widget_constructors
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessChangeFavoritesState) {
          if (!state.favoritesDataModel.status) {
            showToast(text: state.favoritesDataModel.message, state: ToastStates.ERROR);
          }
        }
      },
      builder: (context, state) {
        ShopCubit sCubit = ShopCubit.get(context);
        return Conditional.single(
          context: context,
          conditionBuilder: (context) =>
              state is! ShopLoadingHomeDataState &&
              state is! ShopLoadingCategoriesDataState,
          widgetBuilder: (context) => productsBuilder(
              sCubit.homeModel, sCubit.categoriesModel, context),
          fallbackBuilder: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productsBuilder(HomeModel homeModel, CategoriesModel categoriesModel,
          BuildContext context) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            CarouselSlider(
              // ignore: prefer_const_literals_to_create_immutables
              items: homeModel.data.banners
                  .map((item) => Image(
                        image: NetworkImage(item.image),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 250.0,
                initialPage: 0,
                viewportFraction: 1.0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(height: 3.0),
            buildTypeName('Categories'),
            const SizedBox(height: 3.0),
            SizedBox(
              height: 100.0,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>
                    buildCategoryItem(categoriesModel.data.data[index]),
                separatorBuilder: (context, index) => const SizedBox(),
                itemCount: categoriesModel.data.data.length,
              ),
            ),
            const SizedBox(height: 5.0),
            buildTypeName('New Products'),
            GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              childAspectRatio: 1 / 1.58,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                homeModel.data.products.length,
                (index) =>
                    girdProductItem(homeModel.data.products[index], context),
              ),
            ),
          ],
        ),
      );

  Widget girdProductItem(ProductsModel model, BuildContext context) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Container(
          color: Colors.white,
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Image(
                    image: NetworkImage(model.image),
                    height: 200,
                    width: double.infinity,
                  ),
                  if (model.discount != 0)
                    Container(
                      color: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: const Text(
                        'DISCOUNT',
                        style: TextStyle(fontSize: 8.0, color: Colors.white),
                      ),
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        height: 1.1,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '${model.price.round()}',
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: defaultColor,
                          ),
                        ),
                        const SizedBox(width: 5.0),
                        if (model.discount != 0)
                          Text(
                            '${model.oldPrice.round()}',
                            style: const TextStyle(
                              fontSize: 10.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            ShopCubit.get(context).changeFavorites(model.id);
                          },
                          icon: CircleAvatar(
                            radius: 15.0,
                            backgroundColor: Colors.white,
                            child: Icon(
                              ShopCubit.get(context).favorites[model.id] ?? false
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              size: 16.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildCategoryItem(DataModel model) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Image(
                  image: NetworkImage(model.image),
                  height: 100.0,
                  width: 100.0,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: 100.0,
                  color: Colors.black.withOpacity(0.8),
                  child: Text(
                    model.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 13.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget buildTypeName(String label) => Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: Text(
          label,
          style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.w800),
        ),
      );
}
