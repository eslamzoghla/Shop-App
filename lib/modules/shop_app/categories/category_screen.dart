import 'package:first_project/models/shopmodel/category_model.dart';
import 'package:first_project/modules/shop_app/cubit/cubit.dart';
import 'package:first_project/modules/shop_app/cubit/states.dart';
import 'package:first_project/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) => {},
      builder: (context, state) {
        return ListView.separated(
          separatorBuilder: (context, index) => myDivider(),
          itemBuilder: (context, index) => buildCatItemScreen(
              ShopCubit.get(context).categoryModel!.data!.data[index]),
          itemCount: ShopCubit.get(context).categoryModel!.data!.data.length,
        );
      },
    );
  }

  Widget buildCatItemScreen(dataModel? model) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          // ======================> Category Image <=========================
          Image(
            image: NetworkImage('${model!.image}'),
            height: 120.0,
            width: 120.0,
          ),

          SizedBox(
            width: 15.0,
          ),

          // ======================> Category Name <=========================
          Text(
            '${model.name}',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),

          Spacer(),

          // ================> Category Icon to show data <==================
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.navigate_next_outlined,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
