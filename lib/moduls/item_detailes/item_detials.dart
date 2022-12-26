import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_app/models/item_model.dart';
import 'package:flutter_app/shared/style/colors.dart';
import 'package:flutter_app/shared/style/icon_broken.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

class ItemDetailesScreen extends StatelessWidget {
ItemModel itemModel;
 ItemDetailesScreen(this.itemModel){}

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Stack(
          children: [
            Container(
              height: 320.0,
              decoration:  BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(itemModel.itemImage!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            PositionedDirectional(
              top: 40,
              start: 16,
              child: Container(
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0)),
                child: IconButton(
                  onPressed: () {
                     Navigator.pop(context);
                  },
                  icon: Icon(
                    key: key,
                    IconBroken.Arrow___Left_2,
                  ),
                ),
              ),
            ),
            PositionedDirectional(
              end: 16,
              top: 40,
              child: Container(
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                    color: HexColor('f5f5f5'),
                    borderRadius: BorderRadius.circular(8.0)),
                child: IconButton(
                  onPressed: () {
                    // Navigator.pop(context);
                  },
                  icon: Icon(
                    key: key,
                    Icons.bookmark,
                    color: Colors.black54,
                    size: 24.0,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 296.0,
              child: Container(
                height: 800,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(24.0),
                    topEnd: Radius.circular(24.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           Text(
                            itemModel.title!,
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '\$${itemModel.price!}',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: defualtColor,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.home_outlined,
                                  size: 26,
                                  color: defualtColor,
                                ),
                                const SizedBox(
                                  width: 4.0,
                                ),
                                 Text(
                                  '${itemModel.badRoom} bad ',
                                  style: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.home_outlined,
                                  size: 26,
                                  color: defualtColor,
                                ),
                                const SizedBox(
                                  width: 4.0,
                                ),
                                const Text(
                                  '3 Bad',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.home_outlined,
                                  size: 26,
                                  color: defualtColor,
                                ),
                                const SizedBox(
                                  width: 4.0,
                                ),
                                const Text(
                                  '3 Bad',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 1.0,
                        width: double.infinity,
                        color: HexColor('f5f5f5'),
                      ),
                      const Padding(
                        padding:
                            EdgeInsetsDirectional.only(top: 16.0, bottom: 12.0),
                        child: Text(
                          'Where you\'ll be',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_sharp,
                            size: 26,
                            color: defualtColor,
                          ),
                          const SizedBox(
                            width: 4.0,
                          ),
                           Text(
                            itemModel.location!,
                            style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                            top: 8.0, bottom: 16.0),
                        child: Container(
                          width: double.infinity,
                          height: 160,
                          color: HexColor('f5f5f5'),
                          child: GoogleMap(
                            mapType: MapType.normal,
                            initialCameraPosition: _kGooglePlex,
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                            },
                          ),
                        ),
                      ),
                      const Text(
                        'Properties Details',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                       Padding(
                        padding: const EdgeInsetsDirectional.only(top: 16.0),
                        child: Text(
                          itemModel.propertiesDetails!,
                          style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
