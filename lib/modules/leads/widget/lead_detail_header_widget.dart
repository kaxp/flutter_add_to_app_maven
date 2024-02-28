import 'package:kapil_add_to_app_flutter/constants/radius_constants.dart';
import 'package:kapil_add_to_app_flutter/constants/spacing_constants.dart';
import 'package:kapil_add_to_app_flutter/modules/leads/models/launch_url.dart';
import 'package:kapil_add_to_app_flutter/modules/leads/models/lead_detail_response.dart';
import 'package:kapil_add_to_app_flutter/modules/leads/widget/lead_status_constants.dart';
import 'package:kapil_add_to_app_flutter/strings/app_strings.dart';
import 'package:kapil_add_to_app_flutter/theme/assets/app_colors.dart';
import 'package:kapil_add_to_app_flutter/theme/assets/app_icons.dart';
import 'package:kapil_add_to_app_flutter/theme/text_style_factory.dart';
import 'package:kapil_add_to_app_flutter/utils/extensions.dart';
import 'package:kapil_add_to_app_flutter/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';

class LeadDetailHeaderWidget extends StatelessWidget {
  final LeadDetailData? leadDetailData;

  const LeadDetailHeaderWidget({
    required this.leadDetailData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(
            kRadiusMedium,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(
          kSpacingMedium,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _BuildCardHeader(leadDetailData: leadDetailData),
            const SizedBox(
              height: kSpacingMedium,
            ),
            _BuildCardBody(leadDetailData: leadDetailData),
            const SizedBox(
              height: kSpacingMedium,
            ),
            _BuildCardFooter(leadDetailData: leadDetailData),
          ],
        ),
      ),
    );
  }
}

class _BuildCardHeader extends StatelessWidget {
  const _BuildCardHeader({
    required this.leadDetailData,
  });

  final LeadDetailData? leadDetailData;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        CustomImage.network(
          leadDetailData?.productLogo ?? '',
          height: kSpacingXxLarge,
          width: kSpacingXxLarge,
          fit: BoxFit.fill,
          errorWidget: Center(
            child: AppIcons.icBsLogo(
              height: kSpacingLarge,
              width: kSpacingLarge,
            ),
          ),
        ),
        const SizedBox(
          width: kSpacingMedium,
        ),
        Expanded(
          child: Text(
            leadDetailData?.productTitle ?? '',
            style: TextStyleFactory.styleBold16(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

class _BuildCardBody extends StatelessWidget {
  const _BuildCardBody({required this.leadDetailData});

  final LeadDetailData? leadDetailData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: kSpacingSmall, horizontal: kSpacingMedium),
      decoration: const BoxDecoration(
        color: AppColors.greyColor,
        borderRadius: BorderRadius.all(
          Radius.circular(
            kRadiusSmall,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                AppStrings.information,
                style: TextStyleFactory.styleNormal18(
                    fontFamily: AppFonts.dmSans, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                width: kSpacingSmall,
              ),
              Text(
                leadDetailData?.created_at ?? '',
                style: TextStyleFactory.styleBold14(
                    fontFamily: AppFonts.dmSans, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(
            height: kSpacingXMedium,
          ),
          _BuildLeadStatus(leadDetailData: leadDetailData),
          const SizedBox(
            height: kSpacingSmall,
          ),
          _BuildCustomerOption(leadDetailData: leadDetailData),
        ],
      ),
    );
  }
}

class _BuildLeadStatus extends StatelessWidget {
  const _BuildLeadStatus({required this.leadDetailData});

  final LeadDetailData? leadDetailData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
          horizontal: kSpacingSmall, vertical: kSpacingMedium),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(
              kRadiusSmall,
            ),
          ),
          color: leadDetailData?.leadStatusId ==
                  LeadStatusConstants.actionLeadStatus
              ? AppColors.skyBlueBgColorActionRequired
              : leadDetailData?.leadStatusId ==
                      LeadStatusConstants.successLeadStatus
                  ? AppColors.greenBgColorSuccess
                  : leadDetailData?.leadStatusId ==
                          LeadStatusConstants.pendingLeadStatus
                      ? AppColors.yellowBgColorPending
                      : AppColors.redBgColorExpired),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          leadDetailData?.leadStatusId == LeadStatusConstants.expiredLeadStatus
              ? AppIcons.icClearSolid(
                  width: kSpacingMedium, color: AppColors.redTextColorExpired)
              : leadDetailData?.leadStatusId ==
                      LeadStatusConstants.successLeadStatus
                  ? AppIcons.icCheckSolid(
                      width: kSpacingMedium,
                      color: AppColors.greenTextColorSuccess)
                  : leadDetailData?.leadStatusId ==
                          LeadStatusConstants.pendingLeadStatus
                      ? AppIcons.icInfo(
                          width: kSpacingMedium,
                          color: AppColors.yellowTextColorPending)
                      : AppIcons.icAlert(
                          width: kSpacingMedium,
                          color: AppColors.skyBlueTextColorActionRequired),
          const SizedBox(
            width: kSpacingXSmall,
          ),
          Text(
            leadDetailData?.leadStatus ?? '',
            style: TextStyleFactory.styleBold14(
              fontFamily: AppFonts.dmSans,
              color: leadDetailData?.leadStatusId ==
                      LeadStatusConstants.actionLeadStatus
                  ? AppColors.skyBlueTextColorActionRequired
                  : leadDetailData?.leadStatusId ==
                          LeadStatusConstants.successLeadStatus
                      ? AppColors.greenTextColorSuccess
                      : leadDetailData?.leadStatusId ==
                              LeadStatusConstants.pendingLeadStatus
                          ? AppColors.yellowTextColorPending
                          : AppColors.redTextColorExpired,
            ),
          ),
        ],
      ),
    );
  }
}

