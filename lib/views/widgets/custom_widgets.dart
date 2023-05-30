import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waffarha_flutter_challenge/controllers/photos_controller.dart';
import 'package:waffarha_flutter_challenge/utils/color_manager.dart';
import 'package:waffarha_flutter_challenge/utils/font_manager.dart';
import 'package:waffarha_flutter_challenge/utils/size_config.dart';
import 'package:waffarha_flutter_challenge/utils/values_manager.dart';
import 'package:waffarha_flutter_challenge/views/widgets/custom_text.dart';

import 'custom_loader.dart';
import 'image_with_border_radius.dart';

/// A custom widget for displaying a dropdown button to sort photos by title or album ID.
Widget sortByDropdown(PhotoController photoController) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      const Text('Sort By'),
      const SizedBox(height: AppSize.s12),
      Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p12,
        ),
        height: SizeConfig.screenHeight * 0.04,
        width: SizeConfig.screenWidth * 0.31,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s28),
          border: Border.all(color: ColorManager.colorGrayText),
          color: ColorManager.colorLightGray,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: photoController.sortBy.value,
            items: const [
              DropdownMenuItem(
                value: 'title',
                child: CustomText(
                  text: 'Title',
                  fontSize: FontSize.s14,
                ),
              ),
              DropdownMenuItem(
                value: 'albumId',
                child: CustomText(
                  text: 'Album Id',
                  fontSize: FontSize.s14,
                ),
              ),
            ],
            onChanged: (value) {
              photoController.setSortBy(value!);
            },
          ),
        ),
      ),
    ],
  );
}

/// A custom widget or displaying a dropdown button to filter photos by album.
Widget filterByAlbumDropdown(PhotoController photoController) {
  return Column(
    children: [
      const Text('Filter By Album'),
      const SizedBox(height: AppSize.s12),
      Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p12,
        ),
        height: SizeConfig.screenHeight * 0.04,
        width: SizeConfig.screenWidth * 0.22,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s28),
          border: Border.all(color: ColorManager.colorGrayText),
          color: ColorManager.colorLightGray,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<int>(
            value: photoController.selectedAlbum.value,
            items: [
              const DropdownMenuItem(
                value: 0,
                child: CustomText(
                  text: 'All',
                  fontSize: FontSize.s14,
                ),
              ),
              ...photoController.albums.map(
                (album) => DropdownMenuItem(
                  value: album,
                  child: Text(album.toString()),
                ),
              ),
            ],
            onChanged: (value) {
              photoController.setSelectedAlbum(value!);
              photoController.currentPage.value = 1;
              photoController.fetchPhotos();
            },
          ),
        ),
      ),
    ],
  );
}

/// A custom widget for displaying a list of photos with thumbnails and details.
Widget photosList(PhotoController photoController) {
  return Obx(
    () => ListView.builder(
      itemCount: photoController.sortedPhotos.length,
      itemBuilder: (context, index) {
        final photo = photoController.sortedPhotos[index];
        return Card(
          child: ListTile(
            leading: ImageWithBorderRadius(
              width: AppSize.s50,
              height: AppSize.s50,
              imageUrl: photoController.sortedPhotos[index].thumbnailUrl,
            ),
            title: Text(photo.title),
            subtitle: Text('Album Id: ${photo.albumId}'),
            trailing: Text('${photo.id}'),
          ),
        );
      },
    ),
  );
}

/// A custom widget for displaying a list of photos with thumbnails and details.
Widget photosGridList(PhotoController photoController) {
  return Obx(
    () => GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: photoController.sortedPhotos.length,
      itemBuilder: (context, index) {
        final photo = photoController.sortedPhotos[index];
        return Container(
          margin: const EdgeInsets.all(AppMargin.m8),
          decoration: BoxDecoration(
            color: ColorManager.whiteColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          width: double.infinity,
          height: SizeConfig.screenHeight * 0.6,
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ImageWithBorderRadius(
                  width: double.infinity,
                  height: SizeConfig.screenHeight * 0.06,
                  imageUrl: photo.thumbnailUrl,
                ),
                CustomText(
                  text: photo.title,
                  fontSize: FontSize.s14,
                ),
                const SizedBox(
                  height: AppSize.s4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Album Id: ${photo.albumId}'),
                    Text('${photo.id}'),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

/// A custom widget for displaying pagination buttons to navigate between pages of photos.
Widget paginationButtons(PhotoController photoController) {
  return Padding(
    padding: const EdgeInsets.only(left: AppPadding.p12, right: AppPadding.p12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Obx(
          () => (photoController.isLoadingPreviousData.value)
              ? const Center(
                  child: CustomLoader(size: AppSize.s28),
                )
              : SizedBox(
                  height: SizeConfig.screenHeight * 0.04,
                  width: SizeConfig.screenWidth * 0.25,
                  child: ElevatedButton(
                    onPressed: (photoController.currentPage.value == 1)
                        ? null
                        : () async {
                            await photoController.prevPage();
                          },
                    child: const Text('Prev'),
                  ),
                ),
        ),
        const SizedBox(width: AppSize.s12),
        Obx(() => Text('Page ${photoController.currentPage.value}')),
        const SizedBox(width: AppSize.s12),
        Obx(
          () => (photoController.isLoadingNextData.value)
              ? const Center(
                  child: CustomLoader(
                    size: AppSize.s40,
                  ),
                )
              : SizedBox(
                  height: SizeConfig.screenHeight * 0.04,
                  width: SizeConfig.screenWidth * 0.25,
                  child: ElevatedButton(
                    onPressed: (photoController.noMoreData.value == true)
                        ? null
                        : () async {
                            await photoController.nextPage();
                          },
                    child: const Text('Next'),
                  ),
                ),
        ),
      ],
    ),
  );
}
