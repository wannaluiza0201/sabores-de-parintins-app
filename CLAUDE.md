# Sabores de Parintins — App Mobile

App **oficial** "Sabores de Parintins": guia gastronômico de Parintins-AM
(descoberta de restaurantes, cafés, bares, pizzarias, etc.) desenvolvido em
parceria com o **Sebrae Amazonas**.

> **Importante:** este é um produto institucional. Manter padrão profissional
> em código, identidade visual e estabilidade.

---

## Stack

| Camada | Tecnologia |
|--------|------------|
| Mobile | **Flutter** (Dart SDK `^3.11.5`) |
| State management | **Riverpod** |
| HTTP | **Dio** |
| Cache local | **Hive** |
| Navegação | **go_router** |
| Imagens | **cached_network_image** |
| Backend (já pronto) | **Laravel 13 + MySQL + Filament v4** |

**Application ID:** `br.com.sebrae.parintins.sabores_parintins_app`

---

## Backend / API

Backend Laravel roda **local** em `http://guia-parintins.test` (Laragon,
Windows). API REST pública, JSON, **rate limit 60 req/min**.

**Base URL:** `http://guia-parintins.test/api/v1`

### Endpoints

| Método | Path | Notas |
|--------|------|-------|
| GET | `/health` | Health check |
| GET | `/categories` | Lista categorias |
| GET | `/features` | Lista features (Wi-Fi, estacionamento, etc.) |
| GET | `/establishments` | Lista paginada |
| GET | `/establishments/{slug}` | Detalhe |
| GET | `/establishments/{slug}/photos` | Galeria |

**Filtros de `/establishments`:** `search`, `category`, `features`,
`open_now`, `neighborhood`, `page`, `per_page`.

### Lógica inteligente (já implementada na API — NÃO replicar no app)

- Estabelecimentos **abertos** aparecem primeiro
- Ordenação prioriza a categoria do horário atual (timezone **America/Manaus**):
  - `04:00–10:30` → café da manhã
  - `10:31–15:00` → restaurante
  - `15:01–18:00` → cafeteria
  - `18:01–03:59` → bar / pizzaria
- Ordem aleatória com **seed diário** (estável durante o dia)

### Acesso a partir do emulador Android

`http://guia-parintins.test` resolve no **host Windows** (hosts do Laragon).
O emulador Android **não enxerga** esse hostname diretamente. Opções:
- Usar `http://10.0.2.2:<porta>` (alias do host no emulador) com porta do Laragon
- Ou configurar o hostname no AVD / usar `adb reverse`

> ⚠️ Definir a `baseUrl` do Dio em um único lugar (`lib/core/config/`) para
> alternar entre emulador, device físico e produção sem refatorar.

---

## Identidade visual

Cores oficiais (referências ao **Festival Folclórico de Parintins** —
Garantido vermelho × Caprichoso azul):

| Token | Hex | Uso |
|-------|-----|-----|
| **Primary** | `#F5B82E` | Amarelo dourado — marca principal |
| **Warning** | `#E85D24` | Laranja Garantido |
| **Danger** | `#C0282E` | Vermelho Garantido |
| **Info** | `#3B6BAC` | Azul Caprichoso |
| **Success** | `#1D6B4A` | Verde Amazônia |

**Fontes:**
- **Sacramento** (cursiva, Google Fonts) — títulos / display
- **Inter** (Google Fonts) — corpo / UI

**Logo:** ainda em produção. Por enquanto exibir apenas o texto
"Sabores de Parintins" em Sacramento.

---

## Estrutura de pastas

```
lib/
├── main.dart                     # runApp + ProviderScope
├── app.dart                      # MaterialApp + theme (router será wired aqui)
├── core/
│   ├── theme/
│   │   ├── app_colors.dart       # paleta oficial
│   │   ├── app_text_styles.dart  # Inter + Sacramento (Google Fonts)
│   │   └── app_theme.dart        # ThemeData + BrandColors extension
│   ├── network/
│   │   └── dio_client.dart       # Dio + dioProvider (Riverpod)
│   └── router/
│       └── app_router.dart       # go_router (stub até passos 7+)
└── features/
    ├── home/
    │   └── presentation/
    │       └── home_screen.dart  # criada no passo 7
    └── establishments/
        ├── data/
        │   ├── models/           # Establishment, Category
        │   ├── repositories/
        │   └── providers/        # establishmentRepositoryProvider, establishmentsProvider, categoriesProvider
        └── presentation/
            └── widgets/          # EstablishmentCard, CategoryChip, PromoBanner
```

