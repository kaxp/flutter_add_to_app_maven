import 'dart:io';
import 'package:kapil_add_to_app_flutter/constants/radius_constants.dart';
import 'package:kapil_add_to_app_flutter/constants/spacing_constants.dart';
import 'package:kapil_add_to_app_flutter/injection_container.dart';
import 'package:kapil_add_to_app_flutter/modules/leads/blocs/lead_queries_bloc.dart';
import 'package:kapil_add_to_app_flutter/modules/leads/models/lead_query_response.dart';
import 'package:kapil_add_to_app_flutter/strings/app_strings.dart';
import 'package:kapil_add_to_app_flutter/theme/assets/app_colors.dart';
import 'package:kapil_add_to_app_flutter/theme/assets/app_icons.dart';
import 'package:kapil_add_to_app_flutter/theme/text_style_factory.dart';
import 'package:kapil_add_to_app_flutter/utils/extensions.dart';
import 'package:kapil_add_to_app_flutter/widgets/custom_appbar.dart';
import 'package:kapil_add_to_app_flutter/widgets/custom_loader.dart';
import 'package:kapil_add_to_app_flutter/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LeadsQueriesPage extends StatefulWidget {
  final int leadID;

  const LeadsQueriesPage({super.key, required this.leadID});

  @override
  State<LeadsQueriesPage> createState() => _LeadsQueriesPageState();
}

class _LeadsQueriesPageState extends State<LeadsQueriesPage> {
  final _bloc = sl.get<LeadQueriesBloc>();
  final _queryTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc.getLeadQueries(widget.leadID);
  }

  @override
  void dispose() {
    _queryTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LeadQueriesBloc, LeadQueriesState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is LeadQueryLoaded) {
          _queryTextController.text = '';
          context.hideKeyboard();
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: CustomAppBar(
            title: Text(
              AppStrings.dispute,
            ),
            isCenter: true,
          ),
          body: CustomLoader(
            isLoading: state is LeadQueryInitial || state is LeadQueryLoading,
            child: Column(
              children: [
                _QueryStatusView(state.leadQueryData),
                _QueriesListView(context, state.leadQueryData),
                _BottomView(state, _queryTextController, _bloc, widget.leadID),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _QueriesListView(BuildContext context, LeadQueryData? leadQueryData) {
  return Expanded(
    child: MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo is ScrollEndNotification &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            // controller.loadQueriesDetail(false);
            return true;
          }
          return false;
        },
        child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(
                vertical: kSpacingMedium, horizontal: kSpacingMedium),
            physics: const ScrollPhysics(),
            itemCount: leadQueryData?.queries?.length ?? 0,
            itemBuilder: (context, position) {
              final String date1 = leadQueryData?.queries?[position].createdAt!
                      .split(' ')[0]
                      .replaceAll('T', '  ') ??
                  '';
              final String newDate1 = date1.toDDMM();
              String date2 = '';
              String newDate2 = '';
              if (position > 0) {
                date2 = leadQueryData?.queries?[position - 1].createdAt!
                        .split('.')[0]
                        .replaceAll('T', '  ') ??
                    '';
                newDate2 = date2.toDDMM();
              }
              return Bubble(
                  message: leadQueryData?.queries?[position].comment ?? '',
                  time: (leadQueryData?.queries?[position].createdAt ?? '')
                      .split(' ')[0]
                      .replaceAll('T', '  '),
                  isShowDate: newDate1 == newDate2 ? false : true,
                  index: position,
                  documentsImages:
                      leadQueryData?.queries?[position].documentImage ?? [],
                  documentsFiles:
                      leadQueryData?.queries?[position].documentFile ?? [],
                  isMe: leadQueryData?.queries?[position].adminId != null
                      ? false
                      : true);
            }),
      ),
    ),
  );
}

