import 'package:kapil_add_to_app_flutter/constants/spacing_constants.dart';
import 'package:kapil_add_to_app_flutter/theme/assets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CustomYoutubePlayer extends StatefulWidget {
  const CustomYoutubePlayer({
    super.key,
    required this.youtubePlayerController,
    this.isDragDisabled = true,
    this.isFullScreenEnable = true,
    this.shouldShowBottomWidget = true,
    this.builder,
    this.onEnded,
  });

  final YoutubePlayerController youtubePlayerController;
  final bool? isDragDisabled;
  final bool? isFullScreenEnable;
  final bool? shouldShowBottomWidget;
  final Widget Function(BuildContext, Widget)? builder;
  final Function(YoutubeMetaData)? onEnded;

  @override
  State<CustomYoutubePlayer> createState() => _CustomYoutubePlayerState();
}

class _CustomYoutubePlayerState extends State<CustomYoutubePlayer> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    double progressIndicatorWidth = width * .95 - 32;

    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        actionsPadding: const EdgeInsets.all(kSpacingMedium),
        aspectRatio: height / width,
        controller: widget.youtubePlayerController,
        showVideoProgressIndicator: false,
        topActions: [
          Visibility(
            visible: widget.isFullScreenEnable!,
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.black,
                shape: BoxShape.circle,
              ),
              child: FullScreenButton(
                controller: widget.youtubePlayerController,
              ),
            ),
          ),
        ],
        bottomActions: widget.shouldShowBottomWidget!
            ? [
                const Spacer(), // Adding Spacer to make the ProgressBar in center of the screen
                SizedBox(
                  width: progressIndicatorWidth,
                  child: IgnorePointer(
                    ignoring: widget
                        .isDragDisabled!, // default value is drag disabled
                    child: ProgressBar(
                      isExpanded: false,
                      controller: widget.youtubePlayerController,
                      colors: const ProgressBarColors(
                        playedColor: AppColors.white,
                        handleColor: Colors.transparent,
                        bufferedColor: AppColors.borderColor,
                        backgroundColor: AppColors.borderColor,
                      ),
                    ),
                  ),
                ),
                const Spacer(), // Adding Spacer to make the ProgressBar in center of the screen
              ]
            : [],
        thumbnail: const SizedBox.shrink(),
        onEnded: widget.onEnded ??
            (data) => {
                  if (widget.youtubePlayerController.value.isFullScreen)
                    {widget.youtubePlayerController.toggleFullScreenMode()},
                  widget.youtubePlayerController.pause(),
                  widget.youtubePlayerController.seekTo(Duration.zero),
                },
      ),
      onEnterFullScreen: () {
        setState(() {
          progressIndicatorWidth = height;
        });
      },
      onExitFullScreen: () {
        setState(() {
          progressIndicatorWidth = width * .95 - 32;
        });

        // Need to enable the status bar when exiting the fullscreen as while entering
        // the fullscreen, the statusbar is disabled inside the [YoutubePlayerBuilder]
        // class of [youtube_player_flutter] plugin.
        // Enable status bar.
        SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.manual,
          overlays: [
            SystemUiOverlay.top,
            SystemUiOverlay.bottom,
          ],
        );

        // Restore app's overlays settings.
        SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
        );
      },
      builder: widget.builder ??
          (context, videoPlayer) {
            return UnconstrainedBox(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                width: width * .95,
                height: ((width * .95) / 16) * 9,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: videoPlayer,
                  ),
                ),
              ),
            );
          },
    );
  }
}
