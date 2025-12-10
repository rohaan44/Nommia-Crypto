import 'package:flutter/material.dart';
import 'package:nommia_crypto/utils/color_utils.dart';

class CustomTabAppBarScreen extends StatefulWidget {
  @override
  State<CustomTabAppBarScreen> createState() => _CustomTabAppBarScreenState();
}

class _CustomTabAppBarScreenState extends State<CustomTabAppBarScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // 🔥 Aapki dynamic list
  final List<String> tabs = [
    "Overview",
    "Transactions",
    "Markets",
    "Portfolio",
    "Settings",
    "History",
    "Alerts",
  ];

  @override
  void initState() {
    _tabController = TabController(length: tabs.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,

        // 🔥 Upar Title
        title: Text(
          "My App",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),

        // 🔥 2 Icons in Action
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
        ],

        // 🔥 Neeche TabBar Scrollable
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white54,
              indicatorColor: Colors.red,
              indicatorWeight: 3,
              dividerColor: AppColor.transparent,
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              unselectedLabelStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),

              tabs: tabs.map((e) => Tab(text: e)).toList(),
            ),
          ),
        ),
      ),

      // Body linked with TabBar
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: tabs.map((e) {
                return Center(child: Text("$e Screen"));
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
