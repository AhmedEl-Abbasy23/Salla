import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shop/model/favorites_model/favorites_model.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/cubit/shop_cubit/shop_cubit.dart';
import 'package:shop/shared/cubit/shop_cubit/shop_states.dart';
import 'package:shop/shared/styles/colors.dart';

// ignore: use_key_in_widget_constructors
class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit sCubit = ShopCubit.get(context);
        return Conditional.single(
          context: context,
          conditionBuilder: (context) =>
              state is! ShopLoadingFavoritesDataState,
          widgetBuilder: (context) => sCubit
                  .favoritesModel.favoritesData.data.isNotEmpty
              ? ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => buildFavoriteItems(
                    sCubit.favoritesModel.favoritesData.data[index]
                        .favoriteProduct,
                    context,
                  ),
                  separatorBuilder: (context, _) => myDivider(),
                  itemCount: sCubit.favoritesModel.favoritesData.data.length,
                  // ignore: prefer_const_literals_to_create_immutables
                )
              : buildEmpty(
            icon: Icons.favorite_border,
            text: 'Favorites',
          ),
          fallbackBuilder: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

Widget buildFavoriteItems(FavoriteProduct model, BuildContext context) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image(
                image: NetworkImage(model.image),
                height: 120.0,
                width: 120.0,
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    height: 1.1,
                    fontSize: 16.6,
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
    );

