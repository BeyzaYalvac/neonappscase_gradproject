import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_paddings.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/domain/model/file_folder_list_model.dart';
import 'package:neonappscase_gradproject/app/presentation/favorite/cubit/favorite_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/favorite/cubit/favorite_state.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_state.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/file&image/listview_image/listile_image/image_listile.dart';
import 'package:neonappscase_gradproject/core/extensions/widget_extensions.dart';

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
      listener: (context, homeState) {
        _maybeTopUp(context.read<HomeCubit>());
      },
      builder: (context, homeState) {
        final favCubit = context.read<FavoriteCubit>();

        return BlocBuilder<FavoriteCubit, FavoriteState>(
          builder: (context, favState) {
            final itemCount =
                homeState.images.length + (homeState.isLoadingMore ? 1 : 0);

            return Stack(
              children: [
                ListView.builder(
                  controller: _sc,
                  primary: false,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: itemCount,
                  itemBuilder: (context, index) {
                    // Loader satırı
                    if (index >= homeState.images.length) {
                      return const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.textBej,
                          ),
                        ),
                      );
                    }

                    final item = homeState.images[index];
                    final String fileKey = item.link;

                    // Kontrolde 'link' değil 'id' alanını kıyasla:
                    final bool isFavoriteImage = favState.favoriteFolders.any(
                      (fav) => fav['id'] == fileKey && fav['type'] == 'image',
                    );

                    return ImageListile(
                      isFavoriteImage: isFavoriteImage,
                      favCubit: favCubit,
                      fileKey: fileKey,
                      item: item,
                      index: index,
                    );
                  },
                ),
                if (homeState.isLoadingMore)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 8,
                    child: Center(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: .15),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child:
                            CircularProgressIndicator(
                              color: AppColors.textBej,
                            ).withPadding(
                              EdgeInsets.symmetric(
                                horizontal: AppPaddings.medium,
                                vertical: AppPaddings.small,
                              ),
                            ),
                      ),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
