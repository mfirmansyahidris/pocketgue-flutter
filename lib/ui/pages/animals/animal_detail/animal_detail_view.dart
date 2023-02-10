import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocketgue/core/core.dart';
import 'package:pocketgue/ui/pages/animals/widgets/animal_item.dart';
import 'package:pocketgue/ui/ui.dart';
import 'package:pocketgue/utils/utils.dart';

class AnimalDetailView extends StatefulWidget {
  final AnimalData animalData;
  const AnimalDetailView({
    Key? key,
    required this.animalData,
  }) : super(key: key);

  @override
  State<AnimalDetailView> createState() => _AnimalDetailViewState();
}

class _AnimalDetailViewState extends State<AnimalDetailView> {
  late AnimalDetailBloc _animalDetailBloc;

  @override
  void initState() {
    super.initState();

    _animalDetailBloc = BlocProvider.of(context);
    _animalDetailBloc.getAnimal(widget.animalData.url ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              snap: false,
              pinned: true,
              floating: false,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                      widget.animalData.name ?? "",
                      style: TextStyles.h3.copyWith(
                        color: Palette.white,
                        shadows: [
                          const Shadow(
                            color: Palette.black40,
                            blurRadius: 10
                          )
                        ]
                      )
                  ), //Text
                  background: AnimalItem(
                    fullName: widget.animalData.name ?? "",
                    color: widget.animalData.color,
                    showFullName: false,
                  )
              ),
              expandedHeight: 100.h,
              backgroundColor: widget.animalData.color,
              actions: [
                if(widget.animalData.canDelete ?? false) IconButton(
                    onPressed: (){
                      context.dialogConfirm(
                        title: Strings.get.delete,
                        message: Strings.get.deleteConfirm,
                        onActionYes: () async {
                          final savedRepository = SavedAnimalRepository();
                          await savedRepository.open();
                          await savedRepository.delete(widget.animalData.url ?? "");
                          savedRepository.close();
                          setState(() {
                            widget.animalData.canDelete = false;
                          });
                        }
                      );
                    },
                    icon: const Icon(Icons.delete)
                )
              ],
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: _detailBuilder()
            )
          ],
        )
    );
  }

  Widget _detailBuilder(){
    return BlocBuilder<AnimalDetailBloc, Result<AnimalDetailResponse>>(
      bloc: _animalDetailBloc,
      builder: (context, state){
        if(state.status == Status.loading){
          return const Loading();
        }

        if(state.status == Status.error){
          return Error(errorMessage: state.message,);
        }

        if(state.status == Status.success){
          return Column(
            children: [
              SpacerV(value: Dimens.space10,),
              _detailItemBuilder(
                  title: Strings.get.name,
                  content: state.data?.name ?? ""
              ),
              const Divider(),
              _detailItemBuilder(
                  title: Strings.get.abilities,
                  content: state.data?.abilities?.map((e) => e.ability?.name ?? "").toList().join(", ") ?? ""
              ),
              const Divider(),
              _detailItemBuilder(
                  title: Strings.get.baseExperience,
                  content: state.data?.baseExperience.toString() ?? ""
              ),
              const Divider(),
              _detailItemBuilder(
                  title: Strings.get.forms,
                  content: state.data?.forms?.map((e) => e.name ?? "").toList().join(", ") ?? ""
              ),
              const Divider(),
              _detailItemBuilder(
                  title: Strings.get.gameIndices,
                  content: state.data?.gameIndices?.map((e) => e.gameIndex.toString()).toList().join(", ") ?? ""
              ),
              const Divider(),
              _detailItemBuilder(
                  title: Strings.get.moves,
                  content: state.data?.moves?.map((e) => e.move?.name ?? "").toList().join(", ") ?? ""
              ),
              const Divider(),
              _detailItemBuilder(
                  title: Strings.get.species,
                  content: state.data?.species?.name ?? ""
              ),
              const Divider(),
              _detailItemBuilder(
                  title: Strings.get.stats,
                  content: state.data?.stats?.map((e) => "${e.stat?.name}(${e.baseStat})").toList().join(", ") ?? ""
              ),
              const Divider(),
              _detailItemBuilder(
                  title: Strings.get.types,
                  content: state.data?.types?.map((e) => e.type?.name ?? "").toList().join(", ") ?? ""
              ),
              SpacerV(value: Dimens.space10,),
            ],
          );
        }

        return const SizedBox();
      },
    );
  }

  Widget _detailItemBuilder({required String title, required String content}){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SpacerH(value: Dimens.space10,),
        Expanded(
          flex: 1,
          child: Text(title)
        ),
        Expanded(
          flex: 2,
          child: Text(content)
        ),
        SpacerH(value: Dimens.space10,),
      ],
    );
  }
}
