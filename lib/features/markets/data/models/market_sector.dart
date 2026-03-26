import 'stock_filter.dart';

class MarketSector {
  static final Map<Sector, String> sectorNames = {
    Sector.all: 'All',
    Sector.it: 'IT',
    Sector.banking: 'Banking',
    Sector.oilGas: 'Oil & Gas',
    Sector.pharma: 'Pharma',
    Sector.auto: 'Auto',
    Sector.fmcg: 'FMCG',
    Sector.finance: 'Finance',
    Sector.telecom: 'Telecom',
    Sector.metals: 'Metals',
    Sector.construction: 'Construction',
    Sector.realty: 'Realty',
  };

  static String getName(Sector sector) => sectorNames[sector] ?? sector.name;
}
