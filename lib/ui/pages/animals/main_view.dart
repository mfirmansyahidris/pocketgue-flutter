// ignore_for_file: unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocketgue/ui/pages/animals/saved/saved_bloc.dart';
import 'package:pocketgue/ui/ui.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: "title",
          child: Text(
            Strings.get.appName,
            style: TextStyles.h3.copyWith(
                fontWeight: FontWeight.bold,
                color: Palette.white
            ),
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(icon: const Icon(Icons.pets), text: Strings.get.animals),
            Tab(icon: const Icon(Icons.save), text: Strings.get.saved),
          ],
        ),
        centerTitle: true,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          BlocProvider(create: (context) => AnimalsBloc(), child: const AnimalsView()),
          BlocProvider(create: (context) => SavedBloc(), child: const SavedView()),
        ],
      ),
    );
  }
}
