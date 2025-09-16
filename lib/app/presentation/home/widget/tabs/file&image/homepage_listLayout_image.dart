import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/domain/model/file_folder_list.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_state.dart';

class HomePageListLayoutTabImage extends StatefulWidget {
  final List<FileItem> filteredImages;
  const HomePageListLayoutTabImage({super.key, required this.filteredImages});

  @override
  State<HomePageListLayoutTabImage> createState() =>
      _HomePageListLayoutTabImageState();
}

class _HomePageListLayoutTabImageState extends State<HomePageListLayoutTabImage>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _sc = ScrollController();
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _sc.addListener(_onScroll);

    // İlk frame'den sonra, liste ekranı doldurmuyorsa bir sayfa daha çek
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<HomeCubit>();
      _maybeTopUp(cubit);
    });
  }

  void _maybeTopUp(HomeCubit cubit) {
    if (!_sc.hasClients) return;
    final canScroll = _sc.position.maxScrollExtent > 0;
    final st = cubit.state;
    if (!canScroll && st.imagesHasMore && !st.isLoadingMore) {
      debugPrint('[IMG] viewport dolmadı → loadMore');
      cubit.loadMoreImages();
    }
  }

  void _onScroll() {
    if (!_sc.hasClients) return;

    // Tam en alta inince tetikle (istersen -200 buffer kullan)
    final atEdge = _sc.position.atEdge;
    final atBottom = atEdge && _sc.position.pixels != 0;

    if (!atBottom) return;

    final cubit = context.read<HomeCubit>();
    final st = cubit.state;
    debugPrint(
      '[IMG] atBottom, loadingMore=${st.isLoadingMore}, hasMore=${st.imagesHasMore}',
    );
    if (!st.isLoadingMore && st.imagesHasMore) {
      cubit.loadMoreImages();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // orientation/yeniden build sonrası da kontrol et
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<HomeCubit>();
      _maybeTopUp(cubit);
    });
  }

  @override
  void dispose() {
    _sc.removeListener(_onScroll);
    _sc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<HomeCubit, HomeState>(
      listenWhen: (p, c) =>
          p.images.length != c.images.length ||
          p.imagesHasMore != c.imagesHasMore ||
          p.isLoadingMore != c.isLoadingMore,
      listener: (context, state) {
        // Yeni sayfa geldi ama hâlâ ekran dolmadıysa devam et
        _maybeTopUp(context.read<HomeCubit>());
      },
      builder: (context, state) {
        return ListView.builder(
          controller: _sc,
          primary: false, // Nested scroll senaryosu için önemli
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: state.images.length + (state.isLoadingMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index >= state.images.length) {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            final item = state.images[index];
            return ListTile(
              leading: const Icon(Icons.image, color: AppColors.bgTriartry),
              title: Text(
                item.name,
                style: const TextStyle(
                  color: AppColors.bgTriartry,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
