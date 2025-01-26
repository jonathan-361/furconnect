import 'package:furconnect/features/presentation/page/register_page/register_page.dart';
import 'package:go_router/go_router.dart';

import 'package:furconnect/features/presentation/page/login_presentation_page/login_presentation.dart';
import 'package:furconnect/features/presentation/page/login_page/login.dart';
import 'package:furconnect/features/presentation/page/home_page/home.dart';
import 'package:furconnect/features/presentation/page/home_page/home_content.dart';
import 'package:furconnect/features/presentation/page/pet_page/newPet_page.dart';
import 'package:furconnect/features/presentation/widget/item_pet.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => LoginPresentation(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => Login(),
    ),
    GoRoute(
        path: '/register',
        builder: (context, state) => RegistrationFormScreen()),
    GoRoute(
      path: '/home',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/getPets',
      builder: (context, state) => HomeContent(),
    ),
    GoRoute(
      path: '/newPets',
      builder: (context, state) => PetFormScreen(),
    ),
    GoRoute(
      path: '/pets/:id',
      builder: (context, state) {
        final petId = state.pathParameters['id'];
        return ItemPet(petId: petId!);
      },
    ),
  ],
);
