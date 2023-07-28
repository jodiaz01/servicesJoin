import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PasaSlider extends StatelessWidget {
  const PasaSlider(
      {super.key,
        required this.lislider,
        required this.colorPrimario,
        required this.colorSecundario,
        this.toppage = false,
        required this.sizepuntoPrimario,
        required this.sizepuntoSecundar});
  final double sizepuntoPrimario;
  final double sizepuntoSecundar;
  final List<Widget> lislider;
  final Color colorPrimario;
  final Color colorSecundario;
  final bool toppage;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _SlideshowModel(),
      child: SafeArea(
        child: Center(child: Builder(builder: (BuildContext context) {
          Provider.of<_SlideshowModel>(context).colorPrimario = colorPrimario;
          Provider.of<_SlideshowModel>(context).colorSecundario =
              colorSecundario;
          Provider.of<_SlideshowModel>(context).sizepuntoPrimario =
              sizepuntoPrimario;

          return _EstructuraSlider(toppage: toppage, lislider: lislider);
        })),
      ),
    );
  }
}

class _EstructuraSlider extends StatelessWidget {
  final bool toppage;
  final List<Widget> lislider;

  const _EstructuraSlider({required this.lislider, required this.toppage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (toppage) _Puntos(lislider.length),
        Expanded(child: _Slides(lislider)),
        if (!toppage) _Puntos(lislider.length),
      ],
    );
  }
}

class _Puntos extends StatelessWidget {
  final int totalSlides;
  const _Puntos(this.totalSlides);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(totalSlides, (i) => Punto(i))),
    );
  }
}

class Punto extends StatelessWidget {
  final int index;
  const Punto(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<_SlideshowModel>(context);
    Color color;
    double sizedot = 10;
    if (provider.currentPage >= index - 0.5 &&
        provider.currentPage < index + 0.5) {
      color = provider.colorPrimario;
      sizedot = provider.sizepuntoPrimario;
    } else {
      color = provider.colorSecundario;
      sizedot = provider.sizepuntoSecundar;
    }
    return Container(
      width: sizedot,
      height: sizedot,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _Slides extends StatefulWidget {
  final List<Widget> lislides;
  const _Slides(this.lislides);

  @override
  State<_Slides> createState() => __SlidesState();
}

class __SlidesState extends State<_Slides> {
  final pageControlller = PageController();

  @override
  void initState() {
    pageControlller.addListener(() {
      Provider.of<_SlideshowModel>(context, listen: false).currentPage =
      pageControlller.page!;
    });
    super.initState();
  }

  @override
  void dispose() {
    pageControlller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView(
        controller: pageControlller,
        children: widget.lislides.map((e) => Slide(e)).toList(),
      ),
    );
  }
}

class Slide extends StatelessWidget {
  final Widget slides;

  const Slide(this.slides, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: double.infinity,
      height: double.infinity,
      // padding: const EdgeInsets.all(25),
      child: slides,
    );
  }

}

class _SlideshowModel with ChangeNotifier {
  double _currentPage = 0;
  Color _colorPrimario = Colors.blue;
  Color _colorSecundario = Colors.grey;

  double get currentPage => _currentPage;
  Color get colorPrimario => _colorPrimario;
  Color get colorSecundario => _colorSecundario;

  set currentPage(double page) {
    _currentPage = page;
    notifyListeners();
  }

  set colorPrimario(Color color) {
    _colorPrimario = color;
  }

  set colorSecundario(Color color) {
    _colorSecundario = color;
  }

  double _sizepuntoPrimario = 10;
  double get sizepuntoPrimario => _sizepuntoPrimario;
  set sizepuntoPrimario(double size) {
    _sizepuntoPrimario = size;
  }

  double _sizepuntoSecundar = 10;
  double get sizepuntoSecundar => _sizepuntoSecundar;
  set sizepuntoSecundar(double size) {
    _sizepuntoSecundar = size;
  }
}
