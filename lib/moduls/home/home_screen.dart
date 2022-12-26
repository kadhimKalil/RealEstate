import 'package:flutter/material.dart';
import 'package:flutter_app/layout/cubit/cubit.dart';
import 'package:flutter_app/layout/cubit/states.dart';
import 'package:flutter_app/layout/provider/item_provider.dart';
import 'package:flutter_app/layout/provider/saved_provider.dart';
import 'package:flutter_app/models/item_model.dart';
import 'package:flutter_app/moduls/item_detailes/item_detials.dart';
import 'package:flutter_app/shared/components/components.dart';
import 'package:flutter_app/shared/style/colors.dart';
import 'package:flutter_app/shared/style/icon_broken.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return BlocConsumer<RealEstateCubit, RealEstateStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var cubit = RealEstateCubit.get(context);
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            foregroundColor: Colors.black,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: Row(
              children: [
                CircleAvatar(
                    key: key,
                    radius: 24.0,
                    backgroundImage: const NetworkImage(
                        'https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg?w=740&t=st=1663938112~exp=1663938712~hmac=6f871e062ef2492d8a0d67bfe6852c26122336025894da25dff70a5172d5dca5')),
                const SizedBox(
                  width: 56.0,
                ),
                Icon(
                  key: key,
                  Icons.location_on_sharp,
                  color: defualtColor,
                ),
                const SizedBox(
                  width: 8.0,
                ),
                const Text(
                  'Hilla , Iraq',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                  onPressed: () {
                  },
                  icon: Icon(
                    Icons.notifications_none,
                    color: defualtColor,
                  )),
            ],
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 292.0,
                      decoration: BoxDecoration(
                        color: HexColor('f5f5f5'),
                        borderRadius: const BorderRadiusDirectional.vertical(
                          bottom: Radius.circular(40.0),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsetsDirectional.only(
                        top: 104.0,
                        start: 16.0,
                      ),
                      child: Text(
                        'Hollo,Ali',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        top: 128.0,
                        start: 16.0,
                      ),
                      child: Text(
                        'Let\'s find perfect place',
                        style: TextStyle(
                          fontSize: 20,
                          color: HexColor('414244'),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        top: 196.0,
                        start: 16.0,
                        end: 16.0,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                          hintText: 'Search Location..',
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16.0,
                          ),
                          prefixIcon: Container(
                            width: 24.0,
                            child: Image.asset('assets/images/search.png'),
                          ),
                          suffixIcon: Container(
                            margin: const EdgeInsetsDirectional.only(end: 8.0),
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              'assets/images/option.png',
                              width: 25.0,
                              color: defualtColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.only(start: 16.0, end: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                            top: 16.0, bottom: 12.0),
                        child: Row(
                          children: [
                            const Text(
                              'Resently Added ',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                Text(
                                  'View All',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: defualtColor,
                                      fontWeight: FontWeight.w500),
                                ),
                                Icon(
                                  IconBroken.Arrow___Right_2,
                                  color: defualtColor,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 296,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => buildHouseItem(
                                context, 248.0, model: cubit.item[index]),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  width: 16.0,
                                ),
                            itemCount: cubit.item.length),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                            top: 12.0, bottom: 4.0),
                        child: Row(
                          children: [
                            const Text(
                              'Recommended',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                Text(
                                  'View All',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: defualtColor,
                                      fontWeight: FontWeight.w500),
                                ),
                                Icon(
                                  IconBroken.Arrow___Down_2,
                                  color: defualtColor,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ListView.separated(
                            padding: const EdgeInsets.all(0.0),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => buildHouseItem(
                                context, double.infinity,
                                model: cubit.item[index]),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 16.0,
                                ),
                            itemCount: cubit.item.length),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildHouseItem(context, width, {required ItemModel model}) {
    var savedProvider = Provider.of<SavedProvider>(context);

    return Container(
      height: 296.0,
      width: width,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
          color: HexColor('f5f5f5'), borderRadius: BorderRadius.circular(16.0)),
      child: InkWell(
        onTap: () {
          navigatorTo(context: context, screen: ItemDetailesScreen(model));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                Container(
                  width: double.infinity,
                  height: 168.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    image: DecorationImage(
                      image: NetworkImage(
                        model.itemImage!,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.only(top: 10.0, end: 10.0),
                  child: Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.9),
                        borderRadius: BorderRadius.circular(8.0)),
                    child: StreamBuilder(
                      stream: savedProvider.collectionRef
                          .doc(savedProvider.currentUser!.email)
                          .collection('items')
                          .where('title', isEqualTo: model.title)
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshots) {
                        if (snapshots.data == null) {
                          return const Text('');
                        }
                        return IconButton(
                          onPressed: () {
                            snapshots.data.docs.length == 0
                                ? savedProvider.addToSaved(
                                    itemImage: model.itemImage!,
                                    title: model.title!,
                                    price: model.price!,
                                    location: model.location!,
                                  )
                                : savedProvider.deleteFromSaved(
                                    docx: snapshots.data.docs[0].id);
                          },
                          icon: Icon(
                            key: key,
                            Icons.bookmark,
                            color: snapshots.data.docs.length != 0
                                ? defualtColor
                                : Colors.black54,
                            size: 22.0,
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(
                top: 16.0,
                bottom: 8.0,
              ),
              child: Text(
                model.title!,
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: [
                Icon(
                  key: key,
                  Icons.location_on_outlined,
                  color: Colors.grey,
                ),
                Text(
                  model.location!,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 8.0),
              child: Text(
                '\$${model.price!}',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: defualtColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
