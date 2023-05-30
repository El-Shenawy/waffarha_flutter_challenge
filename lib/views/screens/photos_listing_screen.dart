import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waffarha_flutter_challenge/utils/color_manager.dart';
import '../../controllers/photos_controller.dart';
import '../../utils/size_config.dart';
import '../../utils/values_manager.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_loader.dart';
import '../widgets/custom_widgets.dart';
import '../widgets/display_type_button.dart';

/// A view class to display the photo data and handle user interactions.
class PhotoListingPage extends StatefulWidget {
  @override
  State<PhotoListingPage> createState() => _PhotoListingPageState();
}

class _PhotoListingPageState extends State<PhotoListingPage> {
  /// The controller for managing photos.
  final PhotoController photoController = Get.put(PhotoController());

  /// Whether the photo data is displayed in a grid or list view.
  bool _isGrid = false;

  Widget _buildSortAndFilterRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        sortByDropdown(photoController),
        const SizedBox(width: AppSize.s8),
        filterByAlbumDropdown(photoController),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Initialize the size config to adapt to different screen sizes.
    SizeConfig().init(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Photos Listing',
        backgroundColor: ColorManager.mainColor,
      ),
      bottomSheet: Container(
        height: SizeConfig.screenHeight * 0.08,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: paginationButtons(photoController),
      ),
      body: Obx(
        () => photoController.isLoading.value
            ? const Center(
                child: CustomLoader(),
              )
            : Padding(
                padding: const EdgeInsets.all(AppPadding.p14),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DisplayTypeToggleButtons(
                          isGrid: _isGrid,
                          onChanged: (bool value) {
                            setState(() {
                              _isGrid = value;
                            });
                          },
                        ),
                        _buildSortAndFilterRow(),
                      ],
                    ),
                    const SizedBox(height: AppSize.s8),
                    Expanded(
                        child: _isGrid
                            ? photosGridList(photoController)
                            : photosList(photoController)),
                    const SizedBox(height: AppSize.s50),
                  ],
                ),
              ),
      ),
    );
  }
}
