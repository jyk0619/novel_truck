import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:novel_truck/core/theme/app_colors.dart';
import 'package:novel_truck/ui/components/textfields/custom_textfield.dart';
import 'package:novel_truck/ui/screens/novel/novel_viewmodel.dart';
import 'package:novel_truck/ui/screens/novel/noveldetail_view.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../data/model/genre_model.dart';
import 'addnovel_view.dart';

class Novel extends StatelessWidget {
  const Novel({super.key});

  @override
  Widget build(BuildContext context) {
    final novelViewModel = Provider.of<NovelViewModel>(context);

    return
      Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text('소설 목록'),
            centerTitle: true,
            scrolledUnderElevation: 0,

          ),
          body:SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          label: '검색',
                          controller: novelViewModel.novelSearchController,
                          onChanged: (value) {
                            novelViewModel.searchNovel(value);
                          },
                          prefixIcon: Icons.search,
                        ),
                      ),
                      // 필터 초기화 버튼 (선택사항)
                      if (novelViewModel.currentSearchQuery.isNotEmpty ||
                          novelViewModel.selectedGenreIds.isNotEmpty)
                        IconButton(
                          onPressed: () {
                            novelViewModel.clearAllFilters();
                          },
                          icon: Icon(Icons.clear_all),
                          tooltip: '모든 필터 초기화',
                        ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(2),
                  width: double.infinity,
                  child: GenreFilterWidget(genres: novelViewModel.genreList),
                ),
                // 필터 결과 요약 표시 (선택사항)
                if (novelViewModel.currentSearchQuery.isNotEmpty ||
                    novelViewModel.selectedGenreIds.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text(
                          '필터 결과: ${novelViewModel.searchData.length}개',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        Spacer(),
                        if (novelViewModel.currentSearchQuery.isNotEmpty)
                          Chip(
                            label: Text('검색: "${novelViewModel.currentSearchQuery}"', style: TextStyle(fontSize: 10),),
                            onDeleted: () => novelViewModel.clearSearch(),
                            deleteIcon: Icon(Icons.close, size: 12),
                          ),
                      ],
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: NovelGrid(),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              Navigator.push(context,
              MaterialPageRoute(builder: (context)=>AddNovel(sharedurl: '',)));//소설 추가 페이지로 이동
            },
            child: Icon(Icons.add),
          )
      );
  }
}

class NovelGrid extends StatelessWidget {
  const NovelGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NovelViewModel>(
      builder: (context, novelViewModel, child) {
        return RefreshIndicator(
          onRefresh: () async {
            await novelViewModel.fetchNovelList();
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: novelViewModel.isLoading
                ? _buildShimmeringGrid()
                : GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.7,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  child: Container(
                    height: 150.h,
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image.network(novelViewModel.searchData[index].imgPath,
                                fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(Icons.broken_image, color: Colors.grey, size: 40),
                              ),
                            )
                          ),
                        ),
                        Text('${novelViewModel.searchData[index].title}', overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NovelDetail(
                          novel: novelViewModel.searchData[index],
                        ),
                      ),
                    );
                  },
                );
              },
              itemCount: novelViewModel.searchData.length,
            ),
          ),
        );
      },
    );
  }
}


Widget _buildShimmeringGrid() {
  return GridView.builder(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      childAspectRatio: 0.7,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
    ),
    itemBuilder: (context, index) {
      return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.white,
        child: Container(
          height: 150.h,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    },
    itemCount: 6, // 예시로 6개의 아이템
  );
}

class GenreFilterWidget extends StatefulWidget {
  final List<GenreData> genres;

  const GenreFilterWidget({Key? key, required this.genres}) : super(key: key);

  @override
  _GenreFilterWidgetState createState() => _GenreFilterWidgetState();
}

class _GenreFilterWidgetState extends State<GenreFilterWidget> {
  bool isExpanded = false;
  // 두 줄 내에 보일 대략적인 Chip 개수 (디자인에 맞춰 조정)
  final int maxVisibleChips = 5;

  @override
  Widget build(BuildContext context) {
    return Consumer<NovelViewModel>(
      builder: (context, novelViewModel, child) {
        // 전체보기 + 개별 장르 Chip 리스트 생성
        final allChips = <Widget>[
          ActionChip(
            label: Text('전체', style: Theme.of(context).textTheme.bodySmall),
            backgroundColor: novelViewModel.selectedGenreIds.isEmpty
                ? Theme.of(context).primaryColor
                : null,
            onPressed: () {
              novelViewModel.filterByGenres({});
            },
          ),
          ...widget.genres.map((genre) {
            final isSelected =
            novelViewModel.selectedGenreIds.contains(genre.id?.toString());
            return FilterChip(
              label: Text('# ${genre.name}',
                  style: Theme.of(context).textTheme.bodySmall),
              selected: isSelected,
              selectedColor: AppColors.primary,
              onSelected: (selected) {
                final updated = Set<String>.from(novelViewModel.selectedGenreIds);
                if (selected) {
                  updated.add(genre.id!.toString());
                } else {
                  updated.remove(genre.id!.toString());
                }
                novelViewModel.filterByGenres(updated);
              },
            );
          }).toList(),
        ];

        // 보여줄 Chip 리스트: 접힌 상태면 일부만, 펼친 상태면 전체
        final visibleChips = isExpanded
            ? allChips
            : allChips.take(maxVisibleChips).toList();

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 4.0,
                runSpacing: 1.0,
                children: visibleChips,
              ),
              if (allChips.length > maxVisibleChips)
                Align(
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Icon(
                      isExpanded ? Icons.expand_less : Icons.expand_more,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    onPressed: () => setState(() {
                      isExpanded = !isExpanded;
                    }),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
