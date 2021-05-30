import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/model/on_boarding_model/on_boarding_model.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/cubit/on_boarding_cubit/on_boarding_cubit.dart';
import 'package:shop/shared/cubit/on_boarding_cubit/on_boarding_states.dart';
import 'package:shop/shared/styles/colors.dart';

// ignore: use_key_in_widget_constructors, must_be_immutable
class OnBoardingScreen extends StatelessWidget {
  List<BoardingModel> boarding = [
    BoardingModel(
      title: 'Salla',
      image: 'assets/images/boarding_1.jpg',
      body: 'Best place for shopping',
    ),
    BoardingModel(
      title: 'Salla',
      image: 'assets/images/boarding_2.jpg',
      body: 'Enjoy many offers and discounts',
    ),
    BoardingModel(
      title: 'Salla',
      image: 'assets/images/boarding_3.jpg',
      body: 'Login or register now to browse our products',
    ),
  ];

  PageController boardController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BoardingCubit(),
      child: BlocConsumer<BoardingCubit, OnBoardingStates>(
          listener: (context, state) {},
          builder: (context, state) {
            BoardingCubit bCubit = BoardingCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                // ignore: prefer_const_literals_to_create_immutables
                actions: [
                  buildTextButton(
                    function: () {
                      bCubit.submit(context);
                    },
                    label: 'Skip',
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        itemBuilder: (context, index) =>
                            buildBoardingItem(boarding[index]),
                        itemCount: boarding.length,
                        controller: boardController,
                        physics: const BouncingScrollPhysics(),
                        onPageChanged: (int pageIndex) {
                          bCubit.changePageIndex(pageIndex);
                          if (pageIndex == boarding.length - 1) {
                            bCubit.changeScreen(true);
                          } else {
                            bCubit.changeScreen(false);
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 40.0),
                    Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        DotsIndicator(
                          dotsCount: boarding.length,
                          position: bCubit.currentPageIndex.toDouble(),
                          decorator: DotsDecorator(
                            size: const Size.square(9.0),
                            activeSize: const Size(26.0, 9.0),
                            activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            color: Colors.grey,
                            activeColor: defaultColor,
                            spacing: const EdgeInsets.all(5.0),
                          ),
                        ),
                        const Spacer(),
                        FloatingActionButton(
                          onPressed: () {
                            if (bCubit.isLast) {
                              bCubit.submit(context);
                            } else {
                              boardController.nextPage(
                                  duration: const Duration(milliseconds: 750),
                                  curve: Curves.fastLinearToSlowEaseIn);
                            }
                          },
                          child: const Icon(Icons.arrow_forward_ios),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

Widget buildBoardingItem(BoardingModel boardingModel) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Expanded(
          child: Image(
            image: AssetImage(boardingModel.image),
          ),
        ),
        Row(
          children: [
            const Icon(Icons.shopping_basket),
            const SizedBox(width: 5.0),
            Text(
              boardingModel.title,
              style: const TextStyle(fontSize: 24.0),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Text(
          boardingModel.body,
          style: const TextStyle(fontSize: 14.0),
        ),
        const SizedBox(height: 30.0),
      ],
    );
