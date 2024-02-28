import 'package:kapil_add_to_app_flutter/utils/sdk_initialisation_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kapil_add_to_app_flutter/injection_container.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Cubit<DashboardState> {
  DashboardBloc() : super(DashboardInitial());

  void setDashboardState() async {
    if (sdkInitResponse.sdkInitStatus == SDKInitStatus.failed) {
      emit(DashboardSdkInitalisationFailed());
      return;
    } else {
      await fetchProductList();
    }
  }

  Future<void> fetchProductList() async {
    try {
      emit(DashboardLoading());

      // do api call

      // response.state == true

      emit(DashboardLoaded());
    } catch (error) {
      emit(DashboardError());
    }
  }
}
