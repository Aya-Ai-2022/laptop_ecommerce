// ignore_for_file: library_private_types_in_public_api

import 'package:first_task_1/core/controllers/favorite_cubit/favorite_cubit.dart';
import 'package:first_task_1/core/controllers/favorite_cubit/favorite_states.dart';
import 'package:first_task_1/core/controllers/products_controller/product_cubit.dart';
import 'package:first_task_1/core/controllers/products_controller/product_states.dart';
import 'package:first_task_1/core/managers/nav.dart';
import 'package:first_task_1/screens/modules/cart.dart';
import 'package:first_task_1/screens/modules/favorite_screen.dart';
import 'package:first_task_1/screens/modules/product_detail_screen.dart';
import 'package:first_task_1/screens/modules/profile_screen.dart';
import 'package:first_task_1/screens/widgets/build_product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const ProductScreenBody(title: 'Products'),
    const CartScreen(),
    const FavoriteScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(_currentIndex == 0 ? 'Products' : _screens_names[_currentIndex-1]),
      // ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class ProductScreenBody extends StatelessWidget {
  final String title;

  const ProductScreenBody({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ProductCubit.get(context);
        if (cubit.laptopsModel == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return BlocConsumer<FavoritesCubit, FavoritesStates>(
          listener: (context, favoritesState) {
            if (favoritesState is ErrorAddToFavorites) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Error adding to favorites')),
              );
            } else if (favoritesState is ErrorRemoveFromFavorites) {
              // Handle error
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Error removing from favorites')),
              );
            }
          },
          builder: (context, favoritesState) {
            // Build the UI based on the state of both ProductCubit and FavoritesCubit
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.transparent,
                    child: GridView.count(
                      childAspectRatio: 1 / 1.3,
                      mainAxisSpacing: 1.0,
                      crossAxisSpacing: 1.0,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      children: List.generate(
                        cubit.laptopsModel!.product!.length,
                        (index) => buildProductItem(
                          cubit.laptopsModel!.product![index],
                          context,
                          onTap: () {
                            navigateToNextScreen(
                              context,
                              ProductDetailsScreen(
                                  product: cubit.laptopsModel!.product![index]),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
