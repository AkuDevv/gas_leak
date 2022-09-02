class Slide {
  final String imageUrl;
  final String title;
  final String description;

  Slide({
    required this.imageUrl,
    required this.title,
    required this.description,
  });
}

final slideList = [
  Slide(
    imageUrl: 'assets/images/logo_.png',
    title: 'Limiter le Danger',
    description: 'Notre but est de limiter le danger des fuites de gaz dans les domiciles',
  ),
  Slide(
    imageUrl: 'assets/images/logo_.png',
    title: 'Système Intelligent',
    description: 'Notre système est basé sur l’intelligence des choses (IoT), il sera installé dans les endroits où se trouve les sources de gaz',
  ),
  Slide(
    imageUrl: 'assets/images/logo_.png',
    title: 'Disponibilité',
    description: 'Notre service est valable 24/7, partout au Maroc',
  ),
];
