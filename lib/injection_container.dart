import 'package:kapil_add_to_app_flutter/modules/dashboard/blocs/dashboard_bloc.dart';
import 'package:kapil_add_to_app_flutter/modules/leads/blocs/add_query_bloc.dart';
import 'package:kapil_add_to_app_flutter/modules/leads/blocs/lead_detail_bloc.dart';
import 'package:kapil_add_to_app_flutter/modules/leads/blocs/lead_queries_bloc.dart';
import 'package:kapil_add_to_app_flutter/modules/leads/blocs/leads_listing_bloc.dart';
import 'package:kapil_add_to_app_flutter/modules/product/blocs/product_detail_bloc.dart';
import 'package:kapil_add_to_app_flutter/modules/product/blocs/product_listing_bloc.dart';
import 'package:kapil_add_to_app_flutter/modules/product/repositories/product_repo.dart';
import 'package:kapil_add_to_app_flutter/utils/sdk_initialisation_service.dart';
import 'package:get_it/get_it.dart';

/// [sl] stands for service locator.
final sl = GetIt.instance;

/// [sdkInitResponse] holds the param data that is passsed by the
/// host application to Advisor SDK via Method Channel.
late SdkInitResponse sdkInitResponse;

/// Initialise all the services and dependencies here that
/// needed to be used throughout the lifecycle of the app.
void init() {
  sl.registerSingletonAsync<SdkInitResponse>(() => _initialiseSdkServices());
  sl.registerLazySingleton(() => DashboardBloc());
  sl.registerLazySingleton(() => ProductListingBloc());
  sl.registerLazySingleton(() => ProductDetailBloc());
  sl.registerLazySingleton(() => ProductRepo());
  sl.registerLazySingleton(() => LeadsListingBloc());
  sl.registerLazySingleton(() => LeadDetailBloc());
  sl.registerLazySingleton(() => LeadQueriesBloc());
  sl.registerLazySingleton(() => AddQueryBloc());
}

Future<SdkInitResponse> _initialiseSdkServices() async {
  try {
    sdkInitResponse = await fetchParamsFromHostApp();
    return sdkInitResponse;
  } catch (_) {
    // TODO(kaxp): Change the SDKInitStatus.success to SDKInitStatus.failed
    //! in final build
    sdkInitResponse = SdkInitResponse(
      sdkInitStatus: SDKInitStatus.success,
      clientSecret: '#u4yQBEJ2gnP4Ju0n?a=tW1twHBQSJ',
      advisorCode: '30201920',
      agentMobile: '7892507675',
      agentName: 'test',
      agentEmail: 'test@bs.com',
    );
    return sdkInitResponse;
  }
}
