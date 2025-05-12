import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../utils/color_constants.dart';
import '../../../helpers.dart';
import '../../../navigation/navigation_helper.dart';
import '../bloc/all_reservations_bloc.dart';
import '../model/all_reservations_model.dart';
import '../repository/all_reservations_repository.dart';

class AllReservationsScreen extends StatefulWidget {
  const AllReservationsScreen({super.key});

  @override
  State<AllReservationsScreen> createState() => _AllReservationsScreenState();
}

class _AllReservationsScreenState extends State<AllReservationsScreen> {
  @override
  Widget build(BuildContext context) {
    NavigationHelper navigationHelper = NavigationHelper(context);
    return WillPopScope(
      onWillPop: () async {
        // navigationHelper.navigateToPage(HomeLandingPage(currentIndex: 0));
        return false;
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create:
                (context) =>
                    AllReservationsBloc(AllReservationsRepository())
                      ..add(FetchAllReservations(showPayments: true)),
          ),
        ],
        child: Scaffold(
          backgroundColor: HexColor("#100c04"),
          appBar: AppBar(
            backgroundColor: HexColor("#100c04"),
            iconTheme: IconThemeData(color: kPrimaryColor),
            elevation: 0,
            title: Text(
              "Home Stay Bookings",
              style: GoogleFonts.delius(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
          ),
          body: BlocBuilder<AllReservationsBloc, AllReservationsState>(
            builder: (context, state) {
              if (state is AllReservationsLoading) {
                return const Center(
                  child: SpinKitPulse(color: Colors.amber, size: 30),
                );
              } else if (state is AllReservationsLoaded) {
                return _buildPackageList(state.reservations);
              } else if (state is AllReservationsError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "You don't have any reservations at the moment",
                        style: GoogleFonts.delius(color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          context.read<AllReservationsBloc>().add(
                            FetchAllReservations(showPayments: true),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                        ),
                        child: Text(
                          "Retry",
                          style: GoogleFonts.delius(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPackageList(List<AllReservationsModel> reservationData) {
    NavigationHelper navigationHelper = NavigationHelper(context);
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: reservationData.length,
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, index) {
        var reservation = reservationData[index];
        return InkWell(
          onTap: () {
            // navigationHelper.navigateToPage(ReservationDetailPage(reservationModel: reservation));
          },
          child: Card(
            margin: const EdgeInsets.only(bottom: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            color: HexColor("#2A2A2A"),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Booking Reference
                  Text(
                    "${reservation.property.name}",
                    style: GoogleFonts.delius(
                      color: Colors.amber,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Booking Date
                  Text(
                    "Booking Date: ${formatDate(DateTime.parse(reservation.reservation.bookingDate))}",
                    style: GoogleFonts.delius(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "Status: ${reservation.reservation.statusText}",
                    style: GoogleFonts.delius(
                      color: reservation.reservation.statusText=="pending"?kPrimaryColor:Colors.teal,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
