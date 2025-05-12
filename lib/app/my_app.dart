import 'package:doneto/core/di/di.dart';
import 'package:doneto/core/services/l10n/gen_l10n/app_localizations.dart';
import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/modules/auth/bloc/auth_bloc.dart';
import 'package:doneto/modules/auth/usecase/delete_token_usecase.dart';
import 'package:doneto/modules/auth/usecase/get_token_usecase.dart';
import 'package:doneto/modules/auth/usecase/get_user_profile_usecase.dart';
import 'package:doneto/modules/auth/usecase/save_token_usecase.dart';
import 'package:doneto/modules/bottom_tab/bloc/bottom_tab_bloc.dart';
import 'package:doneto/modules/fundraiser/bloc/fundraiser_bloc.dart';
import 'package:doneto/modules/fundraiser/usecases/create_fundraiser_draft_usecase.dart';
import 'package:doneto/modules/fundraiser/usecases/get_my_fundraisers_useCase.dart';
import 'package:doneto/modules/fundraiser/usecases/save_user_profile_usecase.dart';
import 'package:doneto/modules/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:doneto/core/utils/go_router/app_routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// This widget is the root of application.
class MyApp extends StatefulWidget {
  // final RemoteNotificationsService remoteNotificationsService;

  const MyApp({
    super.key,
    // required this.remoteNotificationsService,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // setUpNotifications(widget.remoteNotificationsService);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: R.palette.blackColor,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = getScreenSize();
    return MultiBlocProvider(
      providers: [
        BlocProvider<FundraiserBloc>(
          create:
              (context) => FundraiserBloc(
                createFundraiserDraftUseCase: sl<CreateFundraiserDraftUseCase>(),
                saveUserProfileUsecase: sl<SaveUserProfileUsecase>(),
                saveTokenUseCase: sl<SaveTokenUseCase>(),
                getMyFundraisersUseCase: sl<GetMyFundraisersUseCase>(),
                //
              ),
        ),
        BlocProvider<BottomTabBloc>(create: (context) => BottomTabBloc()),
        BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
        BlocProvider<AuthBloc>(
          create:
              (context) => AuthBloc(
                saveTokenUseCase: sl<SaveTokenUseCase>(),
                getTokenUseCase: sl<GetTokenUseCase>(),
                deleteTokenUseCase: sl<DeleteTokenUseCase>(),
                getUserProfileUseCase: sl<GetUserProfileUseCase>(),
              ),
        ),
      ],
      child: ScreenUtilInit(
        designSize: screenSize,
        useInheritedMediaQuery: true,
        builder:
            (context, __) => MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routeInformationProvider: AppRouter.router.routeInformationProvider,
              routeInformationParser: AppRouter.router.routeInformationParser,
              routerDelegate: AppRouter.router.routerDelegate,
              title: 'Doneto',
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [Locale('en')],
              // locale: Locale(settingState.locale),
              theme: AppTheme().lightTheme(),
              darkTheme: AppTheme().lightTheme(),
            ),
      ),
    );
  }

  Size getScreenSize() {
    return const Size(402, 874);
  }
}
