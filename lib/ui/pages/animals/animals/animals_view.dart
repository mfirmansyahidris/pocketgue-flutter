import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocketgue/core/core.dart';
import 'package:pocketgue/ui/pages/animals/widgets/animal_item.dart';
import 'package:pocketgue/ui/ui.dart';
import 'package:pocketgue/utils/utils.dart';

class AnimalsView extends StatefulWidget {
  const AnimalsView({Key? key}) : super(key: key);

  @override
  State<AnimalsView> createState() => _AnimalsViewState();
}

class _AnimalsViewState extends State<AnimalsView> {
  late AnimalsBloc _animalBloc;
  final AnimalsRequest _animalsRequest = AnimalsRequest();
  AnimalsResponse? _animalResponse;

  final ScrollController _scrollController = ScrollController();
  bool _pageLoading = false;

  bool _isEndPage = false;

  @override
  void initState() {
    super.initState();
    _animalBloc = BlocProvider.of(context);
    _animalBloc.getAnimals(_animalsRequest);

    _scrollController.addListener(() {
      if(!_pageLoading && !_isEndPage){
        if((_scrollController.position.maxScrollExtent - _scrollController.position.pixels) < 100){
          _animalBloc.getAnimals(_animalsRequest);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AnimalsBloc, Result<AnimalsResponse>>(
      listener: (context, state){
        setState(() {
          if(state.status == Status.loading){
            if(_animalResponse != null){
              _pageLoading = true;
            }
          }else{
            _pageLoading = false;
            if(state.status == Status.success){
              if(_animalResponse == null){
                _animalResponse = state.data;
              }else{
                _animalResponse?.results?.addAll(state.data?.results ?? []);
              }
              _animalsRequest.page ++;
            }else if(state.status == Status.empty){
              _isEndPage = true;
            }
          }
        });
      },
      child: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () async {
              _resetPage();
              _animalBloc.getAnimals(_animalsRequest);
            },
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  BlocBuilder<AnimalsBloc, Result<AnimalsResponse>>(
                    bloc: _animalBloc,
                    builder: (context, state){
                      if(state.status == Status.empty){
                        return Error(
                          errorMessage: Strings.get.dataEmpty,
                        );
                      }
                      if(state.status == Status.error){
                        return Error(
                          errorMessage: state.message,
                        );
                      }
                      if(state.status == Status.loading){
                        if(_animalResponse?.results?.isEmpty ?? true){
                          return const Center(child: Loading());
                        }
                      }
                      return const SizedBox();
                    },
                  ),
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 150.h,
                      childAspectRatio: 1 / 1,
                      crossAxisSpacing: Dimens.space2,
                      mainAxisSpacing: Dimens.space2,
                    ),
                    padding: EdgeInsets.only(bottom: Dimens.space32),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _animalResponse?.results?.length ?? 0,
                    itemBuilder: (context, index){
                      final animal = _animalResponse?.results?[index];
                      return AnimalItem(
                        fullName: animal?.name ?? "",
                        color: animal?.color,
                        onTap: () async {
                          context.goTo(AppRoute.animalDetail, args: animal);
                        },
                      );
                    },
                  ),
                  Visibility(
                    visible: _pageLoading,
                    child: Transform.scale(
                      scale: 0.7,
                      child: const Loading(),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: Dimens.space20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FloatingActionButton.extended(
                onPressed: _catchAnimal,
                label: Text(
                  Strings.get.catchAnimal
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _catchAnimal(){
    int maxPage = ((_animalResponse?.count ?? 1) - _animalsRequest.limit) ~/ _animalsRequest.limit;
    context.bottomSheet(
      title: Strings.get.catchNewAnimal,
      centerTitle: true,
      children: [
        BlocProvider(create: (context) => AnimalsBloc(), child: AnimalCatcherView(
          maxPage: maxPage,
        ),)
      ]
    );
  }

  void _resetPage(){
    setState(() {
      _animalResponse = null;
      _animalsRequest.page = 1;
      _isEndPage = false;
    });
  }
}
