import 'package:carousel_slider/carousel_slider.dart';
import 'package:first_task_1/core/controllers/cart_cubit/cart_cubit.dart';
import 'package:first_task_1/core/managers/values.dart';
import 'package:first_task_1/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;
  const ProductDetailsScreen({Key? key, required this.product})
      : super(key: key);

  Widget buildAppBar(BuildContext context) {
    return AppBar(
      title: Text.rich(
        TextSpan(
          text: product.name ?? 'Product Details',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          children: [
            if (product.name == null)
              const TextSpan(
                text: ' (name not available)',
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return ListView(
      children: [
        buildImageSlider(context),
        buildProductInfo(context),
      ],
    );
  }

  Widget buildImageSlider(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: CarouselSlider.builder(
        itemCount: product.images?.length ?? 0,
        itemBuilder: (context, index, realIndex) {
          return Image.network(
            product.images![index],
            fit: BoxFit.cover,
          );
        },
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height * 0.3,
          enlargeCenterPage: true,
          autoPlay: true,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          viewportFraction: 0.8,
        ),
      ),
    );
  }

  Widget buildProductInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          space,
          buildPrice(context),
          space,
          buildCategory(context),
          space,
          buildDescription(context),
          space,
          buildCompany(context),
          space,
          buildAvailability(context),
          space,
          buildAddToCartButton(context),
          space,
        ],
      ),
    );
  }

  Widget buildPrice(BuildContext context) {
    final formatter = NumberFormat.currency(locale: 'en_US', symbol: '\$');
    return Text(
      'Price: ${formatter.format(product.price ?? 0)}',
      style: const TextStyle(
          fontSize: 18,
          color: Color.fromARGB(255, 248, 79, 12),
          fontWeight: FontWeight.w400),
    );
  }

  Widget buildCategory(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          WidgetSpan(
            child: Chip(
              label: Text(product.category ?? 'Unknown'),
              avatar: const Icon(Icons.laptop_chromebook_sharp,
                  color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDescription(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description: ',
            style: TextStyle(fontSize: 16, color: metal),
          ),
          space,
          Text.rich(
            TextSpan(
              children: [
                WidgetSpan(
                  child: Text(
                    product.description ?? 'No description available',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                  ),
                ),
              ],
            ),
          )
        ]);
  }

  Widget buildCompany(BuildContext context) {
    return Row(
      children: [
        Text(
          'Company: ',
          style: TextStyle(fontSize: 16, color: metal),
        ),
        SizedBox(width: 15),
        Text.rich(
          TextSpan(
            text: product.company ?? ' Unknown',
          ),
        )
      ],
    );
  }

  Widget buildAvailability(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: 'Availability: ',
        style: TextStyle(fontSize: 16, color: metal),
        children: [
          TextSpan(
            text: '${product.countInStock ?? 0} in stock',
            style: TextStyle(
              color: product.countInStock! > 0 ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAddToCartButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.add_shopping_cart, color: metal, size: 50),
      onPressed: () {
        CartCubit.get(context).addToCart(product.sId);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Added ${product.name} to cart'),
          ),
        );
      },
      tooltip: 'Add to cart',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text.rich(
          TextSpan(
            text: product.name ?? 'Product Details',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            children: [
              if (product.name == null)
                const TextSpan(
                  text: ' (name not available)',
                  style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                ),
            ],
          ),
        ),
      ),
      body: buildBody(context),
    );
  }
}
