import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:newsapp/data/cubit/main_page_cubit.dart';
import 'package:newsapp/screens/detail_page.dart';
import 'package:newsapp/screens/main_page.dart';
import 'package:newsapp/widgets/rating.dart';
import 'package:newsapp/widgets/rounded_star_button.dart';

import '../constants.dart';

class PosterContent extends StatefulWidget {
  final MainPageLoaded state;
  final int index;
  const PosterContent({Key? key,required this.state,required this.index}) : super(key: key);

  @override
  _PosterContentState createState() => _PosterContentState();
}

class _PosterContentState extends State<PosterContent> {
  late MainPageLoaded state;
  late int index;
  @override
  void initState() {
    super.initState();
    state = widget.state;
    index =  widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(movie: state.movies[index])));
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius:
              const BorderRadius.all(Radius.circular(35.0)),
              child: Container(
                color: Colors.black,
                child: SizedBox(
                  height: 500,
                  child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.4),
                          BlendMode.dstATop),
                      child:CachedNetworkImage(imageUrl: '$kImageBaseUrl$kBigPosterSize${state.movies[index].posterPath}',
                        placeholder: (context,url) =>const BlurHash(hash: 'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),


                      )
                    // BlurHash(
                    //   hash: 'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                    //   image:
                    //       '$kImageBaseUrl$kBigPosterSize${state.movies[index].posterPath}',

                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                state.movies[index].title,
                style: const TextStyle(
                    fontSize: 30, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Positioned(
              top: 25,
              right: 25,
              child: RoundedStarButton(
                icon: (!state.movies[index].isFav)
                    ? const Icon(
                  Icons.star_border_rounded,
                  color: Colors.black,
                  size: 60,
                )
                    : const Icon(
                  Icons.star_rounded,
                  color: Colors.yellow,
                  size: 60,
                ),
                onPressed: (){
                  setState(() {
                    if(state.movies[index].isFav){
                      state.movies[index].isFav = false;
                    }else{
                      state.movies[index].isFav = true;
                    }
                  });
                },
              ),
            ),
            Positioned(
              top: 25,
              left: 25,
              child: RoundedRating(movieRating: '${state.movies[index].voteAverage}',width: 60,height: 60,fontSize: 25,),
            )
          ],
        ),
      ),
    );
  }
}
