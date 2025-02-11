import 'package:chatapptuto/pages/bloked_users_page.dart';
import 'package:chatapptuto/themes/themes_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title:  const Text("S E T T I N G S "),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body: 
      Center(
        child: 
        ConstrainedBox(constraints: const BoxConstraints(maxWidth: 600),
        child: Column(
          children: [
            //dark  mode 
        Container(
          decoration: BoxDecoration(
            color:Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(12),
          ),
         margin:  const  EdgeInsets.only(left: 25,top: 10,right: 25),
        padding: const EdgeInsets.only(left: 25,right: 25, top: 20, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //dark mode
              Text(
                "Dark Mode",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.inversePrimary),
                ),
          
            // swich toggle 
            CupertinoSwitch(
              value: Provider.of<ThemesProvider>(context , listen : false).isDarkMode, 
              onChanged: (value) => Provider.of<ThemesProvider>(context , listen : false).toggleTheme(),
          
              ),
          ],
        ),
     ),
        //blocked 
        Container(
          decoration: BoxDecoration(
            color:Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(12),
          ),
        margin:  const  EdgeInsets.only(left: 25,top: 10,right: 25),
        padding: const EdgeInsets.only(left: 25,right: 25, top: 20, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // tittle 
              Text(
                "Blocked Users",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.inversePrimary),
                ),

            // button to go blocked user page 
            IconButton(onPressed: ()=>Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BlokedUsersPage(),)),
              icon: Icon(Icons.arrow_forward_rounded,color: Theme.of(context).colorScheme.primary,
              ),
                ),
           
          ],
          ),
        ),
          ]
        )
      ),
      //blocked  users 
      )
    );
  }
}