class _BuildCustomerOption extends StatelessWidget {
  const _BuildCustomerOption({required this.leadDetailData});

  final LeadDetailData? leadDetailData;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Card(
            margin: EdgeInsets.zero,
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.all(kSpacingMedium),
              child: Text(
                (leadDetailData?.costomer_name ?? 'C')
                    .toString()[0]
                    .toUpperCase(),
                style: TextStyleFactory.styleBold20(
                    fontFamily: AppFonts.dmSans, color: AppColors.white),
              ),
            ),
            color: AppColors.black),
        const SizedBox(
          width: kSpacingSmall,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                leadDetailData?.costomer_name ?? 'Customer',
                style: TextStyleFactory.styleNormal16(
                  fontFamily: AppFonts.dmSans,
                ),
              ),
              Text(
                (leadDetailData?.mobile_no ?? 'N/A').toString(),
                style: TextStyleFactory.styleBold14(
                  fontFamily: AppFonts.dmSans,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            final String url =
                'tel:+91${leadDetailData?.mobile_no.toString().toCorrectMobileNo()}';
            launchURL(
              url,
              allowExternal: true,
            );
          },
          child: AppIcons.icCall(),
        ),
        const SizedBox(
          width: kSpacingSmall,
        ),
        InkWell(
          onTap: () {
            final String url =
                'https://wa.me/+91${leadDetailData?.mobile_no.toString().toCorrectMobileNo()}?text=${leadDetailData?.leadRemark}';
            launchURL(
              url,
              allowExternal: true,
            );
          },
          child: AppIcons.icWhatsapp(),
        ),
      ],
    );
  }
}

class _BuildCardFooter extends StatelessWidget {
  const _BuildCardFooter({required this.leadDetailData});

  final LeadDetailData? leadDetailData;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(children: [
        TextSpan(
          text: 'Remark : ',
          style: TextStyleFactory.styleBold14(
            fontFamily: AppFonts.dmSans,
          ),
        ),
        TextSpan(
          text: leadDetailData?.leadRemark ?? '',
          style: TextStyleFactory.styleNormal14(
            fontFamily: AppFonts.dmSans,
          ),
        ),
      ]),
    );
  }
}
