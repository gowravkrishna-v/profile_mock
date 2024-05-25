import 'dart:io';

import 'package:profile_mock/model/profile_model.dart';
import 'package:profile_mock/utilities/theme.dart';
import 'package:profile_mock/view/components/shared/custom_elevated_button.dart';
import 'package:profile_mock/view/components/shared/custom_text_button.dart';
import 'package:profile_mock/view/components/shared/stadium_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality, int? limit);

class UserInfoWidget extends StatefulWidget {
  final ProfileModel profile;
  const UserInfoWidget({
    super.key,
    required this.profile,
  });

  @override
  State<UserInfoWidget> createState() => _UserInfoWidgetState();
}

class _UserInfoWidgetState extends State<UserInfoWidget> {
  final ImagePicker imagePicker = ImagePicker();
  XFile? imageFile;

  Future<void> pickImage(
    ImageSource imageSource,
    BuildContext context,
  ) async {
    if (context.mounted) {
      try {
        XFile? pickedFile = await imagePicker.pickImage(
          source: imageSource,
          preferredCameraDevice: CameraDevice.front,
        );
        setState(() {
          imageFile = pickedFile;
        });
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  Future<Position?> fetchLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
      timeLimit: const Duration(
        seconds: 45,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: redAccent,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: (imageFile == null)
                      ? const Image(
                          image: AssetImage(
                            "assets/images/profile_picture.webp",
                          ),
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          File(imageFile!.path),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.05,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.profile.name ?? "N/A",
                      style: style9,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      widget.profile.email ?? "N/A",
                      style: style4.copyWith(
                        color: black54,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      (widget.profile.address ?? "N/A").toString(),
                      style: style2,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              StadiumButton(
                onTap: () => showAdaptiveDialog(
                  context: context,
                  builder: (context) => Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: MediaQuery.sizeOf(context).width,
                          decoration: BoxDecoration(
                            color: redAccent,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(
                                10,
                              ),
                              topRight: Radius.circular(
                                10,
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Pick image from",
                                style: style8.copyWith(
                                  color: white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomTextButton(
                          onTap: () {
                            pickImage(
                              ImageSource.camera,
                              context,
                            );
                            Navigator.pop(context);
                          },
                          child: "Camera",
                        ),
                        CustomElevatedButton(
                          text: "Gallery",
                          onTap: () {
                            pickImage(
                              ImageSource.gallery,
                              context,
                            );
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                child: Text(
                  "Change profile picture",
                  style: style3.copyWith(
                    color: white,
                  ),
                ),
              ),
              CustomTextButton(
                child: "Fetch location",
                onTap: () async {
                  try {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 60),
                        behavior: SnackBarBehavior.floating,
                        content: Text(
                          "Finding your current location...",
                          style: style7.copyWith(
                            color: white,
                          ),
                        ),
                      ),
                    );
                    Position? locationData = await fetchLocation();
                    if (!context.mounted) {
                      return;
                    }
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: green,
                        content: Text(
                          "Current latitude and longitude is ${locationData!.latitude}, ${locationData.longitude}",
                          style: style7.copyWith(
                            color: white,
                          ),
                        ),
                      ),
                    );
                  } catch (e) {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: red,
                        content: Text(
                          "Unable to determine the location",
                          style: style7.copyWith(
                            color: white,
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
