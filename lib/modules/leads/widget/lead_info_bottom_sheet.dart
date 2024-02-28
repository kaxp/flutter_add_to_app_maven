import 'package:kapil_add_to_app_flutter/constants/radius_constants.dart';
import 'package:kapil_add_to_app_flutter/constants/spacing_constants.dart';
import 'package:kapil_add_to_app_flutter/modules/leads/models/lead_listing_response.dart';
import 'package:kapil_add_to_app_flutter/modules/leads/pages/lead_queries_page.dart';
import 'package:kapil_add_to_app_flutter/modules/leads/pages/add_query_screen.dart';
import 'package:kapil_add_to_app_flutter/strings/app_strings.dart';
import 'package:kapil_add_to_app_flutter/theme/assets/app_colors.dart';
import 'package:kapil_add_to_app_flutter/theme/assets/app_icons.dart';
import 'package:kapil_add_to_app_flutter/theme/text_style_factory.dart';
import 'package:kapil_add_to_app_flutter/widgets/dotted_line.dart';
import 'package:flutter/material.dart';

class LeadInfoBottomSheet extends StatelessWidget {
  final Lead lead;

  const LeadInfoBottomSheet({required this.lead, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.bottomSheetHeaderBgColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(kRadiusXMedium),
          topRight: Radius.circular(kRadiusXMedium),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kSpacingLarge, vertical: kSpacingMedium),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: '${AppStrings.disclaimer} : ',
                          style: TextStyleFactory.styleBold14(
                            color: AppColors.white,
                          ),
                        ),
                        TextSpan(
                          text: AppStrings.disclaimerDesc,
                          style: TextStyleFactory.styleNormal14(
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: kSpacingXSmall,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: AppIcons.icClearSolid(
                      width: kSpacingMedium, color: AppColors.white),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(kSpacingXMedium),
                    topRight: Radius.circular(kSpacingXMedium))),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kSpacingSmall, vertical: kSpacingXxSmall),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _statusTile(1, lead, context),
                  _statusTile(2, lead, context),
                  if (lead.nextUpdate != null) _statusTile(3, lead, context),
                  if (lead.isDisputeVisible ?? false)
                    _statusTile(4, lead, context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusTile(int type, Lead lead, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacingSmall),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: kSpacingXxLarge),
            padding: const EdgeInsets.only(
                left: kSpacingLarge, top: kSpacingSmall, bottom: kSpacingSmall),
            child: type == 4
                ? Row(
                    children: [
                      InkWell(
                        onTap: () {
                          if (lead.isQuery == false ||
                              (lead.isQueryActive ?? false) == false) {
                            showModalBottomSheet(
                              context: context,
                              clipBehavior: Clip.hardEdge,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(kRadiusXMedium),
                                  topRight: Radius.circular(kRadiusXMedium),
                                ),
                              ),
                              builder: (ctx) => AddQueryScreen(
                                leadID: lead.leadId ?? 0,
                              ),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LeadsQueriesPage(
                                  leadID: lead.leadId!,
                                ),
                              ),
                            );
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kSpacingXMedium,
                              vertical: kSpacingXSmall),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(kSpacingSmall),
                            ),
                            border: Border.all(
                                color: AppColors.black, width: kSpacingOne),
                          ),
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  lead.isQuery == false ||
                                          (lead.isQueryActive ?? false) == false
                                      ? AppStrings.haveIssue
                                      : AppStrings.trackYourQuery,
                                  style: TextStyleFactory.styleBold14(
                                    fontFamily: AppFonts.dmSans,
                                  ),
                                ),
                                Text(
                                  AppStrings.raiseQuery,
                                  style: TextStyleFactory.styleBold12(
                                    color: AppColors.skyBlueDarkColor,
                                    fontFamily: AppFonts.dmSans,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: kSpacingXxLarge,
                            ),
                            AppIcons.icLeadsArrow(width: kSpacingXLarge),
                          ]),
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        type == 1
                            ? AppStrings.createdAt
                            : type == 2
                                ? AppStrings.lastUpdate
                                : AppStrings.nextUpdate,
                        style: TextStyleFactory.styleBold16(
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        type == 1
                            ? lead.createdDateSubTitle.toString()
                            : type == 2
                                ? lead.lastUpdatedDateSubTitle.toString()
                                : lead.nextUpdateSubTitle.toString(),
                        style: TextStyleFactory.styleNormal12(),
                      ),
                    ],
                  ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: kSpacingXxLarge,
                child: Column(
                  children: [
                    Expanded(
                      child: DottedLine(
                        direction: Axis.vertical,
                        lineThickness: kSpacingOne,
                        dashRadius: 1,
                        dashGapLength: kSpacingOne,
                        dashColor: type == 1
                            ? AppColors.white
                            : AppColors.greyBorderColor,
                      ),
                    ),
                    Container(
                      width: kSpacingXxLarge,
                      height: kSpacingXxLarge,
                      padding: const EdgeInsets.all(kSpacingXSmall),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(kSpacingXMedium),
                        ),
                        border: Border.all(
                          color: type == 1
                              ? AppColors.greenBorderColor
                              : AppColors
                                  .greyBorderColor, // red as border color
                        ),
                      ),
                      child: type == 1
                          ? AppIcons.icCheckSolid(
                              color: AppColors.greenTextColorSuccess)
                          : type == 2 || type == 3
                              ? AppIcons.icArrowTilt()
                              : AppIcons.icAlert(
                                  color: AppColors.redTextColorExpired),
                    ),
                    Expanded(
                      child: DottedLine(
                        direction: Axis.vertical,
                        lineThickness: kSpacingOne,
                        dashRadius: 1,
                        dashGapLength: kSpacingOne,
                        dashColor: type == 4
                            ? AppColors.white
                            : AppColors.greyBorderColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
