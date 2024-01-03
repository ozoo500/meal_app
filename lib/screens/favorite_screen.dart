import 'package:flutter/material.dart';
import 'package:meal_app/provider/meal.dart';
import 'package:provider/provider.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoriteScreen extends StatelessWidget {
  
  const FavoriteScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool isLandScape=MediaQuery.of(context).orientation==Orientation.landscape;
    var sizeDevice=MediaQuery.of(context).size.width;

    final List<Meal>favoriteMeal =Provider.of<MealProvider>(context).favoriteMeal ;

    if(favoriteMeal.isEmpty){
      return const Center(
        child: Text("You  have no favorite yet - start adding some!",style: TextStyle(color:Colors.white60,)),
      );
    }else{
      return  GridView.builder(
        gridDelegate:SliverGridDelegateWithMaxCrossAxisExtent(
          crossAxisSpacing:20 ,
          mainAxisSpacing:20 ,
          childAspectRatio: isLandScape? sizeDevice/(sizeDevice*0.8) : sizeDevice/(sizeDevice*0.75)  ,

          maxCrossAxisExtent:sizeDevice<= 400?400:500,
        ),
        itemCount: favoriteMeal.length,
        itemBuilder: (context, index) {
          return MealItem(
            id:favoriteMeal[index].id,
            imageUrl: favoriteMeal[index].imageUrl,
            title: favoriteMeal[index].title,
            duration: favoriteMeal[index].duration,
            complexity: favoriteMeal[index].complexity,
            affordability: favoriteMeal[index].affordability,
          );
        },
      );
    }

  }
}
