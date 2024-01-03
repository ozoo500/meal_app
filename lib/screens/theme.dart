import 'package:flutter/material.dart';
import 'package:meal_app/provider/theme_provider.dart';
import 'package:meal_app/widgets/custom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
class ThemeScreen extends StatelessWidget {
  const ThemeScreen({Key? key}) : super(key: key);
    static String routeName='theme';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(title: const Text("Your Themes"),),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text("Adjust your themes selection",style:Theme.of(context).textTheme.headline6
            ),
    ),
          Expanded(
              child:ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Text("Choose your Theme Mode",style:Theme.of(context).textTheme.headline6
                    ),
                  ),
                  buildRadioListTile( ThemeMode.system,"System Default Theme",Icons.start,context),
                  buildRadioListTile( ThemeMode.light,"Light Theme",Icons.wb_sunny_outlined,context),
                  buildRadioListTile( ThemeMode.dark,"Dark Theme",Icons.nights_stay_outlined,context),
                 buildListTile(context,'primary'),
                 buildListTile(context,'accent'),

                ],
              ),
          ),
        ],
      ),
      drawer: const MainDrawer(),
    );
  }

  buildRadioListTile(ThemeMode themeMode,String txt,IconData icon,BuildContext ctx) {
    return RadioListTile(
      secondary: Icon(icon,color: Theme.of(ctx).buttonColor,),
        value: themeMode,
        groupValue:Provider.of<ThemeProvider>(ctx,listen: true).tm ,
        onChanged:(newTheme){
          Provider.of<ThemeProvider>(ctx,listen:false).themeModeChange(themeMode);
        },
        title: Text(txt),);
  }

  buildListTile(BuildContext context,txt) {
    var primaryColor =Provider.of<ThemeProvider>(context,listen: true).primaryColor;
    var accentColor =Provider.of<ThemeProvider>(context,listen: true).accentColor;
    return ListTile(
      title: Text("Choose your $txt color",style:Theme.of(context).textTheme.headline6,),
      trailing: CircleAvatar(
        backgroundColor: txt=='primary'?primaryColor:accentColor,),
      onTap: (){
            showDialog(context: context, builder: (BuildContext context){
              return AlertDialog(
               elevation: 4,
                 titlePadding: const EdgeInsets.all(0.0) ,
                contentPadding: const EdgeInsets.all(0.0),
                content: SingleChildScrollView(
                  child: ColorPicker(
                 pickerColor: txt =='primary'?
                      Provider.of<ThemeProvider>(context,listen: true).primaryColor
                    :Provider.of<ThemeProvider>(context,listen: true).accentColor,
                    onColorChanged:(newColor)=>
                        Provider.of<ThemeProvider>(context,listen: false).onChanged(newColor,txt=='primary'?1:2),
                    colorPickerWidth: 300.0,
                    pickerAreaHeightPercent: 0.7,
                    enableAlpha: false,
                    displayThumbColor: true,
                    showLabel: false,
                  ),
                ),
              );
            });
      },
    );
  }
}




