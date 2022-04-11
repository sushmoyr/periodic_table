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
  num? xpos;
  num? ypos;
  List<int>? shells;
  String? electronConfiguration;
  String? electronConfigurationSemantic;
  num? electronAffinity;
  num? electronegativityPauling;
  List<num>? ionizationEnergies;
  String? cpkHex;

  Atom(
      {this.name,
      this.appearance,
      this.atomicMass,
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
      this.xpos,
      this.ypos,
      this.shells,
      this.electronConfiguration,
      this.electronConfigurationSemantic,
      this.electronAffinity,
      this.electronegativityPauling,
      this.ionizationEnergies,
      this.cpkHex});

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
    xpos = json['xpos'];
    ypos = json['ypos'];
    shells = json['shells'].cast<int>();
    electronConfiguration = json['electron_configuration'];
    electronConfigurationSemantic = json['electron_configuration_semantic'];
    electronAffinity = json['electron_affinity'];
    electronegativityPauling = json['electronegativity_pauling'];
    ionizationEnergies = json['ionization_energies'].cast<int>();
    cpkHex = json['cpk-hex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['appearance'] = this.appearance;
    data['atomic_mass'] = this.atomicMass;
    data['boil'] = this.boil;
    data['category'] = this.category;
    data['density'] = this.density;
    data['discovered_by'] = this.discoveredBy;
    data['melt'] = this.melt;
    data['molar_heat'] = this.molarHeat;
    data['named_by'] = this.namedBy;
    data['number'] = this.number;
    data['period'] = this.period;
    data['phase'] = this.phase;
    data['source'] = this.source;
    data['spectral_img'] = this.spectralImg;
    data['summary'] = this.summary;
    data['symbol'] = this.symbol;
    data['xpos'] = this.xpos;
    data['ypos'] = this.ypos;
    data['shells'] = this.shells;
    data['electron_configuration'] = this.electronConfiguration;
    data['electron_configuration_semantic'] =
        this.electronConfigurationSemantic;
    data['electron_affinity'] = this.electronAffinity;
    data['electronegativity_pauling'] = this.electronegativityPauling;
    data['ionization_energies'] = this.ionizationEnergies;
    data['cpk-hex'] = this.cpkHex;
    return data;
  }
}
