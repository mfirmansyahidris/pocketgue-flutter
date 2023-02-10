import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocketgue/core/core.dart';
import 'package:pocketgue/ui/pages/animals/widgets/animal_item.dart';
import 'package:pocketgue/utils/utils.dart';

import '../../../ui.dart';

class SavedView extends StatefulWidget {
  const SavedView({Key? key}) : super(key: key);

  @override
  State<SavedView> createState() => _SavedViewState();
}

class _SavedViewState extends State<SavedView> {
  late SavedBloc _savedBloc;

  @override
  void initState() {
    super.initState();
    _savedBloc = BlocProvider.of(context);
    _savedBloc.getSavedData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<SavedBloc, Result<List<AnimalData>>>(
          bloc: _savedBloc,
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
              return const Center(child: Loading());
            }

            if(state.status == Status.success){
              if((state.data ?? []).isEmpty){
                return Error(
                  errorMessage: Strings.get.dataEmpty,
                );
              }
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 150.h,
                  childAspectRatio: 1 / 1,
                  crossAxisSpacing: Dimens.space2,
                  mainAxisSpacing: Dimens.space2,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.data?.length ?? 0,
                itemBuilder: (context, index){
                  final animal = state.data?[index];
                  animal?.canDelete = true;
                  return AnimalItem(
                    fullName: animal?.name ?? "",
                    color: animal?.color,
                    onTap: () async {
                      await context.goTo(AppRoute.animalDetail, args: animal);
                      _savedBloc.getSavedData();
                    },
                  );
                },
              );
            }

            return const SizedBox();
          },
        ),
      ],
    );
  }
}
