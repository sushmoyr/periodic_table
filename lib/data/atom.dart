class Atom {
  String? name;
  String? appearance;
  num? atomicMass;
  num? boil;
  String? category;
  num? density;
  String? discoveredBy;
  num? melt;
  num? molarHeat;
  String? namedBy;
  num? number;
  num? period;
  String? phase;
  String? source;
  String? spectralImg;
  String? summary;
  String? symbol;
  num? xPos;
  num? yPos;
  List<int>? shells;
  String? electronConfiguration;
  String? electronConfigurationSemantic;
  num? electronAffinity;
  num? electronegativityPauling;
  List<num>? ionizationEnergies;
  String? cpkHex;

  Atom(
      {this.name = '',
      this.appearance,
      this.atomicMass = 0,
      this.boil,
      this.category,
      this.density,
      this.discoveredBy,
      this.melt,
      this.molarHeat,
      this.namedBy,
      this.number,
      this.period,
      this.phase,
      this.source,
      this.spectralImg,
      this.summary,
      this.symbol,
      this.xPos,
      this.yPos,
      this.shells,
      this.electronConfiguration,
      this.electronConfigurationSemantic,
      this.electronAffinity,
      this.electronegativityPauling,
      this.ionizationEnergies,
      this.cpkHex = '000000'});

  Atom.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    appearance = json['appearance'];
    atomicMass = json['atomic_mass'];
    boil = json['boil'];
    category = json['category'];
    density = json['density'];
    discoveredBy = json['discovered_by'];
    melt = json['melt'];
    molarHeat = json['molar_heat'];
    namedBy = json['named_by'];
    number = json['number'];
    period = json['period'];
    phase = json['phase'];
    source = json['source'];
    spectralImg = json['spectral_img'];
    summary = json['summary'];
    symbol = json['symbol'];
    xPos = json['xpos'];
    yPos = json['ypos'];
    shells = json['shells'].cast<int>();
    electronConfiguration = json['electron_configuration'];
    electronConfigurationSemantic = json['electron_configuration_semantic'];
    electronAffinity = json['electron_affinity'];
    electronegativityPauling = json['electronegativity_pauling'];
    ionizationEnergies = json['ionization_energies'].cast<int>();
    cpkHex = json['cpk-hex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['appearance'] = appearance;
    data['atomic_mass'] = atomicMass;
    data['boil'] = boil;
    data['category'] = category;
    data['density'] = density;
    data['discovered_by'] = discoveredBy;
    data['melt'] = melt;
    data['molar_heat'] = molarHeat;
    data['named_by'] = namedBy;
    data['number'] = number;
    data['period'] = period;
    data['phase'] = phase;
    data['source'] = source;
    data['spectral_img'] = spectralImg;
    data['summary'] = summary;
    data['symbol'] = symbol;
    data['xpos'] = xPos;
    data['ypos'] = yPos;
    data['shells'] = shells;
    data['electron_configuration'] = electronConfiguration;
    data['electron_configuration_semantic'] = electronConfigurationSemantic;
    data['electron_affinity'] = electronAffinity;
    data['electronegativity_pauling'] = electronegativityPauling;
    data['ionization_energies'] = ionizationEnergies;
    data['cpk-hex'] = cpkHex;
    return data;
  }
}
