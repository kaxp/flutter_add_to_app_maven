import 'package:kapil_add_to_app_flutter/constants/radius_constants.dart';
import 'package:kapil_add_to_app_flutter/constants/spacing_constants.dart';
import 'package:kapil_add_to_app_flutter/modules/leads/models/lead_listing_response.dart';
import 'package:kapil_add_to_app_flutter/modules/leads/widget/lead_status_constants.dart';
import 'package:kapil_add_to_app_flutter/strings/app_strings.dart';
import 'package:kapil_add_to_app_flutter/theme/assets/app_colors.dart';
import 'package:kapil_add_to_app_flutter/theme/assets/app_icons.dart';
import 'package:kapil_add_to_app_flutter/theme/text_style_factory.dart';
import 'package:flutter/material.dart';

typedef OnCategoryFilter = Function(int status);

class LeadBalanceWidget extends StatelessWidget {
  final LeadListingData? leadListingData;
  final OnCategoryFilter onCategoryFilter;
  final int? leadStatusId;

  const LeadBalanceWidget({
    super.key,
    this.leadListingData,
    required this.onCategoryFilter,
    this.leadStatusId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        left: kSpacingMedium,
        right: kSpacingMedium,
        top: kSpacingZero,
        bottom: kSpacingXSmall,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(
            kRadiusXMedium,
          ),
        ),
        color: AppColors.pageBackgroundColor,
      ),
      padding: const EdgeInsets.all(
        kSpacingMedium,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _BuildHeader(
            leadListingData: leadListingData,
            leadStatusId: leadStatusId,
            onCategoryTap: (key) {
              onCategoryFilter(key);
            },
          ),
          const SizedBox(
            height: kSpacingLarge,
          ),
          _BuildFooter(
            leadListingData: leadListingData,
            leadStatusId: leadStatusId,
            onCategoryTap: (key) {
              onCategoryFilter(key);
            },
          ),
          const SizedBox(
            height: kSpacingXxSmall,
          ),
        ],
      ),
    );
  }
}

class _BuildHeader extends StatelessWidget {
  const _BuildHeader({
    required this.leadListingData,
    required this.onCategoryTap,
    required this.leadStatusId,
  });

  final LeadListingData? leadListingData;
  final int? leadStatusId;
  final OnCategoryFilter onCategoryTap;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      CircleAvatar(
        child: AppIcons.icTotalLeads(width: kSpacingXLarge),
        radius: kRadiusXMedium,
        backgroundColor: AppColors.buttonPrimaryColor,
      ),
      const SizedBox(
        width: kSpacingSmall,
      ),
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.totalLeads,
              style: TextStyleFactory.styleBold14(),
            ),
            Text(
              AppStrings.totalLeadsDesc,
              style:
                  TextStyleFactory.styleNormal12(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      const SizedBox(
        width: kSpacingSmall,
      ),
      InkWell(
        onTap: () {
          onCategoryTap(0);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: kSpacingSmall, vertical: kSpacingXxSmall),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(
                kRadiusSmall,
              ),
            ),
            border: Border.all(
              color: leadStatusId == null
                  ? AppColors.buttonPrimaryColor
                  : AppColors.white,
            ),
          ),
          child: Column(
            children: [
              Text(
                (leadListingData?.totalLeads ?? '').toString(),
                style: TextStyleFactory.styleBold14(
                  fontFamily: AppFonts.dmSans,
                ),
              ),
              Text(
                AppStrings.allLeads,
                style: TextStyleFactory.styleNormal12(),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}

class _BuildFooter extends StatelessWidget {
  const _BuildFooter({
    required this.leadListingData,
    required this.onCategoryTap,
    required this.leadStatusId,
  });

  final OnCategoryFilter onCategoryTap;
  final int? leadStatusId;

  final LeadListingData? leadListingData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          LeadStatusConstants.successLeadStatus,
          LeadStatusConstants.pendingLeadStatus,
          LeadStatusConstants.actionLeadStatus,
          LeadStatusConstants.expiredLeadStatus
        ]
            .map(
              (e) => e.toString() != ''
                  ? InkWell(
                      onTap: () {
                        onCategoryTap(e);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kSpacingXxSmall,
                            vertical: kSpacingXxSmall),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(
                              kRadiusSmall,
                            ),
                          ),
                          border: Border.all(
                            color: e == leadStatusId
                                ? AppColors.buttonPrimaryColor
                                : AppColors.pageBackgroundColor,
                          ),
                        ),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 5.5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                (e == LeadStatusConstants.successLeadStatus
                                        ? leadListingData?.completedLeads ?? ''
                                        : e ==
                                                LeadStatusConstants
                                                    .pendingLeadStatus
                                            ? leadListingData?.inprocessLeads ??
                                                ''
                                            : e ==
                                                    LeadStatusConstants
                                                        .actionLeadStatus
                                                ? leadListingData
                                                        ?.actionrequiredLeads ??
                                                    ''
                                                : leadListingData
                                                        ?.rejectedLeads ??
                                                    '')
                                    .toString(),
                                style: TextStyleFactory.styleBold20(
                                  fontFamily: AppFonts.dmSans,
                                ),
                              ),
                              Text(
                                e == LeadStatusConstants.successLeadStatus
                                    ? AppStrings.success
                                    : e == LeadStatusConstants.pendingLeadStatus
                                        ? AppStrings.pending
                                        : e ==
                                                LeadStatusConstants
                                                    .actionLeadStatus
                                            ? AppStrings.actionRequired
                                            : AppStrings.rejected,
                                style: TextStyleFactory.styleNormal12(
                                  fontFamily: AppFonts.dmSans,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(),
            )
            .toList(),
      ),
    );
  }
}
