import 'package:flutter/material.dart';
import 'package:flutter_app/shared/style/colors.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../../layout/provider/saved_provider.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var savedProvider = Provider.of<SavedProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Saved')),
      ),
      body: Padding(
          padding: const EdgeInsetsDirectional.only(
              start: 16.0, end: 16.0, top: 20.0),
          child: StreamBuilder(
            stream: savedProvider.collectionRef
                .doc(savedProvider.currentUser!.email)
                .collection('items')
                .snapshots(),
            builder: (context, AsyncSnapshot snapshots) {
              if (snapshots.data == null) {
                return const Text('');
              }
              return ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      buildSavedItem(snapshots.data.docs[index], context),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemCount: snapshots.data.docs.length);
            },
          )),
    );
  }

  Widget buildSavedItem(item, context) {
    var savedProvider = Provider.of<SavedProvider>(context);

    return Container(
        height: 144.0,
        width: double.infinity,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: HexColor('f5f5f5'),
            borderRadius: BorderRadius.circular(16.0)),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 136,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    image: DecorationImage(
                      image: NetworkImage(
                        item['itemImage'],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.only(top: 10.0, start: 10.0),
                  child: Container(
                    height: 36.0,
                    width: 36.0,
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.9),
                        borderRadius: BorderRadius.circular(8.0)),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        savedProvider.deleteFromSaved(docx: item.id);
                      },
                      icon: Icon(
                        key: key,
                        Icons.bookmark,
                        color: defualtColor,
                        size: 22.0,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      bottom: 8.0,
                    ),
                    child: Text(
                      item['title'],
                      style: const TextStyle(
                        fontSize: 18.0,
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
                        item['location'],
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
                      '\$${item['price']}',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: defualtColor,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
