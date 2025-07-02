import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hording_management/AdInfoScreen.dart';
import 'package:hording_management/Repository.dart';
import 'package:hording_management/UploadAdScreen.dart';
import 'package:hording_management/bloc/DashboardBloc.dart';
import 'package:hording_management/constants.dart';
import 'package:hording_management/model/GetAdsData.dart';

class AdDashboardApp extends StatelessWidget {
  const AdDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late DashboardBloc dashboardBloc;
  late Repository repository;
  int count = 0;
  String name = "";
  String email = "";
  String userId = "";
  List<GetAdsData> activeAds = [];
  List<GetAdsData> pausedAds = [];
  List<GetAdsData> inReviewAds = [];
  List<GetAdsData> expiredAds = [];

  @override
  void initState() {
    repository = Repository();
    dashboardBloc = DashboardBloc(repository);
    dashboardBloc.add(DashboardInitEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DashboardBloc>(
      create: (BuildContext context) => dashboardBloc,
      child: BlocConsumer<DashboardBloc, DashboardStates>(
        builder: (BuildContext context, state) {
          log("State $state");
          count++;
          return Stack(
            children: [
              Scaffold(
                floatingActionButton: IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (builder) => const UploadAdScreen()));
                  },
                  icon: const Icon(
                    Icons.add_circle,
                    size: 60,
                    color: Colors.blue,
                  ),
                ),
                floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
                appBar: AppBar(
                  title: Row(
                    children: [
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(name,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                              )),
                          Text(
                            email,
                            style: GoogleFonts.poppins(fontWeight: FontWeight.normal, fontSize: 13),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text("$count"),
                      const Icon(Icons.notifications_none),
                      const SizedBox(width: 12),
                      const Icon(Icons.settings),
                    ],
                  ),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Active",
                                      style: GoogleFonts.poppins(),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Visibility(
                                      visible: state is DashboardActiveAdsLoadingState,
                                      // visible: true,
                                      child: const SizedBox(
                                        width: 15,
                                        height: 15,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {
                                      dashboardBloc.add(DashboardActiveAdsEvent(userId));
                                    },
                                    icon: const Icon(Icons.refresh))
                              ],
                            ),
                            activeAds.isNotEmpty ? buildAdsList(activeAds) : Text("No Active ads found", style: GoogleFonts.poppins(fontSize: 12)),
                          ],
                        ),
                        const Divider(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Paused",
                                      style: GoogleFonts.poppins(),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Visibility(
                                      visible: state is DashboardGetPausedLoadingState,
                                      // visible: true,
                                      child: const SizedBox(
                                        width: 15,
                                        height: 15,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {
                                      dashboardBloc.add(DashboardPausedAdsEvent(userId));
                                    },
                                    icon: const Icon(Icons.refresh))
                              ],
                            ),
                            pausedAds.isNotEmpty ? buildAdsList(pausedAds) : Text("No ads were paused", style: GoogleFonts.poppins(fontSize: 12)),
                          ],
                        ),
                        const Divider(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "In Review",
                                      style: GoogleFonts.poppins(),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Visibility(
                                      visible: state is DashboardGetInReviewLoadingState,
                                      // visible: true,
                                      child: const SizedBox(
                                        width: 15,
                                        height: 15,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {
                                      dashboardBloc.add(DashboardInReviewAdsEvent(userId));
                                    },
                                    icon: const Icon(Icons.refresh))
                              ],
                            ),
                            inReviewAds.isNotEmpty ? buildAdsList(inReviewAds) : Text("No ads were in review", style: GoogleFonts.poppins(fontSize: 12)),
                          ],
                        ),
                        const Divider(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Expired",
                                      style: GoogleFonts.poppins(),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Visibility(
                                      visible: state is DashboardExpiredAdsLoadingState,
                                      // visible: true,
                                      child: const SizedBox(
                                        width: 15,
                                        height: 15,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {
                                      dashboardBloc.add(DashboardExpiredAdsEvent(userId));
                                    },
                                    icon: const Icon(Icons.refresh))
                              ],
                            ),
                            expiredAds.isNotEmpty ? buildAdsList(expiredAds) : Text("No ads were in review", style: GoogleFonts.poppins(fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: state is DashboardInitLoadingState,
                child: const Center(child: CircularProgressIndicator()),
              )
            ],
          );
        },
        listener: (BuildContext context, DashboardStates? state) {
          if (state is DashboardInitErrorState) {
            showSnackBar(context, state.message.message.toString());
          }
          if (state is DashboardInitSuccessState) {
            name = state.response?.name ?? "";
            email = state.response?.email ?? "";
            userId = state.response?.userId.toString() ?? "";
            dashboardBloc.add(DashboardActiveAdsEvent(state.response!.userId.toString()));
            dashboardBloc.add(DashboardPausedAdsEvent(userId));
            dashboardBloc.add(DashboardInReviewAdsEvent(userId));
            dashboardBloc.add(DashboardExpiredAdsEvent(userId));
          }
          if (state is DashboardActiveAdsSuccessState) {
            activeAds = state.activeAds;
          }
          if (state is DashboardPausedAdsSuccessState) {
            pausedAds = state.pausedAds;
          }
          if (state is DashboardInReviewAdsSuccessState) {
            inReviewAds = state.inReviewAds;
          }
          if (state is DashboardExpiredAdsSuccessState) {
            expiredAds = state.expiredAds;
          }
        },
      ),
    );
  }

  SizedBox buildAdsList(List<GetAdsData> adsDataList) {
    return SizedBox(
      height: 110,
      child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            GetAdsData getAdData = adsDataList[index];
            print('GetAdsData   ${getAdData.title}');
            return GestureDetector(
              onTap: (){
                openAdInfo(getAdData);
              },
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Card(
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              getAdData.title.toString(),
                              style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(
                              Icons.circle_rounded,
                              color: Colors.green,
                              size: 12,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          getAdData.description.toString(),
                          style: GoogleFonts.poppins(fontSize: 12),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          getAdData.adId.toString(),
                          style: GoogleFonts.poppins(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount: activeAds.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal),
    );
  }

  void openAdInfo(GetAdsData adData) {
    Navigator.push(context, MaterialPageRoute(builder: (builder) => AdInfoScreen(adsData: adData)));
  }
}
