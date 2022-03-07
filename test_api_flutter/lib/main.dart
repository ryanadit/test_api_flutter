import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_api_flutter/bloc/user_data_bloc_cubit.dart';

import 'bloc/user_data_bloc_state.dart';
import 'model/user_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => UserDataCubit()..initData(),
        child: const MyPage(),
      ),
    );
  }
}

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {

  TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<UserDataCubit, UserDataState>(
        builder: (context, state) {
          if(state is UserBlocLoadedState) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("List USer"),
              ),
              body: Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(20),
                      alignment: Alignment.center,
                      child: TextFormField(
                        controller: textEditingController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            hintText: "Search User ID"
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 10
                            ),
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.green
                              ),
                              onPressed: () {
                                context.read<UserDataCubit>().initData();
                              },
                              child: const Text("Refresh", style: TextStyle(
                                  color: Colors.white
                              ),),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              right: 10
                          ),
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.blue
                            ),
                            onPressed: () {
                              context.read<UserDataCubit>().getSearchData(textEditingController.text);
                            },
                            child: const Text("Cari", style: TextStyle(
                                color: Colors.white
                            ),),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: UserBlocLoadedScreen(data : state.data),
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is UserBlocFailedState) {
            return Scaffold(
              body: Center(
                child: Container(
                  alignment: Alignment.center,
                  child: const Text("Failed Load"),
                ),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              ),
            ),
          );
        });
  }
}


class UserBlocLoadedScreen extends StatelessWidget {
  final List<UserModel>? data;

  const UserBlocLoadedScreen({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data!.length,
      itemBuilder: (context, index) {
        return itemWidget(context,data![index]);
      },
    );
  }

  Widget itemWidget(BuildContext context, UserModel? data){
    return Container(
      alignment: Alignment.center,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(25),
              child: Text("${data?.title}", textAlign: TextAlign.center, style: TextStyle(
                color: Colors.grey.shade800,
                fontWeight: FontWeight.bold
              ),),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Text("ID : ${data?.id}", textDirection: TextDirection.ltr),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Text("${data?.body}", textDirection: TextDirection.ltr, textAlign: TextAlign.center,),
            )
          ],
        ),
      ),
    );
  }

}

