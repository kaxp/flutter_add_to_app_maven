import 'package:kapil_add_to_app_flutter/constants/radius_constants.dart';
import 'package:kapil_add_to_app_flutter/constants/spacing_constants.dart';
import 'package:kapil_add_to_app_flutter/injection_container.dart';
import 'package:kapil_add_to_app_flutter/modules/leads/blocs/lead_detail_bloc.dart';
import 'package:kapil_add_to_app_flutter/modules/leads/widget/lead_detail_header_widget.dart';
import 'package:kapil_add_to_app_flutter/modules/leads/widget/lead_detail_journey_list_widget.dart';
import 'package:kapil_add_to_app_flutter/strings/app_strings.dart';
import 'package:kapil_add_to_app_flutter/theme/assets/app_colors.dart';
import 'package:kapil_add_to_app_flutter/theme/assets/app_icons.dart';
import 'package:kapil_add_to_app_flutter/theme/text_style_factory.dart';
import 'package:kapil_add_to_app_flutter/widgets/custom_appbar.dart';
import 'package:kapil_add_to_app_flutter/widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LeadDetailPage extends StatefulWidget {
  final int leadID;

  const LeadDetailPage({super.key, required this.leadID});

  @override
  State<LeadDetailPage> createState() => _LeadDetailPageState();
}

class _LeadDetailPageState extends State<LeadDetailPage> {
  final _bloc = sl.get<LeadDetailBloc>();

  @override
  void initState() {
    super.initState();
    _bloc.getLeadDetails(widget.leadID);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LeadDetailBloc, LeadDetailState>(
      bloc: _bloc,
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.greyBackgroundColor,
          appBar: CustomAppBar(
            title: Text(
              AppStrings.lead + ' ID : ' + widget.leadID.toString(),
            ),
          ),
          body: CustomLoader(
            isLoading: state is LeadDetailInitial || state is LeadDetailLoading,
            child: ListView(
              padding: const EdgeInsets.symmetric(
                  vertical: kSpacingMedium, horizontal: kSpacingMedium),
              shrinkWrap: true,
              children: [
                LeadDetailHeaderWidget(leadDetailData: state.leadDetailData),
                const SizedBox(
                  height: kSpacingMedium,
                ),
                const _BuildDisclaimerView(),
                const SizedBox(
                  height: kSpacingMedium,
                ),
                const _LeadStatusView(),
                const SizedBox(
                  height: kSpacingMedium,
                ),
                LeadDetailJourneyListWidget(
                    leadDetailData: state.leadDetailData)
              ],
            ),
          ),
        );
      },
    );
  }
}

class _BuildDisclaimerView extends StatelessWidget {
  const _BuildDisclaimerView();

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
        child: RichText(
          textAlign: TextAlign.start,
          text: TextSpan(children: [
            TextSpan(
              text: '${AppStrings.disclaimer} : ',
              style: TextStyleFactory.styleBold14(
                  fontFamily: AppFonts.dmSans, color: AppColors.blueTextColor),
            ),
            TextSpan(
              text: AppStrings.disclaimerDesc,
              style: TextStyleFactory.styleNormal14(
                fontFamily: AppFonts.dmSans,
                color: AppColors.blueTextColor,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class _LeadStatusView extends StatelessWidget {
  const _LeadStatusView();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Lead Status : ',
          style: TextStyleFactory.styleNormal18(
              fontFamily: AppFonts.dmSans, fontWeight: FontWeight.w700),
        ),
        AppIcons.icInfo()
      ],
    );
  }
}
