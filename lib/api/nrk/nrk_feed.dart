enum NRKFeed implements Comparable<NRKFeed> {
  toppsaker(
    name: 'Toppsaker',
    url: 'https://www.nrk.no/toppsaker.rss',
  ),
  siste(
    name: 'Siste',
    url: 'https://www.nrk.no/nyheter/siste.rss',
  ),
  innenriksMyheter(
    name: 'Innenriks',
    url: 'https://www.nrk.no/norge/toppsaker.rss',
  ),
  urix(
    name: 'Urix',
    url: 'https://www.nrk.no/urix/toppsaker.rss',
  ),
  nrkSapmi(
    name: 'NRK Sápmi',
    url: 'https://www.nrk.no/sapmi/oddasat.rss',
  ),
  nrkSport(
    name: 'NRK Sport',
    url: 'https://www.nrk.no/sport/toppsaker.rss',
  ),
  kultur(
    name: 'Kultur',
    url: 'https://www.nrk.no/kultur/toppsaker.rss',
  ),
  livsstil(
    name: 'Livsstil',
    url: 'https://www.nrk.no/livsstil/toppsaker.rss',
  ),
  viten(
    name: 'Viten',
    url: 'https://www.nrk.no/viten/toppsaker.rss',
  ),
  dokumentar(
    name: 'Dokumentar',
    url: 'https://www.nrk.no/dokumentar/toppsaker.rss',
  ),
  ytring(
    name: 'Ytring',
    url: 'https://www.nrk.no/ytring/toppsaker.rss',
  );

  const NRKFeed({
    required this.name,
    required this.url,
  });

  final String name;
  final String url;

  @override
  int compareTo(NRKFeed other) => url.compareTo(other.url);
}