> Padrão: **feature-first**. Cada feature autocontida (analogia com
> Filament Resources por domínio).

---

## Como trabalhar com o Claude neste projeto

Regras de colaboração (o usuário tem **zero experiência com Flutter/Dart**):

1. **Antes de criar arquivos**, explicar brevemente o conceito Flutter por
   trás (ex.: o que é `StatefulWidget`, como `Riverpod` funciona,
   `Provider` × `StateNotifier` × `AsyncNotifier`, etc.). Usar analogias
   com Laravel/Eloquent/Filament quando ajudar.
2. **Mostrar os arquivos** que vão ser criados/editados **antes** de
   executar.
3. Ao adicionar pacote novo no `pubspec.yaml`, **explicar pra que serve**.
4. Pode rodar **sem pedir**: `flutter pub get`, `flutter run`, `dart format`.
5. **Perguntar antes** de mudanças grandes na arquitetura.

---

## Ambiente

- **OS:** Windows 11
- **Shell padrão:** PowerShell (usar sintaxe PS — `$env:VAR`, `;` ao invés
  de `&&`)
- **Backend:** Laragon (Apache + MySQL + PHP) servindo
  `http://guia-parintins.test`
- **IDEs:** PhpStorm (backend) + Android Studio (mobile)
- **Emulador:** Android API 36

---

## Comandos úteis

```powershell
flutter pub get                    # instalar dependências
flutter pub upgrade --major-versions
flutter run                        # rodar no device/emulador ativo
flutter run -d <deviceId>          # rodar em device específico
flutter devices                    # listar devices
dart format lib/                   # formatar código
flutter analyze                    # lint estático
flutter test                       # rodar testes
flutter clean                      # limpar build/

# Code generation (freezed + json_serializable + riverpod_generator)
dart run build_runner build        # gera .g.dart / .freezed.dart uma vez
dart run build_runner watch        # mantém gerando enquanto edita
```

## Base URL da API

Definido inline em `lib/core/network/dio_client.dart` como
`_baseUrl = 'http://10.0.2.2/api/v1'`. Trocar conforme o ambiente:

- **Device físico (mesma LAN)**: IP do host (atual)
- **Emulador Android**: `http://10.0.2.2/api/v1`
- **Produção**: URL real do backend

---

## Roadmap inicial

- [x] Criar `CLAUDE.md` com contexto do projeto
- [x] Adicionar pacotes (Riverpod 3, Dio, Hive, go_router, freezed, etc.)
- [x] Configurar estrutura de pastas (`lib/core`, `lib/features`, `lib/shared`)
- [x] Configurar tema (cores oficiais + fontes Sacramento/Inter)
- [x] Criar cliente HTTP Dio (`lib/core/network/`) + `dioProvider` (Riverpod)
- [x] Models `Establishment` + `Category` com freezed (Feature/Photo entram com tela de detalhe)
- [x] Repository + providers (`establishmentRepositoryProvider`, `establishmentsProvider`, `categoriesProvider`)
- [x] Home Screen (header amarelo + search bar flutuante + carousel de categorias + banner + lista de cards + bottom nav)
- [ ] Tela de detalhe (`/establishments/{slug}`) com features, business_hours, contato e galeria de fotos
- [ ] go_router (atualmente `home:` direto em `app.dart`)
- [ ] Conectar busca, filtros e seleção de categoria

### Pendências técnicas

- **`riverpod_lint`** não foi instalado: conflito de versões — o pacote mais
  recente no pub.dev exige `riverpod ≤ 3.1.0`, mas `flutter_riverpod 3.3.1`
  puxa `riverpod 3.2.1`. Reavaliar quando sair versão compatível.
