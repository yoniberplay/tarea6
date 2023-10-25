import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class momentos_view extends StatefulWidget {
  @override
  _momentos_view createState() => _momentos_view();
}

class _momentos_view extends State<momentos_view> {
  final List<PhotoInfo> photos = [
    PhotoInfo(
        title: 'Raymond se entrega al FBI',
        imageUrl: 'assets/momento1.png',
        detalle:
            'Raymond Reddington, uno de los fugitivos más buscados, se entrega misteriosamente al FBI con una oferta muy especial: ayudará a atrapar a todo el que haya trabajado con él con la condición de hablar únicamente con la agente Elizabeth Keen.',
        controller: VideoPlayerController.asset('assets/momento1.mp4')),
    PhotoInfo(
        title: 'Muerte de Elizabeth Keen',
        imageUrl: 'assets/momento2.png',
        detalle:
            'Liz cayó al suelo, vio su vida destellar ante sus ojos: recuerdos agridulces de Tom, Agnes, Dembe, Aram, Cooper y Ressler que se duplicaron como un tributo a los años de la actriz Boone en el programa.',
        controller: VideoPlayerController.asset('assets/momento2.mp4')),
    PhotoInfo(
        title: 'Muerte de Raymond',
        imageUrl: 'assets/momento3.png',
        detalle:
            'Reddington y las últimas imágenes lo muestran caminando en la naturaleza y encontrándose con un toro que lo ataca. Luego, en la pantalla vemos un helicóptero aterrizando en el campo y Donald Ressler (Diego Klattenhoff), que está a bordo, ve el cuerpo ensangrentado y sin vida de Reddington.',
        controller: VideoPlayerController.asset('assets/momento3.mp4')),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: ListView.builder(
          itemCount: photos.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PhotoDetailScreen(photo: photos[index]),
                  ),
                );
              },
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      border: Border(
                          bottom: BorderSide(color: Colors.red, width: 2.0)),
                    ),
                    child: Text(photos[index].title,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  SizedBox(height: 2),
                  Image.asset(
                    photos[index].imageUrl,
                    width: 200,
                  ),
                  SizedBox(height: 17),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class PhotoDetailScreen extends StatelessWidget {
  final PhotoInfo photo;
  late VideoPlayerController controller;

  PhotoDetailScreen({super.key, required this.photo}) {
    controller = photo.controller;
    controller.initialize().then((_) {
      controller.play();
      controller.setLooping(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(photo.title,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: WillPopScope(
          onWillPop: () async {
            if (controller.value.isPlaying) {
              controller.pause();
            }
            return true;
          },
          child: Center(
            child: Container(
              color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        if (controller.value.isPlaying) {
                          controller.pause();
                        } else {
                          controller.play();
                        }
                      },
                      child: AspectRatio(
                        aspectRatio: controller.value.aspectRatio,
                        child: VideoPlayer(controller),
                      )),
                  const SizedBox(height: 20),
                  Text(photo.detalle,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                ],
              ),
            ),
          )),
    );
  }
}

class PhotoInfo {
  final String title;
  final String imageUrl;
  final String detalle;
  final VideoPlayerController controller;

  PhotoInfo(
      {required this.title,
      required this.imageUrl,
      required this.detalle,
      required this.controller});
}
