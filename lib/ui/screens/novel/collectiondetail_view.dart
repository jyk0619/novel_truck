import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:novel_truck/core/theme/app_colors.dart';
import 'package:novel_truck/ui/components/textfields/custom_textfield.dart';
import 'package:novel_truck/ui/screens/novel/collection_viewmodel.dart';
import 'package:novel_truck/ui/screens/novel/collectionitemadd_view.dart';
import 'package:novel_truck/ui/screens/novel/novel_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CollectionDetail extends StatefulWidget {
  final collectionIndex;

  CollectionDetail({super.key, required this.collectionIndex});

  @override
  State<CollectionDetail> createState() => _CollectionDetailState();
}

class _CollectionDetailState extends State<CollectionDetail> {
  bool _isInitialized = false;
  bool _isEditing = false;
  String editText = '';
  String editImage = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // ✅ context 사용 가능 + 한 번만 실행되도록 보장
    if (!_isInitialized) {
      final viewmodel = context.read<CollectionViewModel>();
      final collection = viewmodel.collectionList[widget.collectionIndex];
      viewmodel.initializeCollectionNovels(collection.id);
      _isInitialized = true;
    }
  }

//컬렉션 index 받음
  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<CollectionViewModel>(context);
    final collection = viewmodel.collectionList[widget.collectionIndex];
    final collectionNovels = viewmodel.collectionNovelList;

    return Scaffold(
      floatingActionButtonAnimator: FloatingActionButtonAnimator.noAnimation,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            color: Theme.of(context).colorScheme.primary,
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) => Container(
                        height: 220.h,
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text('플레이리스트 관리',
                                style:
                                    Theme.of(context).textTheme.displayMedium),
                            SizedBox(height: 20),
                            InkWell(
                              child: Container(
                                width: double.infinity,
                                height: 50.h,
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: AppColors.divider),
                                ),
                                child: Center(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.delete,
                                      size: 25,
                                      color: Colors.red,
                                    ),
                                    SizedBox(width: 10),
                                    Text('플레이리스트 삭제',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall),
                                  ],
                                )),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (context) => AlertDialog(
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          title: Text('플레이리스트 삭제',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium),
                                          content: Text(
                                              '정말로 ${collection.title} 플레이리스트를 삭제하시겠습니까?',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall),
                                          actions: [
                                            TextButton(
                                              child: Text('취소',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displaySmall),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                            TextButton(
                                              child: Text('삭제',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displaySmall),
                                              onPressed: () async {
                                                await viewmodel
                                                    .removeCollection(collection
                                                        .id); // ✅ await 추가
                                                Navigator.pop(
                                                    context); // 다이얼로그 닫기
                                                Navigator.pop(
                                                    context); // 상세 화면 닫기
                                              },
                                            ),
                                          ],
                                        ));
                              },
                            ),
                            SizedBox(height: 10),
                            InkWell(
                              child: Container(
                                width: double.infinity,
                                height: 50.h,
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: AppColors.divider),
                                ),
                                child: Center(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.edit,
                                      size: 25,
                                    ),
                                    SizedBox(width: 10),
                                    Text('플레이리스트 수정',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall),
                                  ],
                                )),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                setState(() {
                                  _isEditing = true;
                                  editText = collection.title;
                                  editImage = collection.thumbnail;
                                });
                              },
                            ),
                          ],
                        ),
                      ));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 200.h,
                height: 200.w,
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                // ✅ ClipRRect를 추가하여 자식 위젯들이 둥근 모서리를 따르도록 함
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  // 부모와 동일한 borderRadius 적용
                  child: _isEditing
                      ? InkWell(
                          onTap: () {
                            //이미지 수정
                            imagePicker().then((value) {
                              if (value != '') {
                                setState(() {
                                  editImage = value;
                                });
                              }
                            });
                          },
                          child: Stack(
                            fit: StackFit.expand, // Stack이 ClipRRect를 꽉 채우도록 설정
                            children: [
                              Image.file(
                                File(editImage),
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(Icons.error, size: 50);
                                },
                              ),
                              Positioned.fill(
                                child: Container(
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ),
                              const Positioned.fill(
                                child: Center(
                                  child: Icon(Icons.edit,
                                      color: Colors.white, size: 50),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Image.network(
                          collection.thumbnail,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.error, size: 50);
                          },
                        ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 20),
                child: Center(
                    child: _isEditing
                        ? TextButton(
                            onPressed: () {
                              //컬렉션 제목 수정 textfield 다이얼로그
                              showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (context) {
                                    TextEditingController _titleController =
                                        TextEditingController(text: editText);
                                    return AlertDialog(
                                      backgroundColor:
                                          Theme.of(context).colorScheme.surface,
                                      content: TextField(
                                        controller: _titleController,
                                        decoration: InputDecoration(
                                          hintText: '플레이리스트 이름을 입력해주세요',
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(color: Colors.grey),
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          child: Text('확인',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall),
                                          onPressed: () {
                                            setState(() {
                                              editText = _titleController.text;
                                            });
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(editText,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge),
                                SizedBox(width: 5),
                                Icon(
                                  Icons.edit,
                                  size: 20,
                                ),
                              ],
                            ),
                          )
                        : Text(collection.title,
                            style: Theme.of(context).textTheme.displayLarge)),
              ),
              InkWell(
                child: Container(
                  width: double.infinity,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    border: Border.all(
                        color: Theme.of(context).colorScheme.surface),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: AppColors.primary, size: 30),
                      Text('소설 추가하기',
                          style: Theme.of(context).textTheme.displayMedium),
                    ],
                  ),
                ),
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(
                            height: 200.h,
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Text('소설 추가하기',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium),
                                SizedBox(height: 20),
                                Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                      borderRadius: BorderRadius.circular(10),
                                      border:
                                          Border.all(color: AppColors.divider),
                                    ),
                                    child: InkWell(
                                      child: SizedBox(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.menu_book_outlined,
                                                color: AppColors.primary,
                                                size: 30),
                                            Container(
                                                padding:
                                                    EdgeInsets.only(left: 10),
                                                child: Text('내 서재에서 추가하기',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displayMedium)),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CollectionAddItem(
                                                      collectionIndex: widget
                                                          .collectionIndex)),
                                        );
                                      },
                                    ))
                              ],
                            ),
                          ));
                },
              ),
              SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: collectionNovels.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Container(
                      height: 120.h,
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Container(
                            width: 80.w,
                            height: 100.h,
                            child: Image.network(
                              (collectionNovels[index].imgPath),
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons.error, size: 50);
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(collectionNovels[index].title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis),
                                Text(collectionNovels[index].author,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _isEditing
          ? Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      setState(() {
                        _isEditing = false;
                      });
                    },
                    label: Text('수정 완료',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(color: Colors.white)),
                    icon: Icon(Icons.check, color: Colors.white),
                    backgroundColor: AppColors.primary,
                  ),
                ),
                Align(
                  alignment: Alignment(
                      Alignment.bottomCenter.x + 0.9, Alignment.bottomCenter.y),
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      setState(() {
                        _isEditing = false;
                      });
                    },
                    label: Text('취소',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(color: Colors.white)),
                    icon: Icon(Icons.close, color: Colors.white),
                    backgroundColor: Colors.grey,
                  ),
                )
              ],
            )
          : null,
    );
  }
}

Future<String> imagePicker() async {
  final ImagePicker _picker = ImagePicker();
  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  if (image != null) {
    // Use the selected image
    String _imagePath = image.path;
    print('Selected image path: $_imagePath');
    return _imagePath;
    // You can also display the image in your UI using Image.file(File(imagePath))
  } else {
    print('No image selected.');
    return '';
  }
}
