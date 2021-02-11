import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../widgets/advertisment_info.dart';
import '../bloc/semilar_real_estate/semilar_real_estate_bloc.dart';
import '../bloc/post_favorites/post_favorites_bloc.dart';
import '../providers/auth_provider.dart';
import '../models/real_estate_model.dart';
import '../widgets/discreption_text.dart';
import '../widgets/location_on_map.dart';
import '../widgets/real_estate_item.dart';
import '../utils/app_constant.dart';

class RealEstateDetailScreen extends StatefulWidget {
  static const routeName = '/real-estate-detail-screen';

  final RealEstate realEstat;

  const RealEstateDetailScreen({Key key, this.realEstat}) : super(key: key);

  @override
  _RealEstateDetailScreenState createState() => _RealEstateDetailScreenState();
}

class _RealEstateDetailScreenState extends State<RealEstateDetailScreen> {
  var _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _setIsFav();
  }

  _setIsFav() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(widget.realEstat.id)) {
      return false;
    }
    setState(() {
      _isFavorite = prefs.getBool(widget.realEstat.id);
    });
  }

  void _taggleFavorit() async {
    setState(() {
      _isFavorite = !_isFavorite;
    });

    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(widget.realEstat.id)) {
      prefs.remove(widget.realEstat.id);
    }
    prefs.setBool(widget.realEstat.id, _isFavorite);
  }

  _loadedDate() async {
    BlocProvider.of<SemilarRealEstateBloc>(context, listen: false).add(
      FetchSemilarRealEstate(realEstateId: widget.realEstat.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    _loadedDate();
    final userDate = Provider.of<AuthProvider>(context, listen: false);
    ScreenUtil.init(context);
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    ScreenUtil screenUtil = ScreenUtil();
    return Scaffold(
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 15.0,
              spreadRadius: 0.5,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: BlocListener<PostFavoritesBloc, PostFavoritesState>(
          listener: (context, state) {
            if (state is PostFavoritesDone) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(milliseconds: 500),
                  content: Text("تمت العملية بنجاح"),
                ),
              );
            }
            if (state is PostFavoritesError) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMassege),
                ),
              );
            }
          },
          child: Container(
            color: Colors.white,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  _taggleFavorit();
                  BlocProvider.of<PostFavoritesBloc>(context).add(
                    PostFavoriteRealEstate(
                      realEstatsId: widget.realEstat.id,
                      userId: userDate.userId,
                    ),
                  );
                },
                child: Icon(
                  _isFavorite ? Icons.star : Icons.star_border,
                  size: 30,
                  color: Colors.orangeAccent,
                ),
              ),
            ),
          ),
        ),
      ),
      // appBar: AppBar(
      //   backgroundColor: AppColors.primaryColor,
      //   title: Text("Real Estates Detail"),
      // ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 230,
            backgroundColor: AppColors.primaryColor,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              "تفاصيل العقار",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            collapsedHeight: 65,
            pinned: true,
            elevation: 0.0,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0, top: 15.0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: isLandScape
                        ? screenUtil.setSp(40)
                        : screenUtil.setSp(60),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: isLandScape
                          ? screenUtil.setSp(50)
                          : screenUtil.setSp(60),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Container(),
            ],
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: [
                StretchMode.zoomBackground,
              ],
              background: Image.network(
                "${widget.realEstat.imageUrl}",
                fit: BoxFit.fill,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Text(
                    '${realEstateType(widget.realEstat.type)} ${realEstatePrimaryType(widget.realEstat.categoryType)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: isLandScape
                          ? screenUtil.setSp(30)
                          : screenUtil.setSp(45),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${widget.realEstat.price}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: isLandScape
                                ? screenUtil.setSp(30)
                                : screenUtil.setSp(45),
                            color: AppColors.scondryColor,
                          ),
                        ),
                        TextSpan(
                          text: 'جنيه',
                          style: TextStyle(
                            // fontFamily: "Cairo",
                            color: Colors.red,
                            fontSize: isLandScape
                                ? screenUtil.setSp(20)
                                : screenUtil.setSp(30),
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Text(
                    // realEstat.hashCode.toString(),
                    "الخرطوم الرياض , شارع المشتل",
                    style: TextStyle(
                      // fontFamily: "Cairo",
                      color: Colors.grey.shade700,
                      fontSize: isLandScape
                          ? screenUtil.setSp(20)
                          : screenUtil.setSp(40),
                      letterSpacing: 1,
                    ),
                  ),
                ),
                BuildContainerRowText(
                  isLandScape: isLandScape,
                  screenUtil: screenUtil,
                  color: Colors.grey.shade100,
                  text: "النوع",
                  widget: Text(
                    "${realEstateType(widget.realEstat.type)}",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: isLandScape
                          ? screenUtil.setSp(20)
                          : screenUtil.setSp(40),
                      letterSpacing: 1,
                    ),
                  ),
                ),
                BuildContainerRowText(
                  isLandScape: isLandScape,
                  screenUtil: screenUtil,
                  color: Colors.grey.shade300,
                  text: "المساحة",
                  widget: FittedBox(
                    child: Text(
                      "${widget.realEstat.area}",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: isLandScape
                            ? screenUtil.setSp(20)
                            : screenUtil.setSp(40),
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                BuildContainerRowText(
                  isLandScape: isLandScape,
                  screenUtil: screenUtil,
                  color: Colors.grey.shade100,
                  text: "الغرف",
                  widget: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/bed.png",
                        color: Colors.grey.shade400,
                      ),
                      SizedBox(width: 3),
                      Text(
                        "${widget.realEstat.details.rooms}",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: isLandScape
                              ? screenUtil.setSp(20)
                              : screenUtil.setSp(40),
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                BuildContainerRowText(
                  isLandScape: isLandScape,
                  screenUtil: screenUtil,
                  color: Colors.grey.shade300,
                  text: "الصالة",
                  widget: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/sofa.png",
                        color: Colors.grey.shade400,
                      ),
                      SizedBox(width: 3),
                      Text(
                        "${widget.realEstat.details.hall}",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: isLandScape
                              ? screenUtil.setSp(20)
                              : screenUtil.setSp(40),
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                BuildContainerRowText(
                  isLandScape: isLandScape,
                  screenUtil: screenUtil,
                  color: Colors.grey.shade100,
                  text: "الحمام",
                  widget: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/desh.png",
                        color: Colors.grey.shade400,
                      ),
                      SizedBox(width: 6),
                      Text(
                        "${widget.realEstat.details.bathroom}",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: isLandScape
                              ? screenUtil.setSp(20)
                              : screenUtil.setSp(40),
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                BuildContainerRowText(
                  isLandScape: isLandScape,
                  screenUtil: screenUtil,
                  color: Colors.grey.shade300,
                  text: "الدور",
                  widget: Text(
                    widget.realEstat.details.steps == 0
                        ? " الطابق الارضي"
                        : "${widget.realEstat.details.steps}",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: isLandScape
                          ? screenUtil.setSp(20)
                          : screenUtil.setSp(40),
                      letterSpacing: 1,
                    ),
                  ),
                ),
                BuildContainerRowText(
                  isLandScape: isLandScape,
                  screenUtil: screenUtil,
                  color: Colors.grey.shade100,
                  text: "عمر العقار",
                  widget: Text(
                    "${widget.realEstat.details.old} سنوات",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: isLandScape
                          ? screenUtil.setSp(20)
                          : screenUtil.setSp(40),
                      letterSpacing: 1,
                    ),
                  ),
                ),
                BuildContainerRowText(
                  isLandScape: isLandScape,
                  screenUtil: screenUtil,
                  color: Colors.grey.shade300,
                  text: "مفروشة",
                  widget: widget.realEstat.details.mafrosha
                      ? Image.asset("assets/icons/correct.png")
                      : Icon(Icons.close, color: Colors.red),
                  //  Icons.cancel_sharp,
                ),
                BuildContainerRowText(
                  isLandScape: isLandScape,
                  screenUtil: screenUtil,
                  color: Colors.grey.shade100,
                  text: "مدخل سيارة",
                  widget: widget.realEstat.details.parking
                      ? Image.asset("assets/icons/correct.png")
                      : Icon(Icons.close, color: Colors.red),
                ),
                BuildContainerRowText(
                  isLandScape: isLandScape,
                  screenUtil: screenUtil,
                  color: Colors.grey.shade300,
                  text: "مصعد",
                  widget: widget.realEstat.details.elevator
                      ? Image.asset("assets/icons/correct.png")
                      : Icon(Icons.close, color: Colors.red),
                ),
                BuildContainerRowText(
                  isLandScape: isLandScape,
                  screenUtil: screenUtil,
                  color: Colors.grey.shade100,
                  text: "مكيفات",
                  widget: widget.realEstat.details.airConditioner
                      ? Image.asset("assets/icons/correct.png")
                      : Icon(Icons.close, color: Colors.red),
                ),
                BuildContainerRowText(
                  isLandScape: isLandScape,
                  screenUtil: screenUtil,
                  color: Colors.grey.shade300,
                  text: "المطبخ",
                  widget: widget.realEstat.details.ketchen
                      ? Image.asset("assets/icons/correct.png")
                      : Icon(Icons.close, color: Colors.red),
                ),
                BuildContainerRowText(
                  isLandScape: isLandScape,
                  screenUtil: screenUtil,
                  color: Colors.grey.shade100,
                  text: "عدد المشاهدات",
                  widget: Text(
                    "${widget.realEstat.details.views}",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: isLandScape
                          ? screenUtil.setSp(20)
                          : screenUtil.setSp(40),
                      letterSpacing: 1,
                    ),
                  ),
                ),
                BuildContainerRowText(
                  isLandScape: isLandScape,
                  screenUtil: screenUtil,
                  color: Colors.grey.shade300,
                  text: "رقم العلان",
                  widget: Text(
                    "${widget.realEstat.id}",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: isLandScape
                          ? screenUtil.setSp(20)
                          : screenUtil.setSp(40),
                      letterSpacing: 1,
                    ),
                  ),
                ),
                DescriptionText(
                  isLandScape: isLandScape,
                  screenUtil: screenUtil,
                  description: widget.realEstat.description,
                  roomCount: widget.realEstat.details.rooms.toString(),
                ),
                AdvertisInfo(
                  isLandScape: isLandScape,
                  screenUtil: screenUtil,
                ),
                LocationOnMap(
                  isLandScape: isLandScape,
                  screenUtil: screenUtil,
                ),
                _reportContainer(),
                SemilerAds(
                  screenUtil: screenUtil,
                  isLandScape: isLandScape,
                  realEstateId: widget.realEstat.id,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _reportContainer() {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(10.0),
      height: 50,
      // width: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
        border: Border.all(
          color: Colors.red,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "ابلاغ",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
          Expanded(
            child: Icon(
              Icons.ac_unit,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

class SemilerAds extends StatelessWidget {
  final ScreenUtil screenUtil;
  final bool isLandScape;
  final String realEstateId;

  const SemilerAds({
    Key key,
    this.screenUtil,
    this.isLandScape,
    this.realEstateId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "إعلانات مشابهة",
            style: TextStyle(
              color: Colors.grey.shade900,
              fontWeight: FontWeight.bold,
              fontSize:
                  isLandScape ? screenUtil.setSp(20) : screenUtil.setSp(45),
              letterSpacing: 1,
            ),
          ),
          Container(
            height: 350,
            child: BlocBuilder<SemilarRealEstateBloc, SemilarRealEstateState>(
              builder: (context, state) {
                if (state is SemilarRealEstateInProgress) {
                  return Center(
                    child: sleekCircularSlider(context, 40,
                        AppColors.primaryColor, AppColors.scondryColor),
                  );
                } else if (state is SemilarRealEstateError) {
                  return Center(
                    child: Text("يوجد خطأ الرجاء المحاولة لاحقا"),
                  );
                } else if (state is SemilarRealEstateLoadingDone) {
                  if (state.realEstates.isEmpty) {
                    return Center(
                      child: Text("عفوا لا يوجد اعلانات مشابهه لهذ النوع"),
                    );
                  }
                  return ListView.builder(
                    itemCount: state.realEstates.length,
                    itemBuilder: (context, index) => RealEstateItem(
                      realEstat: state.realEstates[index],
                      screenUtil: screenUtil,
                      isLandScape: isLandScape,
                    ),
                  );
                }
                return Text("Done");
              },
            ),
          )
        ],
      ),
    );
  }
}

class BuildContainerRowText extends StatelessWidget {
  const BuildContainerRowText({
    Key key,
    @required this.isLandScape,
    @required this.screenUtil,
    @required this.widget,
    @required this.color,
    @required this.text,
  }) : super(key: key);

  final bool isLandScape;
  final ScreenUtil screenUtil;
  final String text;
  final Color color;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 40,
              color: color,
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: isLandScape
                        ? screenUtil.setSp(20)
                        : screenUtil.setSp(40),
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 5),
          Expanded(
            child: Container(
              height: 40,
              color: color,
              child: Center(
                child: widget,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
