import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocketgue/core/core.dart';
import 'package:pocketgue/ui/ui.dart';

class AnimalCatcherView extends StatefulWidget {
  final int maxPage;
  const AnimalCatcherView({Key? key, required this.maxPage}) : super(key: key);

  @override
  State<AnimalCatcherView> createState() => _AnimalCatcherViewState();
}

class _AnimalCatcherViewState extends State<AnimalCatcherView> {
  AnimalData? _animalData;
  late AnimalsBloc _animalsBloc;
  List<AnimalData> _options = [];
  bool _showCongratulations = false;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _animalsBloc = BlocProvider.of(context);
    final targetPage = Random().nextInt(widget.maxPage);
    _animalsBloc.getAnimals(AnimalsRequest(page: targetPage));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AnimalsBloc, Result<AnimalsResponse>>(
      bloc: _animalsBloc,
      listener: (context, state){
        if(state.status == Status.success){
          setState(() {
            _options = state.data?.results ?? [];
            _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
              setState(() {
                _animalData = _options[Random().nextInt(_options.length - 1)];
              });
            });
          });
        }
      },
      child: BlocBuilder<AnimalsBloc, Result<AnimalsResponse>>(
        bloc: _animalsBloc,
        builder: (context, state){
          if(state.status == Status.success){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if(_showCongratulations) Text(
                  Strings.get.congratulation,
                  style: TextStyles.h6,
                ),
                if(_showCongratulations) SpacerV(value: Dimens.space10,),
                Text(
                  _animalData?.name ?? "",
                  style: TextStyles.h4.copyWith(
                      fontWeight: FontWeight.bold
                  ),
                ),
                SpacerV(value: Dimens.space20,),
                FloatingActionButton.extended(
                    onPressed: _animalData != null ? () async {
                      _timer?.cancel();
                      setState(() {
                        _showCongratulations = true;
                      });
                      final savedRepository = SavedAnimalRepository();
                      await savedRepository.open();
                      await savedRepository.insert(_animalData!);
                      savedRepository.close();
                    } : null,
                    label: Text(Strings.get.catchAnimal)
                )
              ],
            );
          }
          if(state.status == Status.error){
            return Error(errorMessage: state.message,);
          }

          if(state.status == Status.loading){
            return const Loading();
          }

          return const SizedBox();
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }
}
