import 'package:flutter/material.dart';
import 'package:news_app_with_proider_jann/controller/home_screen_controller.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<HomeScreenController>().getData("bbc");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeScreenController>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<HomeScreenController>().getData("apple");
        },
      ),
      body: provider.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: provider.resModel?.articles?.length ?? 0,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(provider.resModel?.articles?[index].title ?? ""),
                );
              },
            ),
    );
  }
}
