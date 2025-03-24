import 'package:ecommerce_assignment/config/theme/theme_cubit.dart';
import 'package:ecommerce_assignment/core/enums/order_status.dart';
import 'package:ecommerce_assignment/core/utils/helpers/connection_handler.dart';
import 'package:ecommerce_assignment/features/auth/data/data_sources/auth_remote_datasource.dart';
import 'package:ecommerce_assignment/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ecommerce_assignment/features/auth/domain/repositories/auth_repository.dart';
import 'package:ecommerce_assignment/features/auth/presentation/state/auth_cubit.dart';
import 'package:ecommerce_assignment/features/cart/data/data_source/cart_local_datasource.dart';
import 'package:ecommerce_assignment/features/cart/data/models/cart_item_model.dart';
import 'package:ecommerce_assignment/features/cart/data/repositories/cart_repository_imp.dart';
import 'package:ecommerce_assignment/features/cart/domain/repositories/cart_resporitory.dart';
import 'package:ecommerce_assignment/features/cart/presentation/state/cart_cubit.dart';
import 'package:ecommerce_assignment/features/orders/data/data_source/order_local_datasource.dart';
import 'package:ecommerce_assignment/features/orders/data/models/order_model.dart';
import 'package:ecommerce_assignment/features/orders/data/repositories/order_resporitory_impl.dart';
import 'package:ecommerce_assignment/features/orders/domain/repositories/order_repository.dart';
import 'package:ecommerce_assignment/features/orders/presentation/state/order_cubit.dart';
import 'package:ecommerce_assignment/features/products/data/data_source/product_remote_datasource.dart';
import 'package:ecommerce_assignment/features/products/data/data_source/review_datasource.dart';
import 'package:ecommerce_assignment/features/products/data/models/product_model.dart';
import 'package:ecommerce_assignment/features/products/data/models/review_model.dart';
import 'package:ecommerce_assignment/features/products/data/respositories/product_repository_impl.dart';
import 'package:ecommerce_assignment/features/products/data/respositories/review_repository_impl.dart';
import 'package:ecommerce_assignment/features/products/domain/respositories/product_repository.dart';
import 'package:ecommerce_assignment/features/products/domain/respositories/review_repository.dart';
import 'package:ecommerce_assignment/features/products/presentation/state/product/product_cubit.dart';
import 'package:ecommerce_assignment/features/products/presentation/state/review/review_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

final GetIt getIt = GetIt.instance;

Future<void> injectDependencies() async {
  // Hive Database
  final dbDirectory = await getApplicationSupportDirectory();
  Hive.init(dbDirectory.path);
  Hive
    ..registerAdapter(CartItemModelAdapter())
    ..registerAdapter(ProductModelAdapter())
    ..registerAdapter(OrderModelAdapter())
    ..registerAdapter(OrderStatusAdapter())
    ..registerAdapter(ReviewModelAdapter());
  getIt.registerSingleton<Box<CartItemModel>>(await Hive.openBox<CartItemModel>('cart'));
  getIt.registerSingleton<Box<OrderModel>>(await Hive.openBox<OrderModel>('order'));
  getIt.registerSingleton<Box<ReviewModel>>(await Hive.openBox<ReviewModel>('review'));

  // Auth
  getIt.registerLazySingleton<AuthDataSource>(() => AuthRemoteDataSource());
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt.get<AuthDataSource>()),
  );
  getIt.registerLazySingleton(() => AuthCubit(getIt.get<AuthRepository>()));

  // Product
  getIt.registerLazySingleton<ProductDataSource>(() => ProductRemoteDatasource());
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(getIt.get<ProductDataSource>()),
  );
  getIt.registerLazySingleton(() => ProductCubit(getIt.get<ProductRepository>()));

  // Cart
  getIt.registerLazySingleton<CartDataSource>(
    () => CartLocalDataSource(getIt.get<Box<CartItemModel>>()),
  );
  getIt.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(getIt.get<CartDataSource>()),
  );
  getIt.registerLazySingleton(() => CartCubit(getIt.get<CartRepository>()));

  // order
  getIt.registerLazySingleton<OrderDataSource>(
    () => OrderLocalDatasource(getIt.get<Box<OrderModel>>()),
  );
  getIt.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(getIt.get<OrderDataSource>()),
  );
  getIt.registerLazySingleton(() => OrderCubit(getIt.get<OrderRepository>()));

  // review
  getIt.registerLazySingleton<ReviewDataSource>(
    () => ReviewLocalDataSource(getIt.get<Box<ReviewModel>>()),
  );
  getIt.registerLazySingleton<ReviewRepository>(
    () => ReviewRepositoryImpl(getIt.get<ReviewDataSource>()),
  );
  getIt.registerLazySingleton(() => ReviewCubit(getIt.get<ReviewRepository>()));

  // theme
  getIt.registerLazySingleton(() => ThemeCubit());

  // connectivity
  getIt.registerSingleton<ConnectionHandler>(ConnectionHandler(), dispose: (ch) => ch.dispose());
}
