import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/provider/meal.dart';
import 'package:meal_app/widgets/category_item.dart';
import 'package:provider/provider.dart';
class CategoryScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView(
        padding: const EdgeInsets.all(25.0),
          children: Provider.of<MealProvider>(context).availableCategory.map((catData) =>
          CategoryItem(catData.id, catData.title, catData.color),
          ).toList(),
          gridDelegate:const SliverGridDelegateWithMaxCrossAxisExtent(
            crossAxisSpacing:20 ,
            mainAxisSpacing:20 ,
           childAspectRatio:3/2 ,
            maxCrossAxisExtent: 400,
          ),
      ),
    );
  }
}
