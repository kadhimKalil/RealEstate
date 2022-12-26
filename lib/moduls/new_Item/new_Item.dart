import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/layout/cubit/cubit.dart';
import 'package:flutter_app/layout/cubit/states.dart';
import 'package:flutter_app/shared/components/components.dart';
import 'package:flutter_app/shared/style/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class NewItem extends StatelessWidget {
  var titleController = TextEditingController();
  var locationController = TextEditingController();
  var priceController = TextEditingController();
  var badroomController = TextEditingController();
  var bathroomController = TextEditingController();
  var detailsController = TextEditingController();
  var areaController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RealEstateCubit, RealEstateStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = RealEstateCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'New Item',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (formKey.currentState!.validate() &&
                      cubit.itemImage != null) {
                    cubit.uploadItemImage(
                        title: titleController.text,
                        location: locationController.text,
                        price: priceController.text,
                        area: areaController.text,
                        badRoom: badroomController.text,
                        bathRoom: bathroomController.text,
                        propertiesDetails: detailsController.text);
                  }
                },
                child: const Text(
                  'AddItem',
                  style: TextStyle(
                    color: Colors.pinkAccent,
                  ),
                ),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsetsDirectional.only(
              bottom: 16,
              top: 20,
              start: 16,
              end: 16,
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (state is LoadingUploadItemImageState)
                      const LinearProgressIndicator(),
                    if (state is LoadingUploadItemImageState)
                      const SizedBox(
                        height: 16.0,
                      ),
                    defualtFormField(
                      controller: titleController,
                      prefixIcon: Icons.home_outlined,
                      hintText: 'Home Title',
                      keyboardType: TextInputType.name,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Home Title';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    defualtFormField(
                      controller: locationController,
                      prefixIcon: Icons.location_on_outlined,
                      hintText: 'Location',
                      keyboardType: TextInputType.name,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Location';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    defualtFormField(
                      controller: priceController,
                      prefixIcon: Icons.price_change_outlined,
                      hintText: 'Price',
                      keyboardType: TextInputType.name,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Location';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    defualtFormField(
                      controller: areaController,
                      prefixIcon: Icons.area_chart_outlined,
                      hintText: 'Area',
                      keyboardType: TextInputType.number,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Area';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: defualtFormField(
                            controller: badroomController,
                            prefixIcon: Icons.room_service_outlined,
                            hintText: 'badNum',
                            keyboardType: TextInputType.number,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please Enter badroom';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 16.0,
                        ),
                        Expanded(
                          child: defualtFormField(
                            controller: bathroomController,
                            prefixIcon: Icons.bathroom_outlined,
                            hintText: 'bathNum',
                            keyboardType: TextInputType.number,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please Enter bathroom';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    defualtFormField(
                      maxLines: 3,
                      controller: detailsController,
                      hintText: 'Details',
                      keyboardType: TextInputType.name,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Details';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    cubit.itemImage != null
                        ? InkWell(
                            onTap: () {
                              cubit.getItemImage();
                            },
                            child: Container(
                              height: 128,
                              width: double.infinity,
                              child: Image(
                                image: FileImage(cubit.itemImage!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : DottedBorder(
                            color: defualtColor,
                            strokeWidth: 2,
                            dashPattern: const [
                              5,
                              5,
                            ],
                            child: Container(
                              height: 128,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: HexColor('f5f5f5'),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  cubit.getItemImage();
                                },
                                child: const Text(
                                  '+',
                                  style: TextStyle(
                                    fontSize: 28.0,
                                  ),
                                ),
                              ),
                            ),
                          )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
