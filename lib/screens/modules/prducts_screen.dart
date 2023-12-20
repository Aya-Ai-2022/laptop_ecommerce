// ignore_for_file: library_private_types_in_public_api
import 'package:carousel_slider/carousel_slider.dart';
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
  const ProductScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ProductCubit.get(context);
        if (cubit.laptopsModel == null) {
          return const Center(child: CircularProgressIndicator());
        }

        List<Product>? newProducts = cubit.laptopsModel?.newProducts;
        List<Product>? usedProducts = cubit.laptopsModel?.usedProducts;

        return BlocConsumer<FavoritesCubit, FavoritesStates>(
          listener: (context, favoritesState) {
           
          },
          builder: (context, favoritesState) {
            return Scaffold(
              backgroundColor: const Color.fromARGB(246, 240, 238, 241),
              appBar: AppBar(
                title: const Text('All Products'),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (newProducts != null && newProducts.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Chip(
                            label: const Text(
                              "New Offers",
                              style: TextStyle(
                                fontFamily: 'NeusaNextStd',
                                color: Color.fromARGB(230, 84, 52, 105),
                              ),
                            ),
                            backgroundColor: metal,
                          ),
                        ),
                      if (newProducts != null && newProducts.isNotEmpty)
                        SizedBox(
                          child: CarouselSlider(
                            items: newProducts
                                    .map((product) => buildProductItem(
                                          product,
                                          context,
                                          onTap: () {
                                            navigateToNextScreen(
                                              context,
                                              ProductDetailsScreen(
                                                  product: product),
                                            );
                                          },
                                        ))
                                    .toList()
                                ,
                            options: CarouselOptions(
                              height: MediaQuery.of(context).size.height * 0.3,
                              enlargeCenterPage: true,
                              autoPlay: true,
                              aspectRatio: 16 / 9,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enableInfiniteScroll: true,
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 700),
                              viewportFraction: 0.8,
                            ),
                          ),
                        ),
                      if (usedProducts != null && usedProducts.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Chip(
                            label: const Text(
                              "Used Products",
                              style: TextStyle(
                                fontFamily: 'NeusaNextStd',
                                color: Color.fromARGB(146, 84, 52, 105),
                              ),
                            ),
                            backgroundColor: metal,
                          ),
                        ),
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
                            usedProducts?.length ?? 0,
                            (index) => buildProductItem(
                              usedProducts![index], // Non-null assertion, adjust if needed
                              context,
                              onTap: () {
                                navigateToNextScreen(
                                  context,
                                  ProductDetailsScreen(
                                    product: usedProducts[index],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}


