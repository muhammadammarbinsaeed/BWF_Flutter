// ignore_for_file: unused_import, unnecessary_import, unused_result

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:task_6_e_commerce_gharmall/providers.dart';
import 'package:task_6_e_commerce_gharmall/screens/cartdisplay.dart';
import 'package:task_6_e_commerce_gharmall/screens/favourite_screen.dart';
import 'package:task_6_e_commerce_gharmall/screens/loginseller.dart';
import 'package:task_6_e_commerce_gharmall/screens/recentorders.dart';
import 'package:task_6_e_commerce_gharmall/screens/sellerview/orderpage.dart';
import 'package:task_6_e_commerce_gharmall/screens/sellerview/profilepage.dart';
import 'package:task_6_e_commerce_gharmall/screens/sellerview/storepage.dart';
import 'package:task_6_e_commerce_gharmall/screens/sellerview/view.dart';
import 'package:fan_side_drawer/fan_side_drawer.dart';
class Sellerhomepage extends StatefulWidget {
  const Sellerhomepage({super.key});

  @override
  State<Sellerhomepage> createState() => _SellerhomepageState();
}

class _SellerhomepageState extends State<Sellerhomepage> {
  var screens = [viewpage(),storepage(),Orderpage(),Profilepage()];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {  
        List<DrawerMenuItem> menuItems = [
    DrawerMenuItem(title: 'Home',icon: Icons.person_2,iconSize: 15, onMenuTapped:(){
      //ref.read(navbarProvider.notifier).state = 0; // Home index
         // Navigator.pop(context);
    }),
    DrawerMenuItem(title: 'Favourites',icon: Icons.favorite_outline,iconSize: 15, onMenuTapped:() async {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>favouritescreen())).then((_) {
                  ref.read(navbarProvider.notifier).state = 0;
                });

    }),
    DrawerMenuItem(title: 'Carts',icon: Icons.shopping_bag,iconSize: 15, onMenuTapped:(){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Cartdata()));
    }),
    DrawerMenuItem(title: 'Recent Orders',icon: Icons.format_list_bulleted_rounded,iconSize: 15, onMenuTapped:(){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>recentorders()));
    }),
    DrawerMenuItem(title: 'Log Out',icon: Icons.logout_rounded,iconSize: 15, onMenuTapped:(){
       FirebaseAuth.instance.signOut().then((value){
                ref.invalidate(passwordvisibleprovider);
ref.invalidate(passwordvisibleseller);
ref.invalidate(navbarProvider);
ref.invalidate(imageprovider);
ref.invalidate(productvariation);
ref.invalidate(categoryprovider);
ref.invalidate(fetchingstoredata);
ref.invalidate(fetchuserdata);
ref.invalidate(carouselprovider);
ref.invalidate(textcolor);
ref.invalidate(activeChip);
ref.invalidate(productProvider);
ref.invalidate(productowner);
ref.invalidate(quantityprovider);
ref.invalidate(productscreenvariationsprovider);
ref.invalidate(cartbuttontextprovider);
ref.invalidate(favoriteStatusProvider);
ref.invalidate(fetchFavoriteStatusProvider);
ref.invalidate(fetchfavourites);
ref.invalidate(fetchcarts);
ref.invalidate(cartprice);
ref.invalidate(fetchrecentorders);
ref.invalidate(userProvider);
ref.invalidate(userStateProvider);


              });
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>loginseller()));
    }),
  ];
        final selectedindex = ref.watch(navbarProvider);
        // ignore: unused_local_variable
      return Scaffold(
        drawer: Drawer(
          width: 255,
          child: FanSideDrawer(
            drawerType: DrawerType.pipe,
            menuItems: menuItems,
          ),
        ),
        appBar: AppBar(
          title: Text('Your own Shopping Centre',style: TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.bold),),
          centerTitle: true
          ,
          backgroundColor: Color.fromARGB(255, 199, 203, 253),

          ),
       
        bottomNavigationBar: NavigationBar(
          backgroundColor: Color.fromARGB(255, 199, 203, 253),
          indicatorColor: Colors.white,
          height: 60,
          elevation: 0,
          selectedIndex: selectedindex,
          onDestinationSelected: (index){
            ref.read(navbarProvider.notifier).state = index;
          },
          destinations: [
          NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.shop), label: 'Store'),
            NavigationDestination(icon: Icon(Iconsax.wallet_check), label: 'Orders'),
             NavigationDestination(icon: Icon(Iconsax.profile_add), label: 'Profile')
          ]
          ),
          body: screens[selectedindex],
      );
      }
    );
    
  }
}