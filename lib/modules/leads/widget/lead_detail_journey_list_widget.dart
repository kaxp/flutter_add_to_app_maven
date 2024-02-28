import 'package:kapil_add_to_app_flutter/constants/radius_constants.dart';
import 'package:kapil_add_to_app_flutter/constants/spacing_constants.dart';
import 'package:kapil_add_to_app_flutter/modules/leads/models/lead_detail_response.dart';
import 'package:kapil_add_to_app_flutter/modules/leads/pages/add_query_screen.dart';
import 'package:kapil_add_to_app_flutter/modules/leads/pages/lead_queries_page.dart';
import 'package:kapil_add_to_app_flutter/modules/leads/widget/lead_status_constants.dart';
import 'package:kapil_add_to_app_flutter/strings/app_strings.dart';
import 'package:kapil_add_to_app_flutter/theme/assets/app_colors.dart';
import 'package:kapil_add_to_app_flutter/theme/assets/app_icons.dart';
import 'package:kapil_add_to_app_flutter/theme/text_style_factory.dart';
import 'package:kapil_add_to_app_flutter/widgets/dotted_line.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class LeadDetailJourneyListWidget extends StatelessWidget {
  final LeadDetailData? leadDetailData;

  const LeadDetailJourneyListWidget({required this.leadDetailData, super.key});

  @override
  Widget build(BuildContext context) {
    int journeyListLength =
        leadDetailData != null ? leadDetailData!.journey.length : 0;
    List<JourneyObj> journeyList =
        leadDetailData != null ? leadDetailData!.journey : [];
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: journeyListLength + 1,
        itemBuilder: (context, position) {
          return position == journeyListLength
              ? const SizedBox(height: kSpacingXxSmall)
              : ListItem(context, journeyList[position],
                  position == journeyList.length - 1, position == 0);
        });
  }

  Widget ListItem(BuildContext context, JourneyObj journeyObj, bool isLastItem,
      bool isFirstItem) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(kRadiusMedium),
            ),
          ),
          margin: const EdgeInsets.only(
            left: kSpacingXLarge,
            bottom: kSpacingMedium,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: kSpacingMedium,
            horizontal: kSpacingXMedium,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      journeyObj.lead_status_title ?? '',
                      style: TextStyleFactory.styleBold16(
                          fontFamily: AppFonts.dmSans,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(
                    width: kSpacingSmall,
                  ),
                  Text(
                    journeyObj.updated_at ?? '',
                    style: TextStyleFactory.styleBold14(
                        fontFamily: AppFonts.dmSans,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(
                height: kSpacingXxSmall,
              ),
              Visibility(
                visible: (journeyObj.lead_sub_status ?? '').isNotEmpty,
                child: Text(
                  journeyObj.lead_sub_status ?? '',
                  style: TextStyleFactory.styleNormal14(
                      fontFamily: AppFonts.dmSans,
                      color: AppColors.greySubtitleColor),
                ),
              ),
              Text(
                journeyObj.lead_sub_remark ?? '',
                style: TextStyleFactory.styleNormal14(
                    fontFamily: AppFonts.dmSans,
                    color: AppColors.greyLightSubtitleColor),
              ),
              Visibility(
                visible: leadDetailData?.isDisputeVisible ?? false,
                child: leadDetailData?.leadStatusId ==
                        LeadStatusConstants.expiredLeadStatus
                    ? isLastItem
                        ? InkWell(
                            onTap: () {
                              if (leadDetailData!.isQueryActive == true) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LeadsQueriesPage(
                                      leadID: leadDetailData!.leadId!,
                                    ),
                                  ),
                                );
                              } else {
                                showModalBottomSheet(
                                  elevation: 10,
                                  backgroundColor: Colors.amber,
                                  context: context,
                                  builder: (ctx) => AddQueryScreen(
                                    leadID: leadDetailData!.leadId!,
                                  ),
                                );
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                top: kSpacingSmall,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: kSpacingMedium,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(kRadiusSmall),
                                ),
                                border: Border.all(
                                    color: AppColors.black, width: kSpacingOne),
                              ),
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                visualDensity:
                                    const VisualDensity(vertical: -3),
                                leading: SizedBox(
                                  width: kSpacingLarge,
                                  height: kSpacingLarge,
                                  child: AppIcons.icRaiseQuery(),
                                ),
                                subtitle: Text(
                                  leadDetailData?.isQuery == false
                                      ? AppStrings.startHere
                                      : AppStrings.checkStatus,
                                  style: TextStyleFactory.styleBold12(
                                      fontFamily: AppFonts.dmSans,
                                      color: AppColors.skyBlueDarkColor,
                                      fontWeight: FontWeight.w600),
                                ),
                                title: Text(
                                  leadDetailData?.isQuery == false
                                      ? AppStrings.raiseDispute
                                      : AppStrings.trackYourQuery,
                                  style: TextStyleFactory.styleBold14(
                                      fontFamily: AppFonts.dmSans,
                                      fontWeight: FontWeight.w700),
                                ),
                                trailing:
                                    AppIcons.icLeadsArrow(width: kSpacingLarge),
                              ),
                            ),
                          )
                        : const SizedBox()
                    : const SizedBox(),
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: kSpacingLarge,
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: DottedLine(
                      direction: Axis.vertical,
                      lineThickness: 2,
                      dashGapLength: 5.0,
                      dashColor: isFirstItem
                          ? AppColors.greyBackgroundColor
                          : AppColors.black,
                    ),
                  ),
                  isLastItem
                      ? Transform.translate(
                          offset: const Offset(0, 0),
                          child: AvatarGlow(
                            glowColor: AppColors.black,
                            animate: true,
                            child: Material(
                              elevation: 0,
                              shape: const CircleBorder(),
                              child: Container(
                                width: kSpacingMedium,
                                height: kSpacingMedium,
                                decoration: const BoxDecoration(
                                  color: AppColors.black,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      kSpacingXLarge,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(
                          width: kSpacingMedium,
                          height: kSpacingMedium,
                          decoration: const BoxDecoration(
                            color: AppColors.black,
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                kSpacingLarge,
                              ),
                            ),
                          ),
                        ),
                  Expanded(
                    flex: 3,
                    child: DottedLine(
                      direction: Axis.vertical,
                      lineThickness: 2,
                      dashGapLength: 5.0,
                      dashColor: isLastItem
                          ? AppColors.greyBackgroundColor
                          : AppColors.buttonPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
