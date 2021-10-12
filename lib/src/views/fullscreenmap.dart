import 'dart:typed_data';

import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:http/http.dart' as http;
import 'package:mapbox_gl/mapbox_gl.dart';


class FullScreenMap extends StatefulWidget{

  @override
  _FullScreenMapState createState() => _FullScreenMapState();
}

class _FullScreenMapState extends State<FullScreenMap> {
  MapboxMapController? mapController;

  final center = LatLng(-6.472352016305042, -76.39615172024821);
  //final center = LatLng(-6.0753924080396216, -76.96540920171033);
  String selectedStyle = 'mapbox://styles/madaichuco/ckun34e991c2s18lah30rlqv0';
  final satellite = 'mapbox://styles/madaichuco/ckunbxqf19twj18p98zo5kflc';
  final streets_g = 'mapbox://styles/madaichuco/ckun3vc1h6i1519mwqgkew02m';
  final mono_verde= 'mapbox://styles/madaichuco/ckun34e991c2s18lah30rlqv0';

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
    //_onStyleLoaded();
  }

  /*void _onStyleLoaded() {
    addImageFromAsset("assetImage", "assets/custom-icon.png");
    addImageFromUrl("networkImage", "https://via.placeholder.com/50");
  }

  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return mapController!.addImage(name, list);
  }

  /// Adds a network image to the currently displayed style
  Future<void> addImageFromUrl(String name, url) async {
    var response = await http.get(url);
    return mapController!.addImage(name, response.bodyBytes);
  }
 */
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: crearMapa(),
      floatingActionButton: botonesFlotantes(),
    );
  }

  Column botonesFlotantes() {
    return Column(
     mainAxisAlignment: MainAxisAlignment.end,
     children: <Widget>[

       //Symbolos
       FloatingActionButton(
           child: Icon(Icons.add_circle_outline_outlined),
           onPressed: (){
             mapController?.addSymbol( SymbolOptions(
             geometry: center,
             iconSize: 2.5,
             iconImage: 'attraction-15',
             textField: 'Montaña creada aquí',
             //textColor: '#cccccc' ,
             textOffset: Offset(0,2)
           ));
           }
       ),
       SizedBox(height: 5),

       //ZoomIn
       FloatingActionButton(
         child: Icon(Icons.zoom_in),
         onPressed: (){

           //mapController?.animateCamera(CameraUpdate.tiltTo(40));
           mapController?.animateCamera(CameraUpdate.zoomIn());
         }
       ),
       SizedBox(height: 5),

       //ZoomOut
       FloatingActionButton(
           child: Icon(Icons.zoom_out),
           onPressed: (){

             //mapController?.animateCamera(CameraUpdate.tiltTo(40));
             mapController?.animateCamera(CameraUpdate.zoomOut());
           }
       ),
       SizedBox(height: 5),

      //cambiar Estilos de Mapa
       FloatingActionButton(
        child: Icon( Icons.add_to_home_screen),
        onPressed: (){

          if (selectedStyle == mono_verde){
            selectedStyle = streets_g;
          }else{
            if(selectedStyle == streets_g){
              selectedStyle = satellite;
            }else{
              selectedStyle = mono_verde;
            }
          }
          setState(() {});
        }
       )
     ],
    );
  }

  MapboxMap crearMapa() {
    return MapboxMap(
        styleString: selectedStyle,
        onMapCreated: _onMapCreated,
        initialCameraPosition:
          CameraPosition(
            target: center,
            zoom:14
          ),
    );
  }
}