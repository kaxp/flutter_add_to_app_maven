import 'package:kapil_add_to_app_flutter/constants/spacing_constants.dart';
import 'package:kapil_add_to_app_flutter/injection_container.dart';
import 'package:kapil_add_to_app_flutter/modules/leads/blocs/leads_listing_bloc.dart';
import 'package:kapil_add_to_app_flutter/modules/leads/widget/lead_balance_widget.dart';
import 'package:kapil_add_to_app_flutter/modules/leads/widget/leads_list_widget.dart';
import 'package:kapil_add_to_app_flutter/strings/app_strings.dart';
import 'package:kapil_add_to_app_flutter/theme/assets/app_colors.dart';
import 'package:kapil_add_to_app_flutter/theme/assets/app_icons.dart';
import 'package:kapil_add_to_app_flutter/widgets/custom_appbar.dart';
import 'package:kapil_add_to_app_flutter/widgets/custom_loader.dart';
import 'package:kapil_add_to_app_flutter/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LeadsListingPage extends StatefulWidget {
  const LeadsListingPage({super.key});

  @override
  State<LeadsListingPage> createState() => _LeadsListingPageState();
}

class _LeadsListingPageState extends State<LeadsListingPage> {
  final _bloc = sl.get<LeadsListingBloc>();
  int currentPage = 1;
  int? leadStatusId;

  @override
  void initState() {
    super.initState();
    _bloc.getInitialLeads(currentPage, leadParentId: leadStatusId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LeadsListingBloc, LeadsListingState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is LeadsListingError) {
          SnackBar(
            content: Text(state.message),
          );
          // do something
          // navigation
          // perform actions
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.greyBackgroundColor,
          appBar: CustomAppBar(
            leading: IconButton(
              onPressed: () {},
              icon: AppIcons.icBackArrow(
                width: kSpacingLarge,
              ),
            ),
            backgroundColor: AppColors.greyBackgroundColor,
            title: Text(
              AppStrings.leads,
            ),
          ),
          body: CustomLoader(
            isLoading:
                state is LeadsListingInitial || state is LeadsListingLoading,
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo is ScrollEndNotification &&
                    scrollInfo.metrics.extentAfter == 0) {
                  int? lastPage = state.leadListingData?.leads?.last_page;
                  if (lastPage != null && lastPage > currentPage) {
                    currentPage++;
                    _bloc.getMoreLeads(currentPage, leadParentId: leadStatusId);
                  }
                  return true;
                }
                return false;
              },
              child: Stack(
                children: [
                  ListView(
                    padding: const EdgeInsets.symmetric(
                      vertical: kSpacingXxSmall,
                    ),
                    shrinkWrap: true,
                    children: [
                      LeadBalanceWidget(
                        leadListingData: state.leadListingData,
                        leadStatusId: leadStatusId,
                        onCategoryFilter: (key) {
                          leadStatusId = key == 0 ? null : key;
                          currentPage = 1;
                          _bloc.getFilterLeads(currentPage,
                              leadParentId: leadStatusId);
                        },
                      ),
                      const SizedBox(height: kSpacingSmall),
                      state is LeadsListingEmpty
                          ? const EmptyWidget()
                          : Stack(
                              children: [
                                Opacity(
                                  opacity:
                                      state is LeadsListingFilter ? 0.4 : 1.0,
                                  child: LeadsListWidget(
                                    leadListingData: state.leadListingData,
                                  ),
                                ),
                                state is LeadsListingFilter
                                    ? Center(
                                        child: AppIcons.loadingGif(),
                                      )
                                    : const SizedBox.shrink(),
                              ],
                            ),
                    ],
                  ),
                  Visibility(
                    visible: state is LeadsListingLoadMore,
                    child: const Align(
                      alignment: Alignment.bottomCenter,
                      child: CircularProgressIndicator(
                        color: AppColors.buttonPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
