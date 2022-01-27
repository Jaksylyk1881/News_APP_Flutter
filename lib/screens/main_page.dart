import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/data/cubit/main_page_cubit.dart';
import 'package:newsapp/widgets/poster_content.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../widgets/custom_snack_bar.dart';

class MainPage extends StatefulWidget {
  static String id = 'mainPage';

  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  RefreshController controller = RefreshController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MainPageCubit>(context).onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('News')),
      ),
      body: BlocConsumer<MainPageCubit, MainPageState>(
        listener: (context, state) {
          if (state is MainPageError) {
            buildErrorCustomSnackBar(context, state.message);
          }
          if (state is MainPageLoaded) {
            controller.refreshCompleted();
          }
        },
        builder: (context, state) {
          if (state is MainPageEmpty) {
            return const Center(
              child: Text('No news to show'),
            );
          }
          if (state is MainPageLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.purple,
              ),
            );
          }
          if (state is MainPageLoaded) {
            return OrientationBuilder(
              builder: (BuildContext context, Orientation orientation) {
                return (orientation == Orientation.portrait)
                    ? SmartRefresher(
                        controller: controller,
                        enablePullUp: true,
                        onRefresh: () {
                          BlocProvider.of<MainPageCubit>(context).onRefresh();
                        },
                        onLoading: () {
                          BlocProvider.of<MainPageCubit>(context).onLoading();
                          controller.loadComplete();
                        },
                        child: ListView.builder(
                            itemCount: state.movies.length,
                            itemBuilder: (context, index) {
                              return PosterContent(
                                  state: state, index: index);
                            }),
                      )
                    : SmartRefresher(
                        controller: controller,
                        enablePullUp: true,
                        onRefresh: () {
                          BlocProvider.of<MainPageCubit>(context).onRefresh();
                        },
                        onLoading: () {
                          BlocProvider.of<MainPageCubit>(context).onLoading();
                          controller.loadComplete();
                        },
                        child: GridView.builder(
                            itemCount: state.movies.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (context, index) {
                              return PosterContent(
                                  state: state, index: index);
                            }),
                      );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          );
        },
      ),
    );
  }
}
// builder: (BuildContext context, Orientation orientation) {
// return (orientation==Orientation.portrait)
// ?ListView.builder(
// itemCount: state.movies.length,
// itemBuilder: (context, index) {
// return PosterContent(state: state, index: index);
// })
//     :GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// crossAxisCount: 2,
// ),
// itemBuilder: (context, index) {
// return PosterContent(state: state, index: index);
// });
// }
