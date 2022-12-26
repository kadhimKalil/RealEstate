import 'package:flutter/material.dart';
import 'package:flutter_app/layout/cubit/cubit.dart';
import 'package:flutter_app/moduls/new_Item/new_Item.dart';
import 'package:flutter_app/shared/components/components.dart';
import 'package:flutter_app/shared/style/colors.dart';
import 'package:flutter_app/shared/style/icon_broken.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'cubit/states.dart';

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RealEstateCubit, RealEstateStates>(
      listener: (BuildContext context, state) {
        if(state is NewItemState){
          navigatorTo(context: context, screen: NewItem());
        }
      },
      builder: (BuildContext context, state) {
        var cubit = RealEstateCubit.get(context);
        return Scaffold(
          body: cubit.screen[cubit.currentIndex],
          bottomNavigationBar: Container(
            height: 80,
            decoration: BoxDecoration(
              color: HexColor('ffffff'),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(40.0),
              ),
            ),
            child: buildMyNavBar(context),
          ),
        );
      },
    );
  }

  Container buildMyNavBar(BuildContext context) {
    var cubit = RealEstateCubit.get(context);
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: HexColor('f5f5f5'),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(40.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              cubit.changeBottomNav(0);
            },
            icon: cubit.currentIndex == 0
                ?  Icon(
                    Icons.home_filled,
                    color:defualtColor,
                    size: 32,
                  )
                :  const Icon(
                    Icons.home_filled,
                    color: Colors.black54,
                    size: 32,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              cubit.changeBottomNav(1);
            },
            icon: cubit.currentIndex == 1
                ?  Icon(
                    Icons.bookmark,
                    color: defualtColor,
                    size: 32,
                  )
                :  const Icon(
                    Icons.bookmark,
                    color: Colors.black54,
                    size: 32,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              cubit.changeBottomNav(2);
            },
            icon: cubit.currentIndex == 2
                ?  Icon(
                    Icons.upload_file,
                    color: defualtColor,
                    size: 32,
                  )
                :  const Icon(
                    Icons.upload_file,
                    color: Colors.black54,
                    size: 32,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              cubit.changeBottomNav(3);
            },
            icon: cubit.currentIndex == 3
                ?  Icon(
                    Icons.message,
                    color: defualtColor,
                    size: 32,
                  )
                :  const Icon(
                    Icons.message,
                    color: Colors.black54,
                    size: 32,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              cubit.changeBottomNav(4);
            },
            icon: cubit.currentIndex == 4
                ?  Icon(
                    Icons.manage_accounts,
                    color: defualtColor,
                    size: 32,
                  )
                :  const Icon(
                    Icons.manage_accounts,
                    color: Colors.black54,
                    size: 32,
                  ),
          ),
        ],
      ),
    );
  }
}
