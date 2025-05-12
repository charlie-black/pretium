// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:html/parser.dart' as html_parser;
// import 'package:intl/intl.dart';
// import 'package:share_plus/share_plus.dart';
// import '../../../../../utils/navigation/navigation_helper.dart';
// import '../../../../../utils/styling/text_styling.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import '../../../../components/custom_button.dart';
// import '../../../../utils/styling/color_constants.dart';
// import '../../../stay_module/stays/stay_details/screen/map_section.dart';
// import '../../check_property_availability/repository/check_property_availability_repository.dart';
// import '../../reserve_property/bloc/reserve_property_bloc.dart';
// import '../../reserve_property/repository/reserve_property_repository.dart';
// import '../bloc/property_details_bloc.dart';
// import 'package:flutter_animate/flutter_animate.dart';
//
// class PropertyDetailsScreen extends StatefulWidget {
//   final String propertyCode;
//   final String propertyName;
//
//   const PropertyDetailsScreen({
//     super.key,
//     required this.propertyCode,
//     required this.propertyName,
//   });
//
//   @override
//   State<PropertyDetailsScreen> createState() => _PropertyDetailsScreenState();
// }
//
// class _PropertyDetailsScreenState extends State<PropertyDetailsScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   bool _isSummary = true;
//   int _numberOfAdults = 1;
//   int _numberOfChildren = 0;
//   final TextEditingController _checkInController = TextEditingController();
//   final TextEditingController _checkOutController = TextEditingController();
//
//   void _showAvailability(BuildContext context) {
//     NavigationHelper navigationHelper = NavigationHelper(context);
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.white,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) {
//         int numberOfAdults = _numberOfAdults;
//         int numberOfChildren = _numberOfChildren;
//         int numberOfInfants = 0;
//
//         return MultiBlocProvider(
//           providers: [
//             BlocProvider(
//               create:
//                   (context) => CheckPropertyAvailabilityBloc(
//                     api: CheckPropertyAvailabilityRepository(),
//                   ),
//             ),
//             BlocProvider(
//               create:
//                   (context) =>
//                       ReservePropertyBloc(api: ReservePropertyRepository()),
//             ),
//           ],
//           child: BlocListener<ReservePropertyBloc, ReservePropertyState>(
//             listener: (context, reserveState) {
//
//               if (reserveState is ReservePropertySuccess) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     content: Text("Reservation successful!"),
//                     backgroundColor: Colors.green,
//                   ),
//                 );
//                 navigationHelper.navigateToPage(AllReservationsScreen());
//               } else if (reserveState is ReservePropertyFailure) {
//                 Navigator.pop(context);
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text(reserveState.error),
//                     backgroundColor: Colors.red,
//                   ),
//                 );
//               }
//             },
//             child: BlocConsumer<
//               CheckPropertyAvailabilityBloc,
//               CheckPropertyAvailabilityState
//             >(
//               listener: (context, state) {
//
//                 if (state is CheckPropertyAvailabilitySuccess) {
//                   var reservationAvailabilityMessage =
//                       state.apiResponseData["message"];
//
//                   if (reservationAvailabilityMessage ==
//                       "property available for booking") {
//                     context.read<ReservePropertyBloc>().add(
//                       ReservePropertyButtonPressed(
//                         propertyCode: widget.propertyCode,
//                         checkInDate: _checkInController.text,
//                         checkOutDate: _checkOutController.text,
//                         numberOfAdults: numberOfAdults,
//                         numberOfChildren: numberOfChildren,
//                         numberOfInfants: numberOfInfants,
//                       ),
//                     );
//                   }else{
//                     Navigator.pop(context);
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text(reservationAvailabilityMessage),
//                         backgroundColor: Colors.amber,
//                       ),
//                     );
//                   }
//                 } else if (state is CheckPropertyAvailabilityFailure) {
//                   Navigator.pop(context);
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text(state.error),
//                       backgroundColor: Colors.red,
//                     ),
//                   );
//                 }
//               },
//               builder: (context, state) {
//                 return Padding(
//                   padding: MediaQuery.of(context).viewInsets,
//                   child: StatefulBuilder(
//                     builder: (BuildContext context, StateSetter setModalState) {
//                       return SingleChildScrollView(
//                         child: Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               const Center(
//                                 child: Text(
//                                   "Check Availability & Reserve",
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 16),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   const Text(
//                                     "Number of Adults",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                   Row(
//                                     children: [
//                                       IconButton(
//                                         onPressed: () {
//                                           if (numberOfAdults > 0) {
//                                             setModalState(() {
//                                               numberOfAdults--;
//                                             });
//                                           }
//                                         },
//                                         icon: Icon(
//                                           Icons.remove_circle_outline,
//                                           color: kPrimaryColor,
//                                         ),
//                                       ),
//                                       Text(
//                                         "$numberOfAdults",
//                                         style: const TextStyle(
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                       IconButton(
//                                         onPressed: () {
//                                           setModalState(() {
//                                             numberOfAdults++;
//                                           });
//                                         },
//                                         icon: Icon(
//                                           Icons.add_circle_outline_outlined,
//                                           color: kPrimaryColor,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 16),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   const Text(
//                                     "Number of Children",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                   Row(
//                                     children: [
//                                       IconButton(
//                                         onPressed: () {
//                                           if (numberOfChildren > 0) {
//                                             setModalState(() {
//                                               numberOfChildren--;
//                                             });
//                                           }
//                                         },
//                                         icon: Icon(
//                                           Icons.remove_circle_outline,
//                                           color: kPrimaryColor,
//                                         ),
//                                       ),
//                                       Text(
//                                         "$numberOfChildren",
//                                         style: const TextStyle(
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                       IconButton(
//                                         onPressed: () {
//                                           setModalState(() {
//                                             numberOfChildren++;
//                                           });
//                                         },
//                                         icon: Icon(
//                                           Icons.add_circle_outline_outlined,
//                                           color: kPrimaryColor,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 16),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   const Text(
//                                     "Number of Infants",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                   Row(
//                                     children: [
//                                       IconButton(
//                                         onPressed: () {
//                                           if (numberOfInfants > 0) {
//                                             setModalState(() {
//                                               numberOfInfants--;
//                                             });
//                                           }
//                                         },
//                                         icon: Icon(
//                                           Icons.remove_circle_outline,
//                                           color: kPrimaryColor,
//                                         ),
//                                       ),
//                                       Text(
//                                         "$numberOfInfants",
//                                         style: const TextStyle(
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                       IconButton(
//                                         onPressed: () {
//                                           setModalState(() {
//                                             numberOfInfants++;
//                                           });
//                                         },
//                                         icon: Icon(
//                                           Icons.add_circle_outline_outlined,
//                                           color: kPrimaryColor,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               // Optional: Add input for numberOfInfants if needed
//                               const SizedBox(height: 10),
//                               TextField(
//                                 style: const TextStyle(color: Colors.black),
//                                 controller: _checkInController,
//                                 decoration: InputDecoration(
//                                   labelText: "Check in Date",
//                                   labelStyle: const TextStyle(
//                                     color: Colors.black,
//                                   ),
//                                   border: const OutlineInputBorder(),
//                                   suffixIcon: IconButton(
//                                     icon: const Icon(
//                                       Icons.calendar_today,
//                                       color: Colors.black,
//                                     ),
//                                     onPressed: () async {
//                                       DateTime? pickedDate =
//                                           await showDatePicker(
//                                             context: context,
//                                             initialDate: DateTime.now(),
//                                             firstDate: DateTime.now(),
//                                             lastDate: DateTime(2100),
//                                           );
//                                       if (pickedDate != null) {
//                                         setModalState(() {
//                                           _checkInController.text =
//                                               "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
//                                         });
//                                       }
//                                     },
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 10),
//                               TextField(
//                                 style: const TextStyle(color: Colors.black),
//                                 controller: _checkOutController,
//                                 decoration: InputDecoration(
//                                   labelText: "Check Out Date",
//                                   labelStyle: const TextStyle(
//                                     color: Colors.black,
//                                   ),
//                                   border: const OutlineInputBorder(),
//                                   suffixIcon: IconButton(
//                                     icon: const Icon(
//                                       Icons.calendar_today,
//                                       color: Colors.black,
//                                     ),
//                                     onPressed: () async {
//                                       DateTime? pickedDate =
//                                           await showDatePicker(
//                                             context: context,
//                                             initialDate: DateTime.now(),
//                                             firstDate: DateTime.now(),
//                                             lastDate: DateTime(2100),
//                                           );
//                                       if (pickedDate != null) {
//                                         setModalState(() {
//                                           _checkOutController.text =
//                                               "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
//                                         });
//                                       }
//                                     },
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 16),
//                               state is CheckPropertyAvailabilityLoading
//                                   ? const Center(
//                                     child: CustomLoadingIndicator(),
//                                   )
//                                   : CustomButton(
//                                     width: double.infinity,
//                                     borderRadius: 10.0,
//                                     colors: [kPrimaryColor, kBackgroundColor],
//                                     text: "Check Availability & Reserve",
//                                     onPressed: () {
//                                       final checkInDate =
//                                           _checkInController.text;
//                                       final checkOutDate =
//                                           _checkOutController.text;
//
//                                       if (checkInDate.isEmpty) {
//                                         Navigator.pop(context);
//
//                                         ScaffoldMessenger.of(
//                                           context,
//                                         ).showSnackBar(
//                                           const SnackBar(
//                                             content: Text(
//                                               "Please select the check in date",
//                                             ),
//                                             backgroundColor: Colors.red,
//                                           ),
//                                         );
//                                         return;
//                                       } else if (checkOutDate.isEmpty) {
//                                         Navigator.pop(context);
//
//                                         ScaffoldMessenger.of(
//                                           context,
//                                         ).showSnackBar(
//                                           const SnackBar(
//                                             content: Text(
//                                               "Please select the check out date",
//                                             ),
//                                             backgroundColor: Colors.red,
//                                           ),
//                                         );
//                                         return;
//                                       }
//
//                                       context
//                                           .read<CheckPropertyAvailabilityBloc>()
//                                           .add(
//                                             CheckPropertyAvailabilityButtonPressed(
//                                               propertyCode: widget.propertyCode,
//                                               checkInDate: checkInDate,
//                                               checkOutDate: checkOutDate,
//                                               numberOfChildren:
//                                                   numberOfChildren,
//                                               numberOfAdults: numberOfAdults,
//                                             ),
//                                           );
//                                     },
//                                   ),
//                               const SizedBox(height: 16),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 6, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final navigationHelper = NavigationHelper(context);
//
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create:
//               (_) =>
//                   PropertyDetailsBloc()..add(
//                     FetchPropertyDetails(propertyCode: widget.propertyCode),
//                   ),
//         ),
//         BlocProvider(
//           create:
//               (_) => CheckPropertyAvailabilityBloc(
//                 api: CheckPropertyAvailabilityRepository(),
//               ),
//         ),
//       ],
//       child: Scaffold(
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//         floatingActionButton: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: InkWell(
//             onTap: () {
//               _showAvailability(context);
//             },
//             child: Container(
//               height: 50,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: kPrimaryColor,
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(color: Colors.amber, width: 0),
//               ),
//               child: Center(
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     "Reserve",
//                     style: kTitleStyle.copyWith(color: Colors.white),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//
//         backgroundColor: HexColor("#191919"),
//         appBar: AppBar(
//           iconTheme: const IconThemeData(color: Colors.white),
//           backgroundColor: HexColor("#191919"),
//           elevation: 0,
//           centerTitle: true,
//           title: Text(
//             widget.propertyName,
//             style: kTitleStyle.copyWith(color: Colors.white),
//           ),
//           bottom: TabBar(
//             controller: _tabController,
//             isScrollable: true,
//             labelColor: Colors.white,
//             unselectedLabelColor: Colors.grey,
//             indicatorColor: Colors.white,
//             labelStyle: GoogleFonts.delius(
//               textStyle: const TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             tabs: const [
//               Tab(text: "Overview & Images"),
//               Tab(text: "Description"),
//               Tab(text: "Amenities"),
//               Tab(text: "Location"),
//               Tab(text: "Rules"),
//               Tab(text: "Safety"),
//             ],
//           ),
//         ),
//         body: BlocBuilder<PropertyDetailsBloc, PropertyDetailsState>(
//           builder: (context, state) {
//             if (state is PropertyDetailsLoadingState) {
//               return const Center(child: CustomLoadingIndicator());
//             } else if (state is PropertyDetailsErrorState) {
//               return Center(
//                 child: Text(
//                   state.message,
//                   style: const TextStyle(color: Colors.red),
//                 ),
//               );
//             } else if (state is PropertyDetailsSuccessState) {
//               final property = state.propertyDetail; // PropertyDetailsModel
//               return TabBarView(
//                 controller: _tabController,
//                 children: [
//                   // Combined Overview & Images Tab
//               // Overview & Images Tab
//               SingleChildScrollView(
//               padding: const EdgeInsets.all(16.0),
//             child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//             Text(
//             "Images",
//             style: GoogleFonts.delius(
//             textStyle: const TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//             ),
//             ),
//             ),
//             const SizedBox(height: 12),
//             if (property!.images.isNotEmpty)
//             _buildInteractiveImageCarousel(property.images)
//             else
//             Card(
//             color: HexColor("#2A2A2A"), // Already correct
//             shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//             ),
//             child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//             "No images available",
//             style: GoogleFonts.delius(
//             textStyle: const TextStyle(
//             fontSize: 16,
//             color: Colors.white70,
//             ),
//             ),
//             ),
//             ),
//             ).animate().fadeIn(
//             duration: const Duration(milliseconds: 400),
//             curve: Curves.easeIn,
//             ),
//             const SizedBox(height: 24),
//             Card(
//             color: HexColor("#2A2A2A"), // Already correct
//             shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//             ),
//             child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//             Text(
//             property.name,
//             style: GoogleFonts.delius(
//             textStyle: const TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//             ),
//             ),
//             ),
//             const SizedBox(height: 12),
//             Wrap(
//             spacing: 12,
//             runSpacing: 12,
//             children: [
//             _buildInteractiveDetailChip(
//             label: "${property.numberOfBedrooms} Bedrooms",
//             icon: Icons.bed,
//             onTap: () => _showDetailDialog(
//             context,
//             "Bedrooms",
//             "${property.numberOfBedrooms} bedrooms available",
//             ),
//             ),
//             _buildInteractiveDetailChip(
//             label: "${property.numberOfBathrooms} Bathrooms",
//             icon: Icons.bathroom,
//             onTap: () => _showDetailDialog(
//             context,
//             "Bathrooms",
//             "${property.numberOfBathrooms} bathrooms available",
//             ),
//             ),
//             _buildInteractiveDetailChip(
//             label: "${property.numberOfBeds} Beds",
//             icon: Icons.king_bed,
//             onTap: () => _showDetailDialog(
//             context,
//             "Beds",
//             "${property.numberOfBeds} beds available",
//             ),
//             ),
//             _buildInteractiveDetailChip(
//             label: "${property.numberOfGuests} Guests max",
//             icon: Icons.group,
//             onTap: () => _showDetailDialog(
//             context,
//             "Guests",
//             "Up to ${property.numberOfGuests} guests allowed",
//             ),
//             ),
//             ],
//             ),
//             const SizedBox(height: 16),
//             _buildInteractivePriceTile(
//             price: "${property.currency} ${property.pricePerNight} / night",
//             minNights: property.minNights,
//             maxNights: property.maxNights,
//             adjustments: property.pricePerNightAdjustments,
//             ),
//             const SizedBox(height: 12),
//             _buildInteractiveDetailTile(
//             title: "Property Type",
//             value: property.propertyType.type ?? property.propertyType.description,
//             icon: Icons.home_work,
//             ),
//             ],
//             ),
//             ),
//             ).animate().slideY(
//             begin: 0.2,
//             end: 0.0,
//             duration: const Duration(milliseconds: 600),
//             curve: Curves.easeInOut,
//             ),
//             const SizedBox(height: 24),
//             Card(
//             color: HexColor("#2A2A2A"), // Already correct
//             shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//             ),
//             child: ExpansionTile(
//             title: Text(
//             "Guest space",
//             style: GoogleFonts.delius(
//             textStyle: const TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//             ),
//             ),
//             ),
//             iconColor: Colors.white,
//             collapsedIconColor: Colors.white70,
//             children: [
//             Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//             property.guestPlace.description,
//             style: GoogleFonts.delius(
//             textStyle: const TextStyle(
//             fontSize: 16,
//             color: Colors.white70,
//             ),
//             ),
//             ),
//             ),
//             ],
//             ),
//             ).animate().fadeIn(
//             duration: const Duration(milliseconds: 400),
//             curve: Curves.easeIn,
//             ),
//             SizedBox(height: 100),
//             ],
//             ),
//             ),
//                   // Description Tab (Unchanged)
//                   SingleChildScrollView(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Header
//                         Text(
//                           "Property Description",
//                           style: GoogleFonts.delius(
//                             textStyle: const TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ).animate().fadeIn(
//                           duration: const Duration(milliseconds: 400),
//                           curve: Curves.easeIn,
//                         ),
//                         const SizedBox(height: 16),
//                         // Description Content
//                         _buildInteractiveDescription(
//                           context,
//                           property.description,
//                         ),
//                         const SizedBox(height: 24),
//                         // Action Buttons
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             ElevatedButton.icon(
//                               onPressed:
//                                   () => _toggleDescriptionLength(
//                                     context,
//                                     property.description,
//                                   ),
//                               icon: const Icon(
//                                 Icons.expand_more,
//                                 color: Colors.white,
//                               ),
//                               label: Text(
//                                 _isSummary
//                                     ? "Show Full Description"
//                                     : "Show Summary",
//                                 style: GoogleFonts.delius(
//                                   textStyle: const TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: HexColor("#2A2A2A"),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 16,
//                                   vertical: 12,
//                                 ),
//                               ),
//                             ).animate().scale(
//                               delay: const Duration(milliseconds: 200),
//                               duration: const Duration(milliseconds: 300),
//                               curve: Curves.easeInOut,
//                             ),
//                             IconButton(
//                               icon: const Icon(
//                                 Icons.share,
//                                 color: Colors.white,
//                               ),
//                               onPressed:
//                                   () => _shareDescription(
//                                     context,
//                                     removeHtmlTags(property.description), property.name
//                                   ),
//                               tooltip: "Share Description",
//                             ).animate().scale(
//                               delay: const Duration(milliseconds: 300),
//                               duration: const Duration(milliseconds: 300),
//                               curve: Curves.easeInOut,
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 100),
//                       ],
//                     ),
//                   ),
//
//                   // Amenities Tab (Unchanged)
//                   SingleChildScrollView(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Header
//                         Text(
//                           "Amenities & Favorites",
//                           style: GoogleFonts.delius(
//                             textStyle: const TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ).animate().fadeIn(
//                           duration: const Duration(milliseconds: 400),
//                           curve: Curves.easeIn,
//                         ),
//                         const SizedBox(height: 16),
//                         // Amenities Section
//                         if (property.amenities.isNotEmpty)
//                           _buildAmenitiesSection(
//                             title: "Amenities",
//                             items: property.amenities,
//                             isGuestFavorite: false,
//                           ),
//                         const SizedBox(height: 24),
//                         // Guest Favorites Section
//                         if (property.guestFavourites.isNotEmpty)
//                           _buildAmenitiesSection(
//                             title: "Guest Favorites",
//                             items: property.guestFavourites,
//                             isGuestFavorite: true,
//                           ),
//                         if (property.amenities.isEmpty &&
//                             property.guestFavourites.isEmpty)
//                           Card(
//                             color: HexColor("#2A2A2A"),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(16.0),
//                               child: Text(
//                                 "No amenities available",
//                                 style: GoogleFonts.delius(
//                                   textStyle: const TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.white70,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ).animate().fadeIn(
//                             duration: const Duration(milliseconds: 400),
//                             curve: Curves.easeIn,
//                           ),
//                         SizedBox(height: 100),
//                       ],
//                     ),
//                   ),
//                   // Location Tab (Unchanged)
// // Location Tab
//                   SingleChildScrollView(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Location Details Card (already uses HexColor("#2A2A2A"))
//                         Card(
//                           color: HexColor("#2A2A2A"),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Location Details",
//                                   style: GoogleFonts.delius(
//                                     textStyle: const TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 16),
//                                 _buildInteractiveLocationItem(
//                                   title: "Location",
//                                   value: property.location.location,
//                                   icon: Icons.place,
//                                   onTap: () => _copyToClipboard(context, property.location.location),
//                                 ),
//                                 _buildInteractiveLocationItem(
//                                   title: "Street",
//                                   value: property.location.streetAddress,
//                                   icon: Icons.signpost,
//                                   onTap: () => _copyToClipboard(context, property.location.streetAddress),
//                                 ),
//                                 _buildInteractiveLocationItem(
//                                   title: "Building",
//                                   value: property.location.building,
//                                   icon: Icons.apartment,
//                                   onTap: () => _copyToClipboard(context, property.location.building),
//                                 ),
//                                 ExpansionTile(
//                                   title: Text(
//                                     "More Details",
//                                     style: GoogleFonts.delius(
//                                       textStyle: const TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ),
//                                   iconColor: Colors.white,
//                                   collapsedIconColor: Colors.white70,
//                                   children: [
//                                     _buildInteractiveLocationItem(
//                                       title: "Unit",
//                                       value: property.location.unit,
//                                       icon: Icons.home,
//                                       onTap: () => _copyToClipboard(context, property.location.unit),
//                                     ),
//                                     _buildInteractiveLocationItem(
//                                       title: "Floor",
//                                       value: property.location.floor,
//                                       icon: Icons.stairs,
//                                       onTap: () => _copyToClipboard(context, property.location.floor),
//                                     ),
//                                     _buildInteractiveLocationItem(
//                                       title: "City",
//                                       value: property.location.city,
//                                       icon: Icons.location_city,
//                                       onTap: () => _copyToClipboard(context, property.location.city),
//                                     ),
//                                     _buildInteractiveLocationItem(
//                                       title: "Country",
//                                       value: property.location.country,
//                                       icon: Icons.flag,
//                                       onTap: () => _copyToClipboard(context, property.location.country),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ).animate().fadeIn(
//                           duration: const Duration(milliseconds: 400),
//                           curve: Curves.easeIn,
//                         ),
//                         const SizedBox(height: 16),
//                         // Map Section
//                         Text(
//                           'Where You’ll Be',
//                           style: GoogleFonts.delius(
//                             textStyle: const TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         GestureDetector(
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: HexColor("#2A2A2A"), // Replaced gradient with solid color
//                               borderRadius: BorderRadius.circular(20),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black.withOpacity(0.3),
//                                   blurRadius: 10,
//                                   offset: const Offset(0, 4),
//                                 ),
//                               ],
//                             ),
//                             height: 300,
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(20),
//                               child: Stack(
//                                 children: [
//                                   SmallGoogleMap(
//                                     latitude: property.location.lat,
//                                     longitude: property.location.lng,
//                                   ),
//
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ).animate().slideY(
//                           begin: 0.2,
//                           end: 0.0,
//                           duration: const Duration(milliseconds: 600),
//                           curve: Curves.easeInOut,
//                         ),
//                         SizedBox(height: 100),
//                       ],
//                     ),
//                   ),
//                   SingleChildScrollView(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Card(
//                           color: HexColor("#2A2A2A"),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Housing Rules",
//                                   style: GoogleFonts.delius(
//                                     textStyle: const TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 16),
//                                 // Interactive Rule Tiles
//                                 _buildInteractiveRuleTile(
//                                   title: "Check-in",
//                                   value: DateFormat(
//                                     'h:mm a',
//                                   ).format(property.housingRules.checkinTime),
//                                   icon: Icons.access_time,
//
//                                 ),
//                                 _buildInteractiveRuleTile(
//                                   title: "Check-out",
//                                   value: DateFormat(
//                                     'h:mm a',
//                                   ).format(property.housingRules.checkoutTime),
//                                   icon: Icons.access_time_outlined,
//
//                                 ),
//                                 _buildInteractiveRuleTile(
//                                   title: "Pets Allowed",
//                                   value:
//                                       property.housingRules.petsAllowed
//                                           ? "Yes"
//                                           : "No",
//                                   icon:
//                                       property.housingRules.petsAllowed
//                                           ? Icons.pets
//                                           : Icons.pets_outlined,
//
//                                 ),
//                                 _buildInteractiveRuleTile(
//                                   title: "Smoking Allowed",
//                                   value:
//                                       property.housingRules.smokingAllowed
//                                           ? "Yes"
//                                           : "No",
//                                   icon:
//                                       property.housingRules.smokingAllowed
//                                           ? Icons.smoking_rooms
//                                           : Icons.smoke_free,
//
//                                 ),
//                                 _buildInteractiveRuleTile(
//                                   title: "Events Allowed",
//                                   value:
//                                       property.housingRules.eventsAllowed
//                                           ? "Yes"
//                                           : "No",
//                                   icon:
//                                       property.housingRules.eventsAllowed
//                                           ? Icons.event
//                                           : Icons.event_busy,
//
//                                 ),
//                                 _buildInteractiveRuleTile(
//                                   title: "Photography/Videography",
//                                   value:
//                                       property
//                                               .housingRules
//                                               .photographyVideographyAllowed
//                                           ? "Yes"
//                                           : "No",
//                                   icon:
//                                       property
//                                               .housingRules
//                                               .photographyVideographyAllowed
//                                           ? Icons.camera_alt
//                                           : Icons.no_photography,
//
//                                 ),
//                                 _buildInteractiveRuleTile(
//                                   title: "Quiet Hours",
//                                   value:
//                                       property.housingRules.quietHours
//                                           ? "Yes"
//                                           : "No",
//                                   icon:
//                                       property.housingRules.quietHours
//                                           ? Icons.volume_off
//                                           : Icons.volume_up,
//
//                                 ),
//                                 if (property
//                                     .housingRules
//                                     .additionalRules
//                                     .isNotEmpty)
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       const SizedBox(height: 16),
//
//
//                                       _buildInteractiveRuleTile(
//                                         title: "Additional Rules",
//                                         value: removeHtmlTags(property.housingRules.additionalRules),
//                                         icon:Icons.list
//
//                                       ),
//
//                                     ],
//                                   ),
//                                 SizedBox(height: 20),
//                               ],
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         Card(
//                           color: HexColor("#2A2A2A"),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Cancellation Policy",
//                                   style: GoogleFonts.delius(
//                                     textStyle: const TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.w500,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 8),
//                                 Text(
//                                   "${property.cancellationRule.cancellationCharge} ${property.cancellationRule.chargeType} if cancelled ${property.cancellationRule.daysBeforeCheckin} days before check-in.",
//                                   style: GoogleFonts.delius(
//                                     textStyle: const TextStyle(
//                                       fontSize: 15,
//                                       color: Colors.white70,
//                                     ),
//                                   ),
//                                 ),
//
//                               ],
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         if (property.restrictedCheckins.isNotEmpty ||
//                             property.restrictedCheckouts.isNotEmpty)
//                           Card(
//                             color: HexColor("#2A2A2A"),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(16.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   if (property.restrictedCheckins.isNotEmpty)
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           "Restricted Check-ins Days",
//                                           style: GoogleFonts.delius(
//                                             textStyle: const TextStyle(
//                                               fontSize: 18,
//                                               fontWeight: FontWeight.w500,
//                                               color: Colors.white,
//                                             ),
//                                           ),
//                                         ),
//                                         const SizedBox(height: 8),
//                                         ...property.restrictedCheckins.map(
//                                           (check) => Text(
//                                             "${check.dayOfWeek}",
//                                             style: GoogleFonts.delius(
//                                               textStyle: const TextStyle(
//                                                 fontSize: 15,
//                                                 color: Colors.white70,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   if (property.restrictedCheckouts.isNotEmpty)
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         const SizedBox(height: 16),
//                                         Text(
//                                           "Restricted Check-outs Days",
//                                           style: GoogleFonts.delius(
//                                             textStyle: const TextStyle(
//                                               fontSize: 18,
//                                               fontWeight: FontWeight.w500,
//                                               color: Colors.white,
//                                             ),
//                                           ),
//                                         ),
//                                         const SizedBox(height: 8),
//                                         ...property.restrictedCheckouts.map(
//                                           (check) => Text(
//                                             "${check.dayOfWeek}",
//                                             style: GoogleFonts.delius(
//                                               textStyle: const TextStyle(
//                                                 fontSize: 15,
//                                                 color: Colors.white70,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         SizedBox(height: 100,)
//                       ],
//                     ),
//                   ),
//
//                   // Safety Tab (Unchanged)
//                   SingleChildScrollView(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         if (property.safetyItems.isNotEmpty)
//                           _buildExpansionSection(
//                             title: "Safety Items",
//                             items:
//                                 property.safetyItems
//                                     .map((item) => item.toString())
//                                     .toList(),
//                           )
//                         else
//                           Text(
//                             "No safety items available",
//                             style: GoogleFonts.delius(
//                               textStyle: const TextStyle(
//                                 fontSize: 15,
//                                 color: Colors.white70,
//                               ),
//                             ),
//                           ),
//                         SizedBox(height: 100),
//                       ],
//                     ),
//                   ),
//                 ],
//               );
//             } else {
//               return const Center(
//                 child: Text(
//                   "No data available",
//                   style: TextStyle(color: Colors.white),
//                 ),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildAmenitiesSection({
//     required String title,
//     required List<dynamic> items,
//     required bool isGuestFavorite,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: GoogleFonts.delius(
//             textStyle: const TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//         ).animate().fadeIn(
//           duration: const Duration(milliseconds: 400),
//           curve: Curves.easeIn,
//         ),
//         const SizedBox(height: 12),
//         GridView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 12,
//             mainAxisSpacing: 12,
//             childAspectRatio: 3 / 2,
//           ),
//           itemCount: items.length,
//           itemBuilder: (context, index) {
//             final item = items[index];
//             final name = item.name ?? item.description;
//             final hasImage = item.image != null;
//             return _buildAmenityCard(
//               name: name,
//               hasImage: hasImage,
//               imageUrl: hasImage ? item.image : null,
//               isGuestFavorite: isGuestFavorite,
//               icon: _getAmenityIcon(name),
//             );
//           },
//         ),
//       ],
//     );
//   }
//
//   Widget _buildAmenityCard({
//     required String name,
//     required bool hasImage,
//     required String? imageUrl,
//     required bool isGuestFavorite,
//     required IconData icon,
//   }) {
//     return GestureDetector(
//       onTap: () => _showAmenityDetails(context, name, imageUrl, isGuestFavorite),
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         decoration: BoxDecoration(
//           color: HexColor("#2A2A2A"), // Replaced gradient with solid color
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.2),
//               blurRadius: 8,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Material(
//           color: Colors.transparent,
//           child: InkWell(
//             borderRadius: BorderRadius.circular(12),
//             onTap: () => _showAmenityDetails(context, name, imageUrl, isGuestFavorite),
//             child: Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Row(
//                 children: [
//                   if (hasImage && imageUrl != null)
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(8),
//                       child: CachedNetworkImage(
//                         imageUrl: imageUrl,
//                         width: 40,
//                         height: 40,
//                         fit: BoxFit.cover,
//                         placeholder: (context, url) => const CircularProgressIndicator(
//                           color: Colors.white,
//                         ),
//                         errorWidget: (context, url, error) => Icon(icon, color: Colors.white, size: 24),
//                       ),
//                     )
//                   else
//                     Icon(icon, color: Colors.white, size: 24),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           name,
//                           style: GoogleFonts.delius(
//                             textStyle: const TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         if (isGuestFavorite)
//                           Text(
//                             "Guest Favorite",
//                             style: GoogleFonts.delius(
//                               textStyle: const TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.yellow, // Kept for distinction
//                               ),
//                             ),
//                           ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     ).animate().fadeIn(
//       duration: const Duration(milliseconds: 400),
//       curve: Curves.easeIn,
//     );
//   }
//
//   IconData _getAmenityIcon(String name) {
//     final lowerName = name.toLowerCase();
//     if (lowerName.contains('wifi')) return Icons.wifi;
//     if (lowerName.contains('pool')) return Icons.pool;
//     if (lowerName.contains('kitchen')) return Icons.kitchen;
//     if (lowerName.contains('parking')) return Icons.local_parking;
//     if (lowerName.contains('air conditioning')) return Icons.ac_unit;
//     if (lowerName.contains('heating')) return Icons.thermostat;
//     if (lowerName.contains('hot tub') || lowerName.contains('sauna'))
//       return Icons.spa;
//     if (lowerName.contains('balcony') || lowerName.contains('view'))
//       return Icons.balcony;
//     if (lowerName.contains('tv')) return Icons.tv;
//     return Icons.check_circle; // Default icon
//   }
//
//
//
//   void _openFullScreenImage(BuildContext context, String imageUrl) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => FullScreenImageViewer(imageUrl: imageUrl),
//       ),
//     );
//   }
//
//   Widget _buildInteractiveLocationItem({
//     required String title,
//     required String value,
//     required IconData icon,
//     required VoidCallback onTap,
//   }) {
//     if (value.isEmpty) return const SizedBox.shrink();
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12.0),
//       child: GestureDetector(
//         onTap: onTap,
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 200),
//           decoration: BoxDecoration(
//             color: HexColor("#2A2A2A"), // Replaced gradient with solid color
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.2),
//                 blurRadius: 8,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Material(
//             color: Colors.transparent,
//             child: InkWell(
//               borderRadius: BorderRadius.circular(12),
//               onTap: onTap,
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Row(
//                   children: [
//                     Icon(icon, color: Colors.white, size: 28).animate().scale(
//                       delay: const Duration(milliseconds: 100),
//                       duration: const Duration(milliseconds: 300),
//                       curve: Curves.easeInOut,
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             title,
//                             style: GoogleFonts.delius(
//                               textStyle: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             value,
//                             style: GoogleFonts.delius(
//                               textStyle: const TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.white70,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const Icon(Icons.copy, color: Colors.white70, size: 16),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     ).animate().fadeIn(
//       duration: const Duration(milliseconds: 400),
//       curve: Curves.easeIn,
//     );
//   }
//
//   void _copyToClipboard(BuildContext context, String text) {
//     if (text.isNotEmpty) {
//       Clipboard.setData(ClipboardData(text: text));
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             '$text copied to clipboard!',
//             style: GoogleFonts.delius(
//               textStyle: const TextStyle(color: Colors.white),
//             ),
//           ),
//           backgroundColor: HexColor("#34D399"),
//         ),
//       );
//     }
//   }
//
//   Widget _buildInteractiveDescription(
//     BuildContext context,
//     String description,
//   ) {
//     final containsHtmlTags = RegExp(r"<[^>]*>").hasMatch(description);
//
//     if (containsHtmlTags) {
//       // Parse HTML and render natively
//       final document = html_parser.parse(description);
//       final elements = document.body?.children ?? [];
//       final paragraphs =
//           elements
//               .where(
//                 (e) =>
//                     e.localName == 'p' ||
//                     e.localName == 'div' ||
//                     e.localName == null,
//               )
//               .map((e) => e.text.trim())
//               .where((text) => text.isNotEmpty)
//               .toList();
//
//       if (paragraphs.isEmpty) {
//         // Fallback to InAppWebView for complex HTML
//         return _buildWebViewDescription(description);
//       }
//
//       // Render parsed HTML as native widgets
//       return Column(
//         children:
//             paragraphs.asMap().entries.map((entry) {
//               final index = entry.key;
//               final text =
//                   _isSummary && index >= 2
//                       ? ''
//                       : entry.value; // Limit to 2 paragraphs for summary
//               if (text.isEmpty && _isSummary) return const SizedBox.shrink();
//               return _buildDescriptionCard(
//                 text: text,
//                 onTap: () => _highlightKeywords(context, text),
//               );
//             }).toList(),
//       );
//     } else {
//       // Handle plain text
//       final paragraphs =
//           description.split('\n').where((p) => p.trim().isNotEmpty).toList();
//       return Column(
//         children:
//             paragraphs.asMap().entries.map((entry) {
//               final index = entry.key;
//               final text =
//                   _isSummary && index >= 2
//                       ? ''
//                       : entry.value; // Limit to 2 paragraphs for summary
//               if (text.isEmpty && _isSummary) return const SizedBox.shrink();
//               return _buildDescriptionCard(
//                 text: text,
//                 onTap: () => _highlightKeywords(context, text),
//               );
//             }).toList(),
//       );
//     }
//   }
//
//   Widget _buildDescriptionCard({
//     required String text,
//     required VoidCallback onTap,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12.0),
//       child: GestureDetector(
//         onTap: onTap,
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 200),
//           decoration: BoxDecoration(
//             color: HexColor("#2A2A2A"), // Replaced gradient with solid color
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.2),
//                 blurRadius: 8,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Material(
//             color: Colors.transparent,
//             child: InkWell(
//               borderRadius: BorderRadius.circular(12),
//               onTap: onTap,
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Text(
//                   text,
//                   style: GoogleFonts.delius(
//                     textStyle: const TextStyle(
//                       fontSize: 16,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     ).animate().fadeIn(
//       duration: const Duration(milliseconds: 400),
//       curve: Curves.easeIn,
//     );
//   }
//
//   Widget _buildWebViewDescription(String description) {
//     return Card(
//       color: HexColor("#2A2A2A"),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "HTML Content",
//               style: GoogleFonts.delius(
//                 textStyle: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 12),
//             Container(
//               height: 400,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: HexColor("#34D399"), width: 2),
//               ),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: InAppWebView(
//                   initialData: InAppWebViewInitialData(
//                     data: """
//                     <!DOCTYPE html>
//                     <html>
//                       <head>
//                         <style>
//                           body {
//                             font-family: 'Delius', sans-serif;
//                             color: white !important;
//                             background-color: #2A2A2A;
//                             margin: 0;
//                             padding: 16px;
//                             font-size: 16px;
//                           }
//                           * {
//                             color: white !important;
//                             font-size: 16px;
//                             font-family: 'Delius', sans-serif;
//                           }
//                           p, div, span, h1, h2, h3, h4, h5, h6, li, a {
//                             color: white !important;
//                           }
//                           a {
//                             text-decoration: underline;
//                             color: #34D399 !important;
//                           }
//                         </style>
//                       </head>
//                       <body>
//                         $description
//                       </body>
//                     </html>
//                   """,
//                   ),
//                   initialOptions: InAppWebViewGroupOptions(
//                     crossPlatform: InAppWebViewOptions(
//                       transparentBackground: true,
//                       disableContextMenu: true,
//                       supportZoom: true,
//                       useShouldOverrideUrlLoading: true,
//                     ),
//                     android: AndroidInAppWebViewOptions(
//                       forceDark: AndroidForceDark.FORCE_DARK_ON,
//                     ),
//                   ),
//                   shouldOverrideUrlLoading: (
//                     controller,
//                     navigationAction,
//                   ) async {
//                     final url = navigationAction.request.url.toString();
//
//                     return NavigationActionPolicy.ALLOW;
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ).animate().slideY(
//       begin: 0.2,
//       end: 0.0,
//       duration: const Duration(milliseconds: 600),
//       curve: Curves.easeInOut,
//     );
//   }
//
//   void _toggleDescriptionLength(BuildContext context, String description) {
//     setState(() {
//       _isSummary = !_isSummary;
//     });
//   }
//
//   void _highlightKeywords(BuildContext context, String text) {
//     // Example: Highlight amenities-related keywords
//     final keywords = [
//       'pool',
//       'kitchen',
//       'wifi',
//       'parking',
//       'balcony',
//       'garden',
//     ];
//     for (final keyword in keywords) {
//       if (text.toLowerCase().contains(keyword)) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               "Found '$keyword' in description. Check the Amenities tab for details!",
//               style: GoogleFonts.delius(
//                 textStyle: const TextStyle(color: Colors.white),
//               ),
//             ),
//             backgroundColor: HexColor("#34D399"),
//             action: SnackBarAction(
//               label: "View Amenities",
//               textColor: Colors.white,
//               onPressed: () {
//                 // Switch to Amenities tab
//                 _tabController.animateTo(
//                   2,
//                 ); // Assuming Amenities is the 3rd tab (index 2)
//               },
//             ),
//           ),
//         );
//         return;
//       }
//     }
//   }
//
//   void _shareDescription(BuildContext context, String description , String propertyName) {
//
//     Share.share( "$propertyName: \n${description.length > 50 ? '${description.substring(0, 50)}...' : description}",);
//
//   }
//
//   Widget _buildInteractiveImageCarousel(List<dynamic> images) {
//     return Column(
//       children: [
//         CarouselSlider(
//           options: CarouselOptions(
//             height: 200,
//             autoPlay: true,
//             autoPlayInterval: const Duration(seconds: 5),
//             enlargeCenterPage: true,
//             aspectRatio: 16 / 9,
//             viewportFraction: 0.8,
//             enableInfiniteScroll: images.length > 1,
//           ),
//           items:
//               images.map((image) {
//                 return GestureDetector(
//                   onTap: () => _openFullScreenImage(context, image.image),
//                   child: Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 8.0),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.3),
//                           blurRadius: 8,
//                           offset: const Offset(0, 4),
//                         ),
//                       ],
//                     ),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(15),
//                       child: CachedNetworkImage(
//                         imageUrl: image.image,
//                         fit: BoxFit.cover,
//                         placeholder:
//                             (context, url) => const Center(
//                               child: CircularProgressIndicator(
//                                 color: Colors.white,
//                               ),
//                             ),
//                         errorWidget:
//                             (context, url, error) => const Icon(
//                               Icons.error,
//                               color: Colors.red,
//                               size: 40,
//                             ),
//                       ),
//                     ),
//                   ),
//                 ).animate().fadeIn(
//                   duration: const Duration(milliseconds: 400),
//                   curve: Curves.easeIn,
//                 );
//               }).toList(),
//         ),
//         const SizedBox(height: 12),
//       ],
//     );
//   }
//
//   Widget _buildInteractiveDetailChip({
//     required String label,
//     required IconData icon,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         decoration: BoxDecoration(
//           color: HexColor("#2A2A2A"), // Replaced gradient with solid color
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.2),
//               blurRadius: 6,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Material(
//           color: Colors.transparent,
//           child: InkWell(
//             borderRadius: BorderRadius.circular(12),
//             onTap: onTap,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(icon, color: Colors.white, size: 20),
//                   const SizedBox(width: 8),
//                   Text(
//                     label,
//                     style: GoogleFonts.delius(
//                       textStyle: const TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     ).animate().scale(
//       delay: const Duration(milliseconds: 100),
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }
//
//   Widget _buildInteractivePriceTile({
//     required String price,
//     required int minNights,
//     required int maxNights,
//     required dynamic adjustments,
//   }) {
//     return GestureDetector(
//       onTap: () => _showDetailDialog(
//         context,
//         "Pricing Details",
//         "$price\nMin $minNights nights, Max $maxNights nights${adjustments != null && adjustments is List && adjustments.isNotEmpty ? '\nAdjustments: ${adjustments.join(', ')}' : ''}",
//       ),
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         decoration: BoxDecoration(
//           color: HexColor("#2A2A2A"), // Replaced gradient with solid color
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.2),
//               blurRadius: 6,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Material(
//           color: Colors.transparent,
//           child: InkWell(
//             borderRadius: BorderRadius.circular(12),
//             onTap: () => _showDetailDialog(
//               context,
//               "Pricing Details",
//               "$price\nMin $minNights nights, Max $maxNights nights${adjustments != null && adjustments is List && adjustments.isNotEmpty ? '\nAdjustments: ${adjustments.join(', ')}' : ''}",
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       const Icon(
//                         Icons.money,
//                         color: Colors.white,
//                         size: 24,
//                       ),
//                       const SizedBox(width: 8),
//                       Text(
//                         price,
//                         style: GoogleFonts.delius(
//                           textStyle: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   if (minNights > 0 || maxNights > 0)
//                     Padding(
//                       padding: const EdgeInsets.only(top: 8.0),
//                       child: Text(
//                         "Min $minNights nights, Max $maxNights nights",
//                         style: GoogleFonts.delius(
//                           textStyle: const TextStyle(
//                             fontSize: 14,
//                             color: Colors.white70,
//                           ),
//                         ),
//                       ),
//                     ),
//                   if (adjustments != null &&
//                       adjustments is List &&
//                       adjustments.isNotEmpty)
//                     Padding(
//                       padding: const EdgeInsets.only(top: 8.0),
//                       child: Text(
//                         "Adjustments: ${adjustments.join(', ')}",
//                         style: GoogleFonts.delius(
//                           textStyle: const TextStyle(
//                             fontSize: 14,
//                             color: Colors.white70,
//                           ),
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     ).animate().fadeIn(
//       duration: const Duration(milliseconds: 400),
//       curve: Curves.easeIn,
//     );
//   }
//
//   Widget _buildInteractiveDetailTile({
//     required String title,
//     required String value,
//     required IconData icon,
//   }) {
//     return GestureDetector(
//       onTap: () => _showDetailDialog(context, title, value),
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         decoration: BoxDecoration(
//           color: HexColor("#2A2A2A"), // Replaced gradient with solid color
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.2),
//               blurRadius: 6,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Material(
//           color: Colors.transparent,
//           child: InkWell(
//             borderRadius: BorderRadius.circular(12),
//             onTap: () => _showDetailDialog(context, title, value),
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 children: [
//                   Icon(icon, color: Colors.white, size: 24),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           title,
//                           style: GoogleFonts.delius(
//                             textStyle: const TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           value,
//                           style: GoogleFonts.delius(
//                             textStyle: const TextStyle(
//                               fontSize: 14,
//                               color: Colors.white70,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     ).animate().fadeIn(
//       duration: const Duration(milliseconds: 400),
//       curve: Curves.easeIn,
//     );
//   }
//
//   void _showDetailDialog(BuildContext context, String title, String message) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         backgroundColor: HexColor("#2A2A2A"), // Already correct
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         title: Text(
//           title,
//           style: GoogleFonts.delius(
//             textStyle: const TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//         ),
//         content: Text(
//           message,
//           style: GoogleFonts.delius(
//             textStyle: const TextStyle(fontSize: 16, color: Colors.white70),
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text(
//               "Close",
//               style: GoogleFonts.delius(
//                 textStyle: const TextStyle(
//                   fontSize: 14,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showAmenityDetails(
//       BuildContext context,
//       String name,
//       String? imageUrl,
//       bool isGuestFavorite,
//       ) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         backgroundColor: HexColor("#2A2A2A"), // Already correct
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         title: Text(
//           name,
//           style: GoogleFonts.delius(
//             textStyle: const TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//         ),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (imageUrl != null)
//               GestureDetector(
//                 onTap: () => _openFullScreenImage(context, imageUrl),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(12),
//                   child: CachedNetworkImage(
//                     imageUrl: imageUrl,
//                     height: 150,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                     placeholder: (context, url) => const CircularProgressIndicator(
//                       color: Colors.white,
//                     ),
//                     errorWidget: (context, url, error) => const Icon(
//                       Icons.error,
//                       color: Colors.red,
//                       size: 40,
//                     ),
//                   ),
//                 ),
//               ),
//             if (imageUrl != null) const SizedBox(height: 12),
//             Text(
//               isGuestFavorite
//                   ? "This is a guest favorite: $name"
//                   : "Enjoy this amenity: $name",
//               style: GoogleFonts.delius(
//                 textStyle: const TextStyle(
//                   fontSize: 16,
//                   color: Colors.white70,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text(
//               "Close",
//               style: GoogleFonts.delius(
//                 textStyle: const TextStyle(
//                   fontSize: 14,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildInteractiveRuleTile({
//     required String title,
//     required String value,
//     required IconData icon,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12.0),
//       child: GestureDetector(
//         onTap: () {},
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 200),
//           decoration: BoxDecoration(
//             color: HexColor("#2A2A2A"), // Replaced gradient with solid color
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.2),
//                 blurRadius: 8,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Material(
//             color: Colors.transparent,
//             child: InkWell(
//               borderRadius: BorderRadius.circular(12),
//               onTap: () {},
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Row(
//                   children: [
//                     Icon(icon, color: Colors.white, size: 28).animate().scale(
//                       delay: const Duration(milliseconds: 100),
//                       duration: const Duration(milliseconds: 300),
//                       curve: Curves.easeInOut,
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             title,
//                             style: GoogleFonts.delius(
//                               textStyle: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             value,
//                             style: GoogleFonts.delius(
//                               textStyle: const TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.white70,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const Icon(
//                       Icons.arrow_forward_ios,
//                       color: Colors.white70,
//                       size: 16,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     ).animate().fadeIn(
//       duration: const Duration(milliseconds: 400),
//       curve: Curves.easeIn,
//     );
//   }
//
//   Widget _buildDescriptionWidget(String description) {
//     final containsHtmlTags = RegExp(r"<[^>]*>").hasMatch(description);
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child:
//           containsHtmlTags
//               ? Container(
//                 height: 600,
//                 child: InAppWebView(
//                   initialData: InAppWebViewInitialData(
//                     data: """
//                   <!DOCTYPE html>
//                   <html>
//                     <head>
//                       <style>
//                         body {
//                           font-family: 'Delius', sans-serif;
//                           color: white !important;
//                           background-color: transparent;
//                           margin: 0;
//                           padding: 0;
//                           font-size: 45px;
//                         }
//                         * {
//                           color: white !important;
//                           font-size: 45px;
//                           font-family: 'Delius', sans-serif;
//                         }
//                         p, div, span, h1, h2, h3, h4, h5, h6, li, a {
//                           color: white !important;
//                         }
//                       </style>
//                     </head>
//                     <body>
//                       $description
//                     </body>
//                   </html>
//                 """,
//                   ),
//                   initialOptions: InAppWebViewGroupOptions(
//                     crossPlatform: InAppWebViewOptions(
//                       transparentBackground: true,
//                       disableContextMenu: true,
//                       supportZoom: false,
//                     ),
//                     android: AndroidInAppWebViewOptions(
//                       forceDark: AndroidForceDark.FORCE_DARK_OFF,
//                     ),
//                   ),
//                 ),
//               )
//               : Text(
//                 description,
//                 style: GoogleFonts.delius(
//                   textStyle: const TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.normal,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//     );
//   }
//
//   Widget _buildDetailChip(String label) {
//     return Chip(
//       label: Text(
//         label,
//         style: GoogleFonts.delius(
//           textStyle: const TextStyle(fontSize: 12, color: Colors.white),
//         ),
//       ),
//       backgroundColor: HexColor("#3A3A3A"),
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//     );
//   }
//
//   Widget _buildExpansionSection({
//     required String title,
//     required List<String> items,
//   }) {
//     return Card(
//       color: HexColor("#2A2A2A"),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       child: ExpansionTile(
//         title: Text(
//           title,
//           style: GoogleFonts.delius(
//             textStyle: const TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w500,
//               color: Colors.white,
//             ),
//           ),
//         ),
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children:
//                   items
//                       .map(
//                         (item) => Padding(
//                           padding: const EdgeInsets.only(bottom: 8.0),
//                           child: Text(
//                             "• $item",
//                             style: GoogleFonts.delius(
//                               textStyle: const TextStyle(
//                                 fontSize: 15,
//                                 color: Colors.white70,
//                               ),
//                             ),
//                           ),
//                         ),
//                       )
//                       .toList(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//
// }
