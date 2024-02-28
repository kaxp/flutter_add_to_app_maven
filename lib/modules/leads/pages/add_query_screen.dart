import 'package:kapil_add_to_app_flutter/constants/radius_constants.dart';
import 'package:kapil_add_to_app_flutter/constants/spacing_constants.dart';
import 'package:kapil_add_to_app_flutter/injection_container.dart';
import 'package:kapil_add_to_app_flutter/modules/leads/blocs/add_query_bloc.dart';
import 'package:kapil_add_to_app_flutter/modules/leads/blocs/leads_listing_bloc.dart';
import 'package:kapil_add_to_app_flutter/strings/app_strings.dart';
import 'package:kapil_add_to_app_flutter/theme/assets/app_colors.dart';
import 'package:kapil_add_to_app_flutter/theme/text_style_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddQueryScreen extends StatefulWidget {
  final int leadID;

  const AddQueryScreen({super.key, required this.leadID});

  @override
  State<AddQueryScreen> createState() => _AddQueryScreenState();
}

class _AddQueryScreenState extends State<AddQueryScreen> {
  final _bloc = sl.get<AddQueryBloc>();
  final _queryTextController = TextEditingController();
  String? queryType;

  @override
  void initState() {
    super.initState();
    _bloc.getQueriesOptions();
  }

  @override
  void dispose() {
    _queryTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddQueryBloc, AddQueryState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is AddQuerySubmited) {
          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(AppStrings.raiseDispute),
                content: const Text(
                  'Your Query is successfully submitted, Please wait for response from our tech support.',
                ),
                actions: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const Text('Finish'),
                    onPressed: () {
                      sl.get<LeadsListingBloc>().getInitialLeads(1);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop(); //close query BottomSheet
                      Navigator.of(context).pop(); //close info BottomSheet
                    },
                  ),
                ],
              );
            },
          );
        } else if (state is AddQuerySubmitError) {
          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(AppStrings.raiseDispute),
                content: const Text(
                  'Something went wrong, please try again later.',
                ),
                actions: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const Text('Finish'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kSpacingMedium,
                vertical: kSpacingMedium,
              ),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: kSpacingXxSmall),
                      child: Text(
                        AppStrings.raiseQuery,
                        style: TextStyleFactory.styleBold16(
                            color: AppColors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(
                      height: kSpacingMedium,
                    ),
                    DropdownButtonFormField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(kRadiusSmall),
                            ),
                            borderSide: BorderSide(
                                color:
                                    AppColors.greyTextFieldColor.withAlpha(80),
                                width: kSpacingOne),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(kRadiusSmall),
                            ),
                            borderSide: BorderSide(
                                color:
                                    AppColors.greyTextFieldColor.withAlpha(80),
                                width: kSpacingOne),
                          ),
                          filled: true,
                          fillColor: AppColors.greyTextFieldColor.withAlpha(30),
                        ),
                        hint: Text(
                          AppStrings.selectReason,
                          style: TextStyleFactory.styleNormal16(
                              color: AppColors.greyLightSubtitleColor),
                        ),
                        value: state.queriesOptions == null
                            ? ''
                            : state.queriesOptions?[0].queryType ?? '',
                        items: (state.queriesOptions ?? []).map(
                          (e) {
                            if (queryType == null) queryType = e.queryType;
                            return DropdownMenuItem<String>(
                              value: e.queryType,
                              child: Text(
                                e.queryType.toString(),
                                style: TextStyleFactory.styleNormal16(),
                              ),
                            );
                          },
                        ).toList(),
                        onChanged: (val) => {
                              queryType = val.toString(),
                            }),
                    const SizedBox(
                      height: kSpacingMedium,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.greyTextFieldColor.withAlpha(30),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(kRadiusSmall),
                        ),
                      ),
                      child: TextField(
                        controller: _queryTextController,
                        keyboardType: TextInputType.name,
                        minLines: 7,
                        maxLines: 10,
                        onChanged: (text) {
                          if (state.fieldError == true) {
                            _bloc.onTextFieldTap();
                          }
                        },
                        style: TextStyle(
                          color:
                              _hasQueryError(state) ? Colors.red : Colors.black,
                        ),
                        decoration: InputDecoration(
                          hintText: AppStrings.write_query_hint,
                          labelStyle: TextStyle(
                            color: _hasQueryError(state)
                                ? Colors.red
                                : Colors.black,
                          ),
                          hintStyle: TextStyle(
                            color: _hasQueryError(state)
                                ? Colors.red
                                : AppColors.greyLightSubtitleColor,
                          ),
                          enabledBorder: _renderBorder(state),
                          focusedBorder: _renderBorder(state),
                        ),
                      ),
                    ),
                    const SizedBox(height: kSpacingLarge),
                    ElevatedButton(
                      child: state is AddQuerySubmitLoading
                          ? const CircularProgressIndicator()
                          : Text(
                              AppStrings.submit,
                              style: TextStyleFactory.styleBold16(
                                  color: AppColors.white),
                            ),
                      onPressed: () {
                        _bloc.onSubmitTap(
                          leadId: widget.leadID,
                          query: _queryTextController.text,
                          queryType: queryType.toString(),
                          files: [],
                          textController: _queryTextController,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, kSpacing60),
                        elevation: kSpacingOne,
                        backgroundColor: AppColors.bottomSheetHeaderBgColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(kRadiusSmall),
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        );
      },
    );
  }
}

OutlineInputBorder _renderBorder(AddQueryState state) => OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(kRadiusSmall)),
      borderSide: BorderSide(
          color: _hasQueryError(state)
              ? AppColors.redTextColorExpired
              : AppColors.greyTextFieldColor.withAlpha(80),
          width: kSpacingOne),
    );

bool _hasQueryError(AddQueryState state) => state.fieldError == true;
