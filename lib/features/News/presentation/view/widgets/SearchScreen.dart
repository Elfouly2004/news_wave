import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/features/News/presentation/view/list_veiw_news.dart';
import '../../../../../sharedwidget/Search.dart';
import '../../controller/search_cubit/search_cubit.dart';
import '../../controller/search_cubit/search_state.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
          ),
        ),
        body: const SearchBody(),
      );

  }
}

class SearchBody extends StatelessWidget {
  const SearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchStates>(

      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding:
              EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Search_feild(
                  onChanged: (Q) {
                    BlocProvider.of<SearchCubit>(context).getSearch(q: Q.trim());
                  },
                ),
              ),
            ),
            Expanded(
              child: state is GetSearchLoadingState
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : ListViewForNews(
                news: BlocProvider.of<SearchCubit>(context).searchNews,
              ),
            ),
          ],
        );
      },
    );
  }
}