Widget _QueryStatusView(LeadQueryData? leadQueryData) {
  return Container(
    padding: const EdgeInsets.only(
        left: kSpacingMedium,
        right: kSpacingMedium,
        top: kSpacingSmall,
        bottom: kSpacingSmall),
    color: AppColors.blueBgColorTop,
    width: double.infinity,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Text(
            leadQueryData?.queryType != null &&
                    leadQueryData!.queryType.toString().isNotEmpty
                ? leadQueryData.queryType.toString()
                : AppStrings.disputeRelatedTo,
            maxLines: 2,
            style: TextStyleFactory.styleNormal14(color: AppColors.blackLight),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: (leadQueryData?.status ?? false) == true
                ? AppColors.yellowBgColor.withOpacity(0.5)
                : AppColors.redBgColorExpired,
            borderRadius: BorderRadius.circular(kSpacingLarge),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kSpacingLarge, vertical: kSpacingXSmall),
            child: Text(
              (leadQueryData?.status ?? false)
                  ? AppStrings.open
                  : AppStrings.closed,
              style: TextStyleFactory.styleNormal12(
                  color: (leadQueryData?.status ?? false) == true
                      ? AppColors.yellowTextColor
                      : AppColors.redTextColorExpired),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _BottomView(
    LeadQueriesState state,
    TextEditingController queryTextController,
    LeadQueriesBloc bloc,
    int leadID) {
  return Container(
    color: AppColors.blueBgColorBottom,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _getAttachments(state.selectedFiles),
        _getTextFieldWithOptions(state, queryTextController, bloc, leadID),
      ],
    ),
  );
}

Widget _getAttachments(List<File>? selectedFiles) {
  return (selectedFiles ?? []).isNotEmpty
      ? SizedBox(
          height: kSpacing50,
          width: double.infinity,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(
              top: kSpacingSmall,
              left: kSpacingMedium,
              right: kSpacingMedium,
            ),
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: selectedFiles?.length ?? 0,
            itemBuilder: (context, pos) {
              return InkWell(
                onTap: () {
                  selectedFiles.removeAt(pos);
                },
                child: SizedBox(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: kSpacingXxSmall,
                      horizontal: kSpacingMedium,
                    ),
                    //height: 50.sp,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(kSpacingMedium),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: kSpacingOne),
                          child: Text(
                            selectedFiles![pos]
                                .path
                                .split('')
                                .last
                                .truncateFileName(),
                            style: TextStyleFactory.styleBold14(
                                fontFamily: AppFonts.dmSans,
                                color: AppColors.greyLightSubtitleColor),
                          ),
                        ),
                        const SizedBox(
                          width: kSpacingSmall,
                        ),
                        AppIcons.icClearSolid(
                            color: AppColors.redTextColorExpired),
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                width: kSpacingSmall,
              );
            },
          ),
        )
      : Container();
}

Widget _getTextFieldWithOptions(
    LeadQueriesState state,
    TextEditingController queryTextController,
    LeadQueriesBloc bloc,
    int leadID) {
  return Padding(
    padding: const EdgeInsets.only(
        left: kSpacingMedium,
        right: kSpacingMedium,
        top: kSpacingSmall,
        bottom: kSpacingSmall),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        /*Container(
          decoration: BoxDecoration(
              color: AppColors.greenBgColorSuccess,
              borderRadius: BorderRadius.circular(kRadiusXMedium),),
          child: InkWell(
            onTap: () {},
            child: AppIcons.icPlus(
              width: kSpacingXLarge,
              height: kSpacingXLarge,
            ),
          ),
        ),
        const SizedBox(
          width: kSpacingMedium,
        ),*/
        Expanded(
          child: TextField(
            controller: queryTextController,
            autofocus: false,
            enabled: (state.leadQueryData?.status ?? false),
            textAlign: TextAlign.start,
            decoration: InputDecoration(
              fillColor: Colors.white,
              hintText: (state.leadQueryData?.status ?? false)
                  ? AppStrings.sendMessage
                  : AppStrings.markedResolved,
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(kSpacingLarge),
                ),
                borderSide: BorderSide(
                    color: AppColors.borderColor, width: kSpacingOne),
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(kSpacingLarge),
                ),
                borderSide: BorderSide(
                    color: AppColors.borderColor, width: kSpacingOne),
              ),
              filled: true,
              contentPadding: const EdgeInsets.only(
                  bottom: kSpacingMedium,
                  left: kSpacingMedium,
                  right: kSpacingMedium),
            ),
            style: TextStyleFactory.styleNormal16(
              fontWeight: FontWeight.w400,
              color: AppColors.black,
            ),
          ),
        ),
        const SizedBox(
          width: kSpacingSmall,
        ),
        state is LeadQuerySendLoading
            ? const CircularProgressIndicator()
            : InkWell(
                onTap: () {
                  if (queryTextController.text.isNotEmpty) {
                    bloc.onSubmitTap(
                        leadId: leadID,
                        query: queryTextController.text,
                        queryType: '',
                        files: []);
                  }
                },
                child: AppIcons.icSend(width: kSpacingXLarge),
              ),
      ],
    ),
  );
}

class Bubble extends StatelessWidget {
  const Bubble({
    super.key,
    required this.message,
    required this.time,
    required this.isShowDate,
    required this.index,
    required this.documentsImages,
    required this.documentsFiles,
    required this.isMe,
  });

  final String message, time;
  final bool isMe;
  final bool isShowDate;
  final int index;
  final List<DocMedia> documentsImages, documentsFiles;

