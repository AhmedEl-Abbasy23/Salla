import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/model/categories_model/get_categories_model.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/cubit/shop_cubit/shop_cubit.dart';
import 'package:shop/shared/cubit/shop_cubit/shop_states.dart';

// ignore: use_key_in_widget_constructors
class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit sCubit = ShopCubit.get(context);
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              categoryItem(sCubit.categoriesModel.data.data[index]),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: sCubit.categoriesModel.data.data.length,
        );
      },
    );
  }

  Widget categoryItem(DataModel model) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Row(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Image(
              image: NetworkImage(model.image),
              height: 100.0,
              width: 100.0,
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Row(
                children: [
                  Text(
                    model.name,
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          ],
        ),
      );
}
