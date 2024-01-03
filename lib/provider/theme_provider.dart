import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier{
     var primaryColor=Colors.pink;
     var accentColor=Colors.amber;
     var tm=ThemeMode.system;
     String textTheme="s";
     onChanged(newColor,n)async{
       n==1 ?
           primaryColor=_setMaterialColor(newColor.hashCode)
           :accentColor =_setMaterialColor(newColor.hashCode);
       notifyListeners();
       SharedPreferences preferences=await SharedPreferences .getInstance();
       preferences.setInt("primaryColor",  primaryColor.value);
       preferences.setInt("accentColor",  accentColor.value);
     //  notifyListeners();
     }
     getThemeColor()async{
       SharedPreferences preferences=await SharedPreferences .getInstance();
       primaryColor=_setMaterialColor(preferences.getInt("primaryColor" )??0xFFE91E63);//??primaryColor.hashCode);
       accentColor=_setMaterialColor(preferences.getInt("accentColor" )??0xFFFFC107);//?? accentColor.hashCode);
       notifyListeners();
     }

  MaterialColor _setMaterialColor(int hashCode) {
             return MaterialColor(
               hashCode,
               <int, Color>{
                 50: const Color(0xFFFCE4EC),
                 100: const Color(0xFFF8BBD0),
                 200: const Color(0xFFF48FB1),
                 300: const Color(0xFFF06292),
                 400: const Color(0xFFEC407A),
                 500: Color(hashCode),
                 600: const Color(0xFFD81B60),
                 700: const Color(0xFFC2185B),
                 800: const Color(0xFFAD1457),
                 900: const Color(0xFF880E4F),
               },
             );
  }
void themeModeChange(newVal)async{
       tm=newVal;
       _getTextTheme(tm);
       notifyListeners();
       SharedPreferences preferences=await SharedPreferences .getInstance();
       preferences.setString("textTheme", textTheme);
}
    _getTextTheme(ThemeMode tm){
       if(tm==ThemeMode.dark){
         textTheme="d";
       }
       else if(tm==ThemeMode.light){
         textTheme="l";
       }
      else  if(tm==ThemeMode.system){
         textTheme="s";
       }
    }

     getThemeMode()async{
       SharedPreferences preferences=await SharedPreferences .getInstance();
      textTheme= preferences.getString("textTheme")??"s";
       if(  textTheme=="d"){
       tm=ThemeMode.dark;
       }
      else if(  textTheme=="l"){
       tm=ThemeMode.light;
       }
       else if(  textTheme=="s"){
       tm=ThemeMode.system;
       }
      notifyListeners();
     }
}