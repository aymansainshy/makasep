import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../providers/categories_provider.dart';
import '../bloc/fetch_type/fetch_type_bloc.dart';
import '../widgets/category_Item.dart';
import '../utils/app_constant.dart';
import '../widgets/drawer.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/Home-screen";
  const HomeScreen({
    Key key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    ScreenUtil screenUtil = ScreenUtil();
    // var mediaQuery = MediaQuery.of(context).size;
    // var isLandScape =
    //     MediaQuery.of(context).orientation == Orientation.landscape;
    final categoriesProvider =
        Provider.of<CategoriesProvider>(context, listen: false);
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "الصفحة الرئيسية",
          style: TextStyle(fontSize: 15),
        ),
      ),
      body: BlocConsumer<FetchTypeBloc, FetchTypeState>(
        listener: (context, state) {
          if (state is FetchTypeInProgress) {
            showDialog(
              context: context,
              builder: (ctx) => GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {},
                child: Center(
                  child: sleekCircularSlider(
                    context,
                    40,
                    AppColors.primaryColor,
                    AppColors.scondryColor,
                  ),
                ),
              ),
            );
          }
          if (state is FetchTypeError) {
            Navigator.of(context).pop();
            showDialog(
              context: context,
              builder: (ctx) => GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {},
                child: AlertDialog(
                  title: Text("يوجد خطأ"),
                  content: Text(state.errorMassege),
                  actions: [
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("حسنا"),
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is FetchTypeDone) {
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Container(
                height: screenUtil.setHeight(500),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.red,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      "assets/images/sudan.png",
                    ),
                  ),
                ),
                child: Container(
                  color: Colors.black54,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: GridView.builder(
                    itemCount: categoriesProvider.categoryList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) => CategoryItem(
                      screenUtil: screenUtil,
                      category: categoriesProvider.categoryList[index],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
