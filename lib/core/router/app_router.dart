import 'package:go_router/go_router.dart';

import '../../features/establishments/presentation/establishment_detail_screen.dart';
import '../../features/favorites/presentation/favorites_screen.dart';
import '../../features/reviews/presentation/all_reviews_screen.dart';
import '../../features/reviews/presentation/my_reviews_screen.dart';
import '../../features/settings/presentation/language_picker_screen.dart';
import '../../features/shell/presentation/app_shell.dart';

/// Configuração central de rotas do app (go_router).
///
/// CONCEITO — `pathParameters`: trechos do path prefixados com `:` viram
/// variáveis dinâmicas (ex: `:slug`). Dentro do builder, `state.pathParameters`
/// é um `Map<String,String>` com esses valores extraídos da URL atual.
///
/// USO no app:
///   - Navegar: `context.push('/establishment/boi-bumba-burger')`
///   - Voltar:  `context.pop()` (ou Navigator.pop / botão back do Android)
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // `/` agora aponta pro AppShell (IndexedStack com 4 tabs).
    // A HomeScreen vive dentro dele, na tab 0.
    GoRoute(path: '/', builder: (context, state) => const AppShell()),
    GoRoute(
      path: '/establishment/:slug',
      builder: (context, state) {
        // `!` aqui é seguro: o go_router só chama este builder quando o
        // path bate, e nesse caso `:slug` SEMPRE existe.
        final slug = state.pathParameters['slug']!;
        return EstablishmentDetailScreen(slug: slug);
      },
    ),
    // Tela "Meus Favoritos" — empilhada sobre o AppShell. Acessada
    // pelo coração do header da Home E pelo item no Perfil.
    GoRoute(
      path: '/favorites',
      builder: (context, state) => const FavoritesScreen(),
    ),
    // Todas as avaliações de UM estabelecimento.
    // `state.extra` carrega o nome (UX rápida — sem refetch só pra título).
    GoRoute(
      path: '/establishment/:slug/reviews',
      builder: (context, state) {
        final slug = state.pathParameters['slug']!;
        final initialName = state.extra as String?;
        return AllReviewsScreen(slug: slug, initialName: initialName);
      },
    ),
    // "Minhas avaliações" — acessada pelo item no Perfil.
    GoRoute(
      path: '/me/reviews',
      builder: (context, state) => const MyReviewsScreen(),
    ),
    // Seleção de idioma — acessada pelo item "Idioma" no Perfil.
    GoRoute(
      path: '/settings/language',
      builder: (context, state) => const LanguagePickerScreen(),
    ),
  ],
);
