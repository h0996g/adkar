bool isFirstTimeAdkar = true;
bool isFirstTimeQuran = true;
double sizeAdkarText = 26;
// ! hadi bh ndir compare bin version t3 App (1.0.1 m3a 1.0.3 mital )
int getExtendedVersionNumber(String version) {
  List versionCells = version.split('.');
  versionCells = versionCells.map((i) => int.parse(i)).toList();
  return versionCells[0] * 100000 + versionCells[1] * 1000 + versionCells[2];
}
