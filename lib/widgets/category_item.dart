import 'package:flutter/material.dart';
import '../screens/category_meal_screen.dart';

class CategoryItem extends StatelessWidget {

  final String id;
  final String title;
  final Color color;

  const CategoryItem(
        this.id,
       this.title,
      this.color);
    void selectCategory(BuildContext ctx){
      Navigator.of(ctx).pushNamed(CategoryMealScreen.routeName,
      arguments: {
        'id':id,
        'title':title,
      }
      );
    }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(22.0),
      onTap: ()=>selectCategory(context),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Text(title,style: Theme.of(context).textTheme.subtitle1,),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22.0),
          color: color,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withOpacity(0.7),
              color,
            ]
          )
        ),
      ),
    );
  }
}
