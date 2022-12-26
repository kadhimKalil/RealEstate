import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_app/layout/cubit/cubit.dart';
import 'package:flutter_app/layout/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RealEstateCubit,RealEstateStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, state) {
        return Scaffold(
        appBar: AppBar(),
        body: Text('data'),
      );
        },
     
    );
  }
}