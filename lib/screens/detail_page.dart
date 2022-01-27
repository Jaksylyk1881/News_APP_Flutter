import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:newsapp/constants.dart';
import 'package:newsapp/data/model/movie.dart';
import 'package:newsapp/widgets/rating.dart';
import 'package:newsapp/widgets/rounded_star_button.dart';

class DetailPage extends StatefulWidget {
  final Movie movie;

  const DetailPage({Key? key, required this.movie}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Movie movie;

  void onPressStar(){
    setState(() {
    if(movie.isFav){
      movie.isFav = false;
    }else{
      movie.isFav = true;
    }
  });
    log('${movie.isFav}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios_rounded)),
        title: Text(movie.title),
      ),
      body: OrientationBuilder(

        builder: (BuildContext context, Orientation orientation) {
          return (orientation == Orientation.portrait )
              ?MovieDetailVertical(movie: movie)
              :MovieDetailHorizontal(movie: movie);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    movie = widget.movie;
  }
}



class MovieDetailVertical extends StatefulWidget {
  final Movie movie;
  const MovieDetailVertical({Key? key, required this.movie}) : super(key: key);

  @override
  _MovieDetailVerticalState createState() => _MovieDetailVerticalState();
}

class _MovieDetailVerticalState extends State<MovieDetailVertical> {
  late Movie movie;

  @override
  void initState() {
    super.initState();
    movie = widget.movie;
  }
  void onPressStar(){
    setState(() {
      if(movie.isFav){
        movie.isFav = false;
      }else{
        movie.isFav = true;
      }
    });
    log('${movie.isFav}');
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              SizedBox(
                height: 500,
                child: CachedNetworkImage(imageUrl: '$kImageBaseUrl$kBigPosterSize${movie.posterPath}',
                  placeholder: (context,url) =>const BlurHash(hash: 'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                ),
              ),
              Padding(
                padding:
                const EdgeInsets.only(left: 15, bottom: 20, right: 30),
                child: Text(
                  movie.title,
                  style: kDetailPageTitle,textAlign: TextAlign.start,
                ),
              ),
              Positioned(
                top: 25,
                right: 25,
                child: RoundedStarButton(
                  icon: (!movie.isFav)
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
                  onPressed: (){onPressStar();},
                ),
              ),
              Positioned(
                top: 25,
                left: 25,
                child: RoundedRating(movieRating: '${movie.voteAverage}',height: 60,width: 60,fontSize: 25,),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              movie.overview,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MovieDetailHorizontal extends StatefulWidget {
  final Movie movie;
  const MovieDetailHorizontal({Key? key,required this.movie}) : super(key: key);

  @override
  _MovieDetailHorizontalState createState() => _MovieDetailHorizontalState();
}

class _MovieDetailHorizontalState extends State<MovieDetailHorizontal> {
  late Movie movie;

  @override
  void initState() {
    super.initState();
    movie = widget.movie;
  }

  void onPressStar(){
    setState(() {
      if(movie.isFav){
        movie.isFav = false;
      }else{
        movie.isFav = true;
      }
    });
    log('${movie.isFav}');
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
      Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: CachedNetworkImage(imageUrl: '$kImageBaseUrl$kBigPosterSize${movie.posterPath}',
              placeholder: (context,url) =>const BlurHash(hash: 'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: RoundedStarButton(
              height: 45,
              width: 45,
              icon: (!movie.isFav)
                  ? const Icon(
                Icons.star_border_rounded,
                color: Colors.black,
                size: 45,
              )
                  : const Icon(
                Icons.star_rounded,
                color: Colors.yellow,
                size: 45,
              ),
              onPressed: (){onPressStar();},
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: RoundedRating(movieRating: '${movie.voteAverage}',fontSize: 25,width: 45,height: 45,),
          )
        ],
      ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(movie.title,style: kDetailPageTitle),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    movie.overview,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

