import 'package:flutter/material.dart';
import 'package:geomap/providers/geo_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class GetPage extends StatelessWidget {
  const GetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final geoProvider = Provider.of<GeoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('G5-Maps'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            geoProvider.activeMenu();
          },
        ),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              initialCameraPosition: geoProvider.initialLocation,
              zoomGesturesEnabled: true,
              markers: Set.of(
                  (geoProvider.marker != null) ? [geoProvider.marker!] : []),
              circles: Set.of(
                  (geoProvider.circle != null) ? [geoProvider.circle!] : []),
              onMapCreated: (GoogleMapController controller) {
                geoProvider.googleMapController = controller;
              },
            ),
          ),
          Visibility(
            visible: geoProvider.isVisible,
            child: Container(
              margin: const EdgeInsets.only(
                top: 80,
                right: 10,
              ),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromARGB(255, 230, 175, 73).withOpacity(0.5),
              ),
              height: 200,
              width: 70,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        geoProvider.getLocationUser();
                      },
                      backgroundColor: const Color.fromARGB(255, 216, 143, 8),
                      child: const Icon(Icons.location_searching),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
