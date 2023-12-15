import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {

  late List<CameraDescription> cameras;
  late CameraController _cameraController;
late List<dynamic> _galleryPhotos;
  @override
  void initState() {
    super.initState();

  }

  Future<void>initializeCamera()async{
    cameras=await availableCameras();
    _cameraController=CameraController(cameras[0], ResolutionPreset.medium);
    _cameraController.initialize().then((value) {
      if(mounted)return;
      setState(() {});
    });
  }

  Future<void> getImagesFromGallery()async{

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Camera Page'),
      ),
    );
  }
}