import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/model/search_model/search_model.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/cubit/search_cubit/search_cubit.dart';
import 'package:shop/shared/cubit/search_cubit/search_states.dart';
import 'package:shop/shared/styles/colors.dart';

// ignore: use_key_in_widget_constructors, must_be_immutable
class SearchScreen extends StatelessWidget {
  var textController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var sCubit = SearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Icon(Icons.shopping_basket),
                  const SizedBox(width: 5.0),
                  const Text('Salla'),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    defaultTextFormFiled(
                      controller: textController,
                      inputType: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Type your search text';
                        }
                        return null;
                      },
                      onSubmit: (String text) {
                        if (formKey.currentState!.validate()) {
                          sCubit.search(text);
                        }
                      },
                      label: 'Search',
                      prefix: Icons.search,
                    ),
                    const SizedBox(height: 10.0),
                    if (state is SearchLoadingState)
                      const LinearProgressIndicator(),
                    const SizedBox(height: 10.0),
                    state is SearchSuccessState &&
                            sCubit.searchModel.searchData.data.isNotEmpty
                        ? Expanded(
                            child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) => buildProductList(
                                sCubit.searchModel.searchData.data[index],
                                context,
                              ),
                              separatorBuilder: (context, _) => myDivider(),
                              itemCount:
                                  sCubit.searchModel.searchData.data.length,
                              // ignore: prefer_const_literals_to_create_immutables
                            ),
                          )
                        : Expanded(
                            child: buildEmpty(
                              icon: Icons.search,
                              text: 'Search',
                              isSearch: true,
                            ),
                          ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget buildProductList(SearchProduct model, BuildContext context) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: SizedBox(
        height: 180.0,
        width: double.infinity,
        child: Column(
          children: [
            Image(
              image: NetworkImage(model.image),
              height: 100.0,
              width: 100.0,
            ),
            const SizedBox(height: 5.0),
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
                      fontSize: 14.0,
                    ),
                  ),
                  Text(
                    '${model.price.round()}',
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: defaultColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

