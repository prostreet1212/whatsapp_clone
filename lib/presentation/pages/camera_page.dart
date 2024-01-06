import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late List<CameraDescription> cameras;
   CameraController? _cameraController;
 late  Future<List<AssetEntity>> _galleryPhotos;

  @override
  void initState() {
    initializeCamera();
    _galleryPhotos=getImagesFromGallery();
    super.initState();
  }

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    _cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    _cameraController!.initialize().then((value) {
      if (!mounted) return;
      setState(() {});
    });
  }
  Future<List<AssetEntity>> getImagesFromGallery() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend(); // the method can use optional param `permission`.
    if (ps.isAuth) {
      print('isAuth');
      final FilterOptionGroup _filterOptionGroup = FilterOptionGroup(
        imageOption: const FilterOption(
          sizeConstraint: SizeConstraint(ignoreSize: true),
        ),
      );
      final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(
        onlyAll: true,
        filterOption: _filterOptionGroup,
      );
      paths.forEach((element) {
        print('ПАПКИ $element');
      });
      final List<AssetEntity> entities = await paths[0].getAssetListPaged(page: 0, size: 10000);

        return entities;


    } else if (ps.hasAccess) {
      print('hasAccess');
      return [];
    } else {
      print('access denied photo');
      return [];
    }


  }

  @override
  Widget build(BuildContext context) {
    if (_cameraController==null||!_cameraController!.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: CameraPreview(_cameraController!),
          ),
          _galleryWidget(),
          _cameraButtonWidget(),
        ],
      ),
    );
  }

  Widget _cameraButtonWidget() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.flash_on,
              color: Colors.white,
              size: 30,
            ),
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
            InkWell(
              onTap: ()async {


              },
              child: Icon(
                Icons.camera_alt,
                size: 30,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _galleryWidget() {
    return Positioned(
        bottom: 100,
        right: 0,
        left: 0,
        child: Container(
          height: 55,
          //color: Colors.orange,
          child: FutureBuilder(
            future: _galleryPhotos,
            builder: (context,snapshot){
              if (snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(right: 8),
                        height: 55,
                        width: 50,
                        decoration: BoxDecoration(color: Colors.red.withOpacity(.2)),
                        child: FutureBuilder(
                          future: snapshot.data![index].file,
                          builder: (context,snapshot){
                            if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                              return Image.file(
                                snapshot.data!,
                                //_galleryPhotos[index].thumbnailData,
                                //File(_galleryPhotos[index]),
                                fit: BoxFit.cover,
                              );
                            }else{
                              return Container();
                            }

                          },
                        ),
                      );
                    });
              }else{
                return Container();
              }

            },
          ),
        ));
  }
}
