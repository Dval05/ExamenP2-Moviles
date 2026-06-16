import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'themes/tema_general.dart';
import 'data/datasources/poliza_api_datasource.dart';
import 'data/repository/poliza_repository_impl.dart';
import 'domain/usescase/crud_polizas_usecase.dart';
import 'presentation/routes/app_routes.dart';
import 'presentation/viewmodel/poliza_viewmodel.dart';

void main() {
  // Inyección de dependencias
  final datasource = PolizaApiDatasource();
  final repository = PolizaRepositoryImpl(apiDatasource: datasource);
  final usecase = CrudPolizasUsecase(repository: repository);

  runApp(MyApp(usecase: usecase));
}

class MyApp extends StatelessWidget {
  final CrudPolizasUsecase usecase;

  const MyApp({super.key, required this.usecase});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PolizaViewModel(usecase)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Pólizas de Seguro",
        initialRoute: "/",
        routes: AppRoutes.routes,
        // Aplico el tema general que agrupa todos tus sub-temas
        theme: GeneralThemeApp.theme,
      ),
    );
  }
}