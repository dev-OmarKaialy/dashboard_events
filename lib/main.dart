import 'package:bot_toast/bot_toast.dart';
import 'package:events_dashboard/features/auth/presentation/pages/login_screen.dart';
import 'package:events_dashboard/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:events_dashboard/features/feedback/presentation/cubit/feedback_cubit.dart';
import 'package:events_dashboard/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
  );
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => CategoriesBloc(),
      ),
      BlocProvider(
        create: (context) => OrdersCubit(),
      ),
      BlocProvider(
        create: (context) => FeedbackCubit(),
      ),
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: MaterialApp(
        navigatorObservers: [BotToastNavigatorObserver()],
        builder: BotToastInit(),
        home: const LoginPage(),
      ),
    );
  }
}
