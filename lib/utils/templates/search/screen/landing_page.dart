// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:ziarra/screens/property_listing/property_types/bloc/property_types_bloc.dart';
// import 'package:ziarra/screens/property_listing/property_types/repository/property_types_repository.dart';
// import 'package:ziarra/screens/property_listing/search_property_listings/bloc/search_property_listing_bloc.dart';
// import 'package:ziarra/screens/property_listing/search_property_listings/repository/search_property_listing_repository.dart';
// import 'package:ziarra/screens/property_listing/search_property_listings/screen/search_property_listing_screen.dart';
// import 'package:ziarra/utils/navigation/navigation_helper.dart';
// import '../../../../utils/location_util.dart';
// import '../../../../utils/styling/color_constants.dart';
// import '../../../../utils/styling/text_styling.dart';
// import '../../property_details/screen/property_details_screen.dart';
//
// class PropertyListingsLandingPage extends StatefulWidget {
//   const PropertyListingsLandingPage({super.key});
//
//   @override
//   State<PropertyListingsLandingPage> createState() =>
//       _PropertyListingsLandingPageState();
// }
//
// class _PropertyListingsLandingPageState
//     extends State<PropertyListingsLandingPage> {
//   double? currentLat;
//   double? currentLng;
//   String? _locationError;
//   GoogleMapController? _mapController;
//   final Set<Marker> _markers = {};
//   String? selectedMarkerId;
//   static const LatLng _initialPosition = LatLng(
//     -1.286389,
//     36.817223,
//   ); // Nairobi, Kenya
//   bool _isLocationLoading = true;
//   final List<int> _selectedPropertyTypeIds = [];
//
//   void _loadMarkers(properties) {
//
//       _markers.clear();
//       for (var property in properties) {
//         if (property.location.lat != null && property.location.lng != null) {
//           _markers.add(
//             Marker(
//               markerId: MarkerId(property.id.toString()),
//               position: LatLng(property.location.lat!, property.location.lng!),
//               infoWindow: InfoWindow(
//                 title: property.name ?? 'No name',
//                 snippet: '${property.pricePerNight ?? 'N/A'}',
//               ),
//               icon: selectedMarkerId == property.id.toString()
//                   ? BitmapDescriptor.defaultMarkerWithHue(
//                 BitmapDescriptor.hueBlue,
//               )
//                   : BitmapDescriptor.defaultMarker,
//             ),
//           );
//         }
//       }
//
//   }
//
//   void _showMapBottomSheet() {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (context) => SizedBox(
//         height: MediaQuery.of(context).size.height * 0.8,
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Property Locations',
//                     style: kTitleStyle.copyWith(
//                       fontSize: 18,
//                       color: Colors.black,
//                     ),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.close),
//                     onPressed: () => Navigator.pop(context),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: GoogleMap(
//                 initialCameraPosition: const CameraPosition(
//                   target: _initialPosition,
//                   zoom: 7,
//                 ),
//                 markers: _markers,
//                 onMapCreated: (controller) {
//                   _mapController = controller;
//                 },
//                 onTap: (LatLng position) {
//                   _mapController?.hideMarkerInfoWindow(
//                     MarkerId(selectedMarkerId ?? ''),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     fetchCurrentLocation();
//     context.read<PropertyTypesBloc>().add(FetchPropertyTypes());
//   }
//
//   Future<void> fetchCurrentLocation() async {
//     try {
//       Map<String, String> location = await LocationUtil.getLatLong();
//       setState(() {
//         currentLat = double.parse(location["lat"]!);
//         currentLng = double.parse(location["long"]!);
//         _locationError = null;
//         _isLocationLoading = false;
//       });
//
//       if (currentLat == 0.0 && currentLng == 0.0) {
//         setState(() {
//           _locationError = 'Unable to fetch current location.';
//           _isLocationLoading = false;
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               'Unable to fetch current location. Please enable location services.',
//             ),
//             backgroundColor: Colors.orange,
//           ),
//         );
//       }
//     } catch (e) {
//       setState(() {
//         _locationError = 'Failed to get location: $e';
//         _isLocationLoading = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Failed to get location: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     NavigationHelper navigationHelper = NavigationHelper(context);
//
//     return Scaffold(
//       backgroundColor: kBackgroundColor,
//       appBar: AppBar(
//         centerTitle: true,
//         iconTheme: IconThemeData(color: kPrimaryColor),
//         backgroundColor: kBackgroundColor,
//         title: Text('Home Stays Properties', style: kTitleStyle.copyWith(color: Colors.white)),
//       ),
//       body: _isLocationLoading
//           ? const Center(
//         child: SpinKitPulse(color: Colors.amber, size: 30),
//       )
//           : _locationError != null
//           ? Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(_locationError!),
//             ElevatedButton(
//               onPressed: fetchCurrentLocation,
//               child: Text('Retry'),
//             ),
//           ],
//         ),
//       )
//           : currentLat == null || currentLng == null
//           ? Center(
//         child: Text('Location not available'),
//       )
//           : MultiBlocProvider(
//         providers: [
//           BlocProvider(
//             create: (context) => SearchPropertyListingBloc(
//                 SearchPropertyListingRepository())
//               ..add(
//                 FetchSearchPropertyListing(
//                   latitude: currentLat!,
//                   longitude: currentLng!,
//                   propertyTypes: _selectedPropertyTypeIds,
//                   amenitiesId: [],
//                   numberOfBedrooms: 1,
//                   numberOfGuests: 1,
//                   numberOfBathrooms: 1,
//                   numberOfBeds: 1,
//                   searchType: "broad",
//                 ),
//               ),
//           ),
//           BlocProvider(
//             create: (context) =>
//             PropertyTypesBloc(PropertyTypesRepository())
//               ..add(FetchPropertyTypes()),
//           ),
//         ],
//         child: Column(
//           children: [
//
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: InkWell(
//                 onTap: (){
//                   navigationHelper.navigateToPage(SearchPropertyListingScreen());
//                 },
//                 child: Container(
//                   height: 50,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [HexColor("#2A2A2A"),HexColor("#2A2A2A")],
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                     ),
//                     border: Border.all(color: Colors.transparent),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Center(child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text("Search properties...",style: kTitleStyle.copyWith(color: Colors.grey),),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Icon(Icons.search,color: kPrimaryColor,),
//                       )
//                     ],
//                   )),
//                 ),
//               ),
//             ),
//             // Property Types Filter
//             BlocBuilder<PropertyTypesBloc, PropertyTypesState>(
//               builder: (context, state) {
//                 if (state is PropertyTypesLoading) {
//                   return const Padding(
//                     padding: EdgeInsets.all(16.0),
//                     child: SpinKitPulse(
//                         color: Colors.amber, size: 30),
//                   );
//                 } else if (state is PropertyTypesLoaded) {
//                   return Container(
//                     height: 50,
//                     padding:
//                     const EdgeInsets.symmetric(horizontal: 16),
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: state.propertyTypes.length,
//                       itemBuilder: (context, index) {
//                         final propertyType =
//                         state.propertyTypes[index];
//                         final isSelected =
//                         _selectedPropertyTypeIds
//                             .contains(propertyType.id);
//                         return Padding(
//                           padding:
//                           const EdgeInsets.only(right: 8.0),
//                           child: FilterChip(
//                             label: Text(propertyType.type),
//                             selected: isSelected,
//                             onSelected: (selected) {
//                               setState(() {
//                                 if (selected) {
//                                   _selectedPropertyTypeIds
//                                       .add(propertyType.id);
//                                 } else {
//                                   _selectedPropertyTypeIds
//                                       .remove(propertyType.id);
//                                 }
//                               });
//                               context
//                                   .read<
//                                   SearchPropertyListingBloc>()
//                                   .add(
//                                 FetchSearchPropertyListing(
//                                   latitude: currentLat!,
//                                   longitude: currentLng!,
//                                   propertyTypes:
//                                   _selectedPropertyTypeIds,
//                                   amenitiesId: [],
//                                   numberOfBedrooms: 1,
//                                   numberOfGuests: 1,
//                                   numberOfBathrooms: 1,
//                                   numberOfBeds: 1,
//                                   searchType: "broad",
//                                 ),
//                               );
//                             },
//                             selectedColor: kPrimaryColor,
//                             labelStyle: TextStyle(
//                               color: isSelected
//                                   ? Colors.white
//                                   : Colors.black,
//                             ),
//                             backgroundColor: Colors.white,
//                             checkmarkColor: Colors.white,
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 } else if (state is PropertyTypesError) {
//                   return Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Text(
//                       'Error loading property types: ${state.errorMessage}',
//                       style: TextStyle(color: Colors.red),
//                     ),
//                   );
//                 }
//                 return const SizedBox.shrink();
//               },
//             ),
//             // Property Listings
//             Expanded(
//               child: SingleChildScrollView(
//                 physics: BouncingScrollPhysics(),
//                 child: BlocBuilder<SearchPropertyListingBloc,
//                     SearchPropertyListingState>(
//                   builder: (context, state) {
//                     if (state is SearchPropertyListingLoading) {
//                       return const Center(
//                         child: SpinKitPulse(
//                             color: Colors.amber, size: 30),
//                       );
//                     } else if (state
//                     is SearchPropertyListingLoaded) {
//                       _loadMarkers(state.propertyListing);
//                       return state.propertyListing.isEmpty
//                           ? Center(
//                         child: Text(
//                           "No properties available",
//                           style: GoogleFonts.delius(
//                               color: kPrimaryColor),
//                         ),
//                       )
//                           : ListView.builder(
//                         physics:
//                         NeverScrollableScrollPhysics(),
//                         padding: const EdgeInsets.all(16),
//                         itemCount:
//                         state.propertyListing.length,
//                         shrinkWrap: true,
//                         itemBuilder: (context, index) {
//                           final property = state
//                               .propertyListing[index];
//                           return Card(
//                             color: HexColor("#191919"),
//                             elevation: 4,
//                             margin: const EdgeInsets.only(
//                                 bottom: 16),
//                             shape: RoundedRectangleBorder(
//                               borderRadius:
//                               BorderRadius.circular(12),
//                             ),
//                             child: Column(
//                               crossAxisAlignment:
//                               CrossAxisAlignment.start,
//                               children: [
//                                 // Property Image
//                                 Stack(
//                                   children: [
//                                     ClipRRect(
//                                       borderRadius:
//                                       const BorderRadius
//                                           .vertical(
//                                           top: Radius
//                                               .circular(
//                                               12)),
//                                       child: Image.network(
//                                         property.images
//                                             .isNotEmpty
//                                             ? property
//                                             .images[0]
//                                             .image
//                                             : 'https://via.placeholder.com/400x300',
//                                         height: 180,
//                                         width: double
//                                             .infinity,
//                                         fit: BoxFit.cover,
//                                         errorBuilder:
//                                             (context, error,
//                                             stackTrace) =>
//                                             Image.asset(
//                                               'assets/images/ziarra_logo.jpg',
//                                               height: 180,
//                                               width: double
//                                                   .infinity,
//                                               fit: BoxFit.cover,
//                                             ),
//                                       ),
//                                     ),
//                                     Positioned(
//                                       top: 10,
//                                       right: 10,
//                                       child: GestureDetector(
//                                         onTap: () {
//                                           _mapController
//                                               ?.animateCamera(
//                                             CameraUpdate
//                                                 .newLatLng(
//                                               LatLng(
//                                                 property
//                                                     .location
//                                                     .lat!,
//                                                 property
//                                                     .location
//                                                     .lng!,
//                                               ),
//                                             ),
//                                           );
//                                           setState(() {
//                                             selectedMarkerId =
//                                                 property.id
//                                                     .toString();
//                                             _loadMarkers(state
//                                                 .propertyListing);
//                                           });
//                                           _showMapBottomSheet();
//                                         },
//                                         child: Container(
//                                           padding:
//                                           const EdgeInsets
//                                               .all(6),
//                                           decoration:
//                                           BoxDecoration(
//                                             color: Colors
//                                                 .white
//                                                 .withOpacity(
//                                               0.9,
//                                             ),
//                                             borderRadius:
//                                             BorderRadius
//                                                 .circular(
//                                                 20),
//                                           ),
//                                           child: Icon(
//                                             Icons
//                                                 .map_outlined,
//                                             color:
//                                             kPrimaryColor,
//                                             size: 20,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 // Property Details
//                                 Padding(
//                                   padding:
//                                   const EdgeInsets.all(
//                                       16),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                     CrossAxisAlignment
//                                         .start,
//                                     children: [
//                                       Text(
//                                         property.name ??
//                                             'No name',
//                                         style: kTitleStyle
//                                             .copyWith(
//                                           color:
//                                           Colors.white,
//                                         ),
//                                         maxLines: 1,
//                                         overflow:
//                                         TextOverflow
//                                             .ellipsis,
//                                       ),
//                                       const SizedBox(
//                                           height: 8),
//                                       Row(
//                                         children: [
//                                           const Icon(
//                                             Icons
//                                                 .location_on_outlined,
//                                             size: 16,
//                                             color:
//                                             Colors.red,
//                                           ),
//                                           const SizedBox(
//                                               width: 4),
//                                           Expanded(
//                                             child: Text(
//                                               property
//                                                   .location
//                                                   .formattedAddress ??
//                                                   'Location not specified',
//                                               style: kNormalTextStyle
//                                                   .copyWith(
//                                                 color:
//                                                 kPrimaryColor,
//                                               ),
//                                               maxLines: 1,
//                                               overflow:
//                                               TextOverflow
//                                                   .ellipsis,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       const SizedBox(
//                                           height: 12),
//                                       Row(
//                                         mainAxisAlignment:
//                                         MainAxisAlignment
//                                             .spaceBetween,
//                                         children: [
//                                           Text(
//                                             '${property.currency} ${property.pricePerNight} / Night',
//                                             style: GoogleFonts
//                                                 .delius(
//                                               textStyle:
//                                               TextStyle(
//                                                 fontSize:
//                                                 16,
//                                                 fontWeight:
//                                                 FontWeight
//                                                     .bold,
//                                                 color: Colors
//                                                     .white,
//                                               ),
//                                             ),
//                                           ),
//                                           ElevatedButton(
//                                             style:
//                                             ElevatedButton
//                                                 .styleFrom(
//                                               backgroundColor:
//                                               kPrimaryColor,
//                                               shape:
//                                               RoundedRectangleBorder(
//                                                 borderRadius:
//                                                 BorderRadius
//                                                     .circular(8),
//                                               ),
//                                               padding:
//                                               const EdgeInsets
//                                                   .symmetric(
//                                                 horizontal:
//                                                 16,
//                                                 vertical:
//                                                 8,
//                                               ),
//                                             ),
//                                             onPressed: () {
//                                               navigationHelper
//                                                   .navigateToPage(
//                                                 PropertyDetailsScreen(
//                                                   propertyCode:
//                                                   property
//                                                       .code,
//                                                   propertyName:
//                                                   property
//                                                       .name,
//                                                 ),
//                                               );
//                                             },
//                                             child:
//                                             const Text(
//                                               'View Details',
//                                               style:
//                                               TextStyle(
//                                                 color: Colors
//                                                     .white,
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       );
//                     } else if (state
//                     is SearchPropertyListingError) {
//                       return Center(
//                         child: Column(
//                           mainAxisAlignment:
//                           MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               "Failed to load properties",
//                               style: GoogleFonts.delius(
//                                   color: Colors.white),
//                             ),
//                             const SizedBox(height: 20),
//                             ElevatedButton(
//                               onPressed: () {
//                                 context
//                                     .read<
//                                     SearchPropertyListingBloc>()
//                                     .add(
//                                   FetchSearchPropertyListing(
//                                     latitude: currentLat!,
//                                     longitude: currentLng!,
//                                     propertyTypes:
//                                     _selectedPropertyTypeIds,
//                                     amenitiesId: [],
//                                     numberOfBedrooms: 1,
//                                     numberOfGuests: 1,
//                                     numberOfBathrooms: 1,
//                                     numberOfBeds: 1,
//                                     searchType: 'broad',
//                                   ),
//                                 );
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.amber,
//                               ),
//                               child: Text(
//                                 "Retry",
//                                 style: GoogleFonts.delius(
//                                     color: Colors.black),
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     }
//                     return const SizedBox.shrink();
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }