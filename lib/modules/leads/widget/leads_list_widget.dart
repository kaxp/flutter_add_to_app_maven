import 'package:kapil_add_to_app_flutter/constants/radius_constants.dart';
import 'package:kapil_add_to_app_flutter/constants/spacing_constants.dart';
import 'package:kapil_add_to_app_flutter/modules/leads/models/lead_listing_response.dart';
import 'package:kapil_add_to_app_flutter/modules/leads/pages/leads_detail_page.dart';
import 'package:kapil_add_to_app_flutter/modules/leads/widget/lead_info_bottom_sheet.dart';
import 'package:kapil_add_to_app_flutter/modules/leads/widget/lead_status_constants.dart';
import 'package:kapil_add_to_app_flutter/strings/app_strings.dart';
import 'package:kapil_add_to_app_flutter/theme/assets/app_colors.dart';
import 'package:kapil_add_to_app_flutter/theme/assets/app_icons.dart';
import 'package:kapil_add_to_app_flutter/theme/text_style_factory.dart';
import 'package:kapil_add_to_app_flutter/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LeadsListWidget extends StatelessWidget {
  final LeadListingData? leadListingData;

  const LeadsListWidget({
    super.key,
    this.leadListingData,
  });

  @override
  Widget build(BuildContext context) {
    final List<Lead>? leads = leadListingData?.leads?.data;

    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        horizontal: kSpacingMedium,
      ),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: leads != null ? leads.length : 0,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LeadDetailPage(
                  leadID: leads[index].leadId!.toInt(),
                ),
              ),
            );
          },
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.pageBackgroundColor,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  kRadiusXMedium,
                ),
              ),
            ),
            margin: EdgeInsets.only(
              bottom: index == leads!.length - 1 ? kSpacingSmall : kSpacingZero,
            ),
            child: Padding(
              padding: const EdgeInsets.all(
                kSpacingMedium,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  _BuildCardHeader(lead: leads[index]),
                  const SizedBox(
                    height: kSpacingMedium,
                  ),
                  _BuildCardBody(lead: leads[index]),
                  const SizedBox(
                    height: kSpacingMedium,
                  ),
                  _BuildCardFooter(lead: leads[index]),
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: kSpacingMedium,
      ),
    );
  }
}

class _BuildCardHeader extends StatelessWidget {
  const _BuildCardHeader({
    required this.lead,
  });

  final Lead? lead;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          child: CustomImage.network(
            lead?.productLogo ?? '',
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
        ),
        const SizedBox(
          width: kSpacingSmall,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                lead?.productTitle ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyleFactory.styleBold14(),
              ),
              Text(
                (lead?.mobileNo ?? '').toString(),
                style: TextStyleFactory.styleNormal12(),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                _showInfo(context, lead!);
              },
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(children: [
                  TextSpan(
                    text: AppStrings.createdAtQ,
                    style: TextStyleFactory.styleNormal10(),
                  ),
                  WidgetSpan(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kSpacingXxSmall),
                      child: AppIcons.icInfo(
                          color: AppColors.black, width: kSpacingSmall),
                    ),
                  ),
                ]),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              lead?.createdAt?.split(' ')[0] ?? '',
              style:
                  TextStyleFactory.styleNormal12(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ],
    );
  }
}

class _BuildCardBody extends StatelessWidget {
  const _BuildCardBody({this.lead});

  final Lead? lead;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: kSpacingSmall,
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(
            kRadiusSmall,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.only(left: kSpacingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  InkWell(
                    onTap: () {
                      _showInfo(context, lead!);
                    },
                    child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(children: [
                        TextSpan(
                          text: AppStrings.lastUpdate,
                          style: TextStyleFactory.styleNormal10(),
                        ),
                        WidgetSpan(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kSpacingXxSmall),
                            child: AppIcons.icInfo(
                                color: AppColors.black, width: kSpacingSmall),
                          ),
                        ),
                      ]),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    lead?.lastUpdatedDate?.split(' ')[0] ?? '',
                    style: TextStyleFactory.styleBold12(),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: kSpacingMedium),
            width: kSpacingOne,
            height: kSpacingXLarge,
            color: AppColors.borderColor,
          ),
          lead?.isDisputeVisible ?? false
              ? Expanded(
                  flex: 9,
                  child: InkWell(
                    onTap: () {
                      _showInfo(context, lead!);
                    },
                    child: Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lead?.isQuery == false ||
                                        (lead?.isQueryActive ?? false) == false
                                    ? AppStrings.haveIssue
                                    : AppStrings.trackYourQuery,
                                style: TextStyleFactory.styleBold14(),
                              ),
                              Text(
                                lead?.isQuery == false ||
                                        (lead?.isQueryActive ?? false) == false
                                    ? AppStrings.raiseQuery
                                    : AppStrings.checkStatus,
                                style: TextStyleFactory.styleNormal12(
                                  fontFamily: AppFonts.dmSans,
                                ),
                              ),
                            ],
                          ),
                          SvgPicture.asset(
                            'assets/icons/ic_leads_arrow.svg',
                            width: 23,
                            height: 23,
                            colorFilter: const ColorFilter.mode(
                              AppColors.buttonPrimaryColor,
                              BlendMode.srcIn,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(left: kSpacingMedium),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        InkWell(
                          onTap: () {
                            _showInfo(context, lead!);
                          },
                          child: RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(children: [
                              TextSpan(
                                text: AppStrings.nextUpdate,
                                style: TextStyleFactory.styleNormal10(),
                              ),
                              WidgetSpan(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: kSpacingXxSmall),
                                  child: AppIcons.icInfo(
                                      color: AppColors.black,
                                      width: kSpacingSmall),
                                ),
                              ),
                            ]),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          lead?.nextUpdate?.split(' ')[0] ?? '',
                          style: TextStyleFactory.styleBold12(),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

void _showInfo(BuildContext ctx, Lead lead) {
  showModalBottomSheet(
    elevation: 10,
    backgroundColor: Colors.amber,
    context: ctx,
    builder: (ctx) => LeadInfoBottomSheet(lead: lead),
  );
}

class _BuildCardFooter extends StatelessWidget {
  const _BuildCardFooter({this.lead});

  final Lead? lead;

  @override
  Widget build(BuildContext context) {
    final status =
        lead?.leadStatusParentId ?? LeadStatusConstants.pendingLeadStatus;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
          horizontal: kSpacingSmall, vertical: kSpacingSmall),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(
            kRadiusSmall,
          ),
        ),
        color: status == LeadStatusConstants.expiredLeadStatus
            ? AppColors.redBgColorExpired
            : status == LeadStatusConstants.successLeadStatus
                ? AppColors.greenBgColorSuccess
                : status == LeadStatusConstants.pendingLeadStatus
                    ? AppColors.yellowBgColorPending
                    : AppColors.skyBlueBgColorActionRequired,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            lead?.leadStatus ?? '',
            style: TextStyleFactory.styleBold14(
              fontFamily: AppFonts.dmSans,
              color: status == LeadStatusConstants.expiredLeadStatus
                  ? AppColors.redTextColorExpired
                  : status == LeadStatusConstants.successLeadStatus
                      ? AppColors.greenTextColorSuccess
                      : status == LeadStatusConstants.pendingLeadStatus
                          ? AppColors.yellowTextColorPending
                          : AppColors.skyBlueTextColorActionRequired,
            ),
          ),
          Text(
            lead?.leadRemark ?? '',
            style: TextStyleFactory.styleNormal11(),
          ),
        ],
      ),
    );
  }
}
