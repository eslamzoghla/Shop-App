import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:first_project/models/shopmodel/category_model.dart';
import 'package:first_project/models/shopmodel/home_model.dart';
import 'package:first_project/modules/shop_app/cubit/cubit.dart';
import 'package:first_project/modules/shop_app/cubit/states.dart';
import 'package:first_project/styles/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) => {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null &&
              ShopCubit.get(context).categoryModel != null,
          builder: (context) => productsBuilder(
              ShopCubit.get(context).homeModel!,
              ShopCubit.get(context).categoryModel!,
              context),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productsBuilder(
      HomeModel model, CategoryModel categoryModel, context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          CarouselSlider(
            items: model.data!.banners
                .map(
                  (e) => Image(
                    image: NetworkImage(
                      '${e.image}',
                    ),
                    fit: BoxFit.fill,
                    width: double.infinity,
                  ),
                )
                .toList(),
            options: CarouselOptions(
              autoPlay: true,
              enableInfiniteScroll: true,
              initialPage: 0,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              height: 250.0,
              scrollDirection: Axis.horizontal,
              autoPlayCurve: Curves.fastOutSlowIn,
              viewportFraction: 1.0,
              autoPlayInterval: Duration(seconds: 2),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 130,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        buildCategoryItem(categoryModel.data!.data[index]),
                    separatorBuilder: (context, index) => SizedBox(width: 10.0),
                    itemCount: categoryModel.data!.data.length,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Products',
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
              childAspectRatio: 1 / 1.61,
              children: List.generate(
                model.data!.products.length,
                (index) =>
                    buildGridProducts(model.data!.products[index], context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategoryItem(dataModel model) {
    return Container(
      width: 90.0,
      height: 120.0,
      child: Column(
        children: [
          CircleAvatar(
            radius: 35.0,
            child: Image(
              image: NetworkImage('${model.image}'),
              width: 120.0,
              height: 120.0,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            '${model.name}',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget buildGridProducts(ProductModel model, context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(alignment: AlignmentDirectional.bottomStart, children: [
            Stack(
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  color: Colors.white,
                ),
                Image(
                  image: NetworkImage('${model.image}'),
                  height: 180,
                  width: double.infinity,
                ),
              ],
            ),
            if (model.discount != 0)
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Container(
                    color: Colors.red,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'Discount',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    )),
              )
          ]),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              '${model.name}',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style:
                  Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 13),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('EGP',
                                style: Theme.of(context).textTheme.caption),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${model.price}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 15),
                            ),
                          ],
                        ),
                        if (model.discount != 0)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('EGP',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                        decoration: TextDecoration.lineThrough,
                                      )),
                              Text(
                                '${model.oldPrice}',
                                style: const TextStyle(
                                    fontSize: 11,
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${model.discount}' + '%OFF',
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 9),
                              )
                            ],
                          ),
                      ]),
                ),
                IconButton(
                  onPressed: () {
                    ShopCubit.get(context).changeFavourites(model.id!);

                    if (kDebugMode) {
                      print(model.id);
                    }
                  },
                  icon: CircleAvatar(
                    radius: 20,
                    backgroundColor:
                        ShopCubit.get(context).favourites[model.id!]!
                            ? Colors.red
                            : defaultColor,
                    child: const Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      // size: 10,
                    ),
                  ),
                  iconSize: 16,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
