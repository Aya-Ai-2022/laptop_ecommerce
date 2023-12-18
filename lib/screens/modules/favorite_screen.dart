import 'package:first_task_1/core/controllers/favorite_cubit/favorite_cubit.dart';
import 'package:first_task_1/core/controllers/favorite_cubit/favorite_states.dart';
import 'package:first_task_1/core/controllers/products_controller/product_cubit.dart';
import 'package:first_task_1/models/favorite_model.dart';
import 'package:first_task_1/screens/modules/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoritesCubit, FavoritesStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = FavoritesCubit.get(context);
          if (cubit.favoritesList?.products?.isEmpty == true) {
            return const Center(child: CircularProgressIndicator());
          }

          return Scaffold(
              backgroundColor: Colors.grey[200],
              appBar: AppBar(
                backgroundColor: Colors.grey[200],
                title: const Text('Favorites'),
                centerTitle: true,
              ),
              body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                      child: Column(children: [
                    if (cubit.favoritesList?.products?.isNotEmpty == true)
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => _buildFavoriteItem(
                              cubit.favoritesList!.products![index], context),
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 30,
                              ),
                          itemCount: cubit.favoritesList!.products!.length),
                    if (cubit.favoritesList?.products?.isEmpty == true)
                      const Center(
                        child: Text('No favorite products.'),
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ]))));
        });
  }

  Widget _buildFavoriteItem(Productf product, BuildContext context) {
    return GestureDetector(
        child: Card(
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Image.network(
              product.image!,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(product.name!),
            subtitle: Text('\$${product.price}'),
            trailing: IconButton(
              icon: const Icon(Icons.favorite),
              color: Colors.red,
              onPressed: () {
                FavoritesCubit.get(context).removeFromFavorites(product.sId!);
              },
            ),
          ),
        ),
        onTap: () {
          for (var element
              in ProductCubit.get(context).laptopsModel!.product!) {
            if (element.sId == product.sId) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(product: element),
                ),
              );
            }
          }
        });
  }
}
