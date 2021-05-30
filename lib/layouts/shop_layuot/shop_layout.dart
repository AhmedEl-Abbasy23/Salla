import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/search_screen/search_screen.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/cubit/shop_cubit/shop_cubit.dart';
import 'package:shop/shared/cubit/shop_cubit/shop_states.dart';
import 'package:shop/shared/styles/colors.dart';

// ignore: use_key_in_widget_constructors
class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()..getHomeData(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ShopCubit sCubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Icon(Icons.shopping_basket),
                  const SizedBox(width: 5.0),
                  const Text('Salla'),
                ],
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  },
                  icon: const Icon(Icons.search, color: defaultColor),
                ),
              ],
            ),
            body: sCubit.screens[sCubit.currentPageIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: sCubit.currentPageIndex,
              onTap: (index) {
                sCubit.changeScreen(index);
              },
              // ignore: prefer_const_literals_to_create_immutables
              items: [
                const BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: 'Home'),
                const BottomNavigationBarItem(
                    icon: Icon(Icons.apps), label: 'Categories'),
                const BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), label: 'Favorites'),
                const BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'Settings'),
              ],
            ),
          );
        },
      ),
    );
  }
}
