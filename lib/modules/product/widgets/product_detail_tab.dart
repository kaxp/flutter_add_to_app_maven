import 'package:kapil_add_to_app_flutter/constants/spacing_constants.dart';
import 'package:kapil_add_to_app_flutter/modules/product/models/product_detail_response.dart';
import 'package:kapil_add_to_app_flutter/modules/product/pages/product_detail_page.dart';
import 'package:kapil_add_to_app_flutter/theme/assets/app_colors.dart';
import 'package:kapil_add_to_app_flutter/theme/assets/app_icons.dart';
import 'package:kapil_add_to_app_flutter/theme/text_style_factory.dart';
import 'package:kapil_add_to_app_flutter/widgets/custom_network_image.dart';
import 'package:kapil_add_to_app_flutter/widgets/custom_youtube_player.dart';
import 'package:kapil_add_to_app_flutter/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ProductDetailTab extends StatefulWidget {
  const ProductDetailTab({
    super.key,
    required this.productDetail,
  });

  final List<ProductDetailTabData>? productDetail;

  @override
  State<ProductDetailTab> createState() => _ProductDetailTabState();
}

class _ProductDetailTabState extends State<ProductDetailTab>
    with SingleTickerProviderStateMixin {
  late TabController detailTabController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    detailTabController = TabController(
      vsync: this,
      length: widget.productDetail?.length ?? 0,
    );

    detailTabController.addListener(() {
      setState(() {
        currentPage = detailTabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.productDetail!.isEmpty) {
      return const NoDataWidget();
    } else {
      return Container(
        color: AppColors.pageBackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: kSpacingSmall,
            ),
            TabBar(
              controller: detailTabController,
              labelColor: AppColors.white,
              labelStyle:
                  TextStyleFactory.styleNormal14(fontFamily: AppFonts.dmSans),
              unselectedLabelColor: AppColors.black,
              unselectedLabelStyle:
                  TextStyleFactory.styleNormal14(fontFamily: AppFonts.dmSans),
              isScrollable: true,
              labelPadding: EdgeInsets.zero,
              tabAlignment: TabAlignment.start,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: AppColors.transparent,
              tabs: widget.productDetail!.asMap().entries.map(
                (e) {
                  return Tab(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      margin: e.key == 0
                          ? const EdgeInsets.only(left: 4)
                          : const EdgeInsets.only(left: 8),
                      decoration: BoxDecoration(
                        color: e.key == currentPage
                            ? AppColors
                                .black // Background color for the selected tab
                            : AppColors
                                .white, // Background color for unselected tabs
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                        border: Border.all(
                          color: e.key == currentPage
                              ? AppColors.black
                              : AppColors
                                  .black, // Border color for the selected tab
                        ),
                      ),
                      child: Text(
                        e.value.tabName,
                        style: TextStyle(
                          color: e.key == currentPage
                              ? AppColors.white
                              : AppColors.black,
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
            Expanded(
              child: TabBarView(
                controller: detailTabController,
                children: widget.productDetail!.isEmpty
                    ? <Widget>[]
                    : widget.productDetail!.map((dynamicContent) {
                        return ListView.separated(
                          itemCount: dynamicContent.content!.length,
                          padding: const EdgeInsets.symmetric(
                              vertical: kSpacingMedium),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (_, position) {
                            return contentWidget(
                              dynamicContent.content![position],
                              context,
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            height: kSpacingMedium,
                          ),
                        );
                      }).toList(),
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget contentWidget(ProductDetailTabsContent data, BuildContext context) {
    YoutubePlayerController? youtubeController;

    return Container(
      padding: const EdgeInsets.all(kSpacingMedium),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(kSpacingMedium),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.title!,
            style: TextStyleFactory.styleBold16(),
          ),
          const SizedBox(
            height: kSpacingXSmall,
          ),
          Visibility(
            visible: data.video != null || data.video == '',
            child: GestureDetector(
              onTap: () {
                youtubeController = setVideoController(data.video ?? '');

                if (data.video != null) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomYoutubePlayer(
                          youtubePlayerController: youtubeController!,
                          isDragDisabled: false,
                        );
                      });
                }
              },
              child: Stack(
                children: [
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          kSpacingMedium,
                        ),
                      ),
                    ),
                    child: AspectRatio(
                      aspectRatio: 27 / 16,
                      child: CustomImage.network(
                        (data.video ?? '').thumbnail,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: AppIcons.icYoutube(48),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: data.content != null,
            child: Text(
              data.content ?? '',
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }

  YoutubePlayerController setVideoController(String videoUrl,
      {bool autoPlay = true}) {
    return YoutubePlayerController(
      initialVideoId: videoUrl.videoId ?? '',
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    );
  }
}