  @override
  Widget build(BuildContext context) {
    Color bg = isMe ? AppColors.greyBgUserComment : AppColors.black;
    final align = isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final radius = isMe
        ? const BorderRadius.only(
            topLeft: Radius.circular(kSpacingMedium),
            bottomLeft: Radius.circular(kSpacingMedium),
            bottomRight: Radius.circular(kSpacingMedium),
          )
        : const BorderRadius.only(
            topRight: Radius.circular(kSpacingMedium),
            bottomLeft: Radius.circular(kSpacingMedium),
            bottomRight: Radius.circular(kSpacingMedium),
          );
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: align,
          children: <Widget>[
            Text(
              isShowDate ? time : '',
              style: TextStyleFactory.styleBold14(
                  fontFamily: AppFonts.dmSans,
                  color: AppColors.greyLightSubtitleColor),
            ).alignTo(Alignment.center),
            SizedBox(
              height: isShowDate ? kSpacingXxSmall : kSpacingZero,
            ),
            Column(
              crossAxisAlignment: align,
              children: <Widget>[
                Stack(
                  children: [
                    Visibility(
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: kSpacingXxLarge, right: kSpacingXxLarge),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: .5,
                              spreadRadius: 1.0,
                              color: Colors.black.withOpacity(.12),
                            ),
                          ],
                          color: bg,
                          borderRadius: radius,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: kSpacingMedium,
                            vertical: kSpacingSmall,
                          ),
                          child: Text(
                            message,
                            style: TextStyleFactory.styleNormal14(
                                color:
                                    isMe ? AppColors.black : AppColors.white),
                          ),
                        ),
                      ),
                      visible: message.isNotEmpty ? true : false,
                    ),
                    isMe
                        ? Positioned(
                            top: kSpacingZero,
                            right: kSpacingZero,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.blueBgColorBottom,
                                borderRadius:
                                    BorderRadius.circular(kRadiusMedium),
                              ),
                              padding: const EdgeInsets.all(kSpacingXSmall),
                              child: Container(
                                width: kSpacingMedium,
                                height: kSpacingMedium,
                                decoration: BoxDecoration(
                                  color: AppColors.black,
                                  borderRadius:
                                      BorderRadius.circular(kRadiusMedium),
                                ),
                              ),
                            ),
                          )
                        : Positioned(
                            top: 0,
                            left: kSpacingZero,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.black,
                                borderRadius:
                                    BorderRadius.circular(kRadiusMedium),
                              ),
                              padding: const EdgeInsets.all(kSpacingXSmall),
                              child: AppIcons.icBot(
                                width: kSpacingMedium,
                              ),
                            ),
                          )
                  ],
                ),
                Visibility(
                  visible: documentsImages.isNotEmpty ? true : false,
                  child: Container(
                    margin: const EdgeInsets.only(
                        left: kSpacingXLarge,
                        right: kSpacingXLarge,
                        top: kSpacingSmall),
                    decoration: BoxDecoration(
                      color: AppColors.blueBgColorBottom,
                      borderRadius: radius,
                    ),
                    child: SizedBox(
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: documentsImages.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (_, position) {
                            return Container(
                              color: Colors.transparent,
                              child: _getMedia(
                                url: documentsImages[position].url,
                                isImage: true,
                                isDownloaded:
                                    documentsImages[position].is_downloaded ??
                                        false,
                                index: index,
                                position: position,
                                name: documentsImages[position].url,
                              ),
                            );
                          }),
                    ),
                  ),
                ),
                Visibility(
                  visible: documentsFiles.isNotEmpty ? true : false,
                  child: Container(
                    margin: const EdgeInsets.only(
                        left: kSpacingXLarge,
                        right: kSpacingXLarge,
                        top: kSpacingSmall),
                    decoration: BoxDecoration(
                      color: AppColors.blueBgColorBottom,
                      borderRadius: radius,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(
                              vertical: kSpacingXxSmall,
                              horizontal: kSpacingXSmall,
                            ),
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: documentsFiles.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (_, position) {
                              return _getMedia(
                                url: documentsFiles[position].url,
                                isDownloaded:
                                    documentsFiles[position].is_downloaded ??
                                        false,
                                index: index,
                                position: position,
                                name: documentsFiles[position].url,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: kSpacingSmall,
            ),
          ],
        ),
      ],
    );
  }

  Widget _getMedia(
      {String? url,
      bool isImage = false,
      bool isDownloaded = false,
      String? name,
      required int index,
      required int position}) {
    return url != null && url.isNotEmpty
        ? url.getExtension() == '.pdf'
            ? InkWell(
                onTap: () {
                  /*state.openFile(
                url,
                isImage: isImage,
                index: index,
                position: position,
              );*/
                },
                child: Padding(
                  padding: const EdgeInsets.all(kSpacingMedium),
                  child: /*Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [*/
                      Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kSpacingSmall),
                        child: AppIcons.icFile(width: kSpacingLarge),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: kSpacingSmall, right: kSpacingXxSmall),
                        child: Text(
                          name != null
                              ? name.fileName().truncateFileName()
                              : 'file${position + 1}',
                          style: TextStyleFactory.styleNormal12(),
                        ),
                      ),
                    ],
                  ),
                  /*!isDownloaded
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(left: kSpacingMedium),
                              child: AppIcons.icDownloadCircular(
                                  width: kSpacingLarge),
                            )
                          : Container(),
                    ],
                  ),*/
                ),
              )
            : CustomImage.network(
                url,
                height: 150,
                width: 150,
                fit: BoxFit.scaleDown,
                errorWidget: Center(
                  child: AppIcons.icBsLogo(
                    color: AppColors.black,
                    height: kSpacingXLarge,
                    width: kSpacingXLarge,
                  ),
                ),
              )
        : Container();
  }
}
