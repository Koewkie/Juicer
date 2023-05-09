class Favs {
  int _id = 0;
  String _name = '';
  double _volume = 0;
  double _finStrength = 0;
  double _vg = 0;
  double _pg = 0;
  double _flavour = 0;
  double _nicotine = 0;

  Favs(this._name, this._volume, this._finStrength, this._vg, this._pg,
      this._flavour, this._nicotine);

  String get name => _name;
  double get volume => _volume;
  double get finstrenght => _finStrength;
  double get vg => _vg;
  double get pg => _pg;
  double get flavour => _flavour;
  double get nicotine => _nicotine;

  set name(String newName) {
    this._name = newName;
  }

  set volume(double newvolume) {
    this._volume = newvolume;
  }

  set finstrength(double newfinstrength) {
    this._finStrength = newfinstrength;
  }

  set vg(double newvg) {
    this._vg = newvg;
  }

  set pg(double newpg) {
    this._pg = newpg;
  }

  set flavour(double newflavour) {
    this._flavour = newflavour;
  }

  set nicotine(double newnicotine) {
    this._nicotine = newnicotine;
  }

  //Convert from Favs object to map object

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id == null) {
      map['id'] = _id;
    }

    map['name'] = _name;
    map['volume'] = _volume;
    map['finStrength'] = _finStrength;
    map['vg'] = _vg;
    map['pg'] = _pg;
    map['flavour'] = _flavour;
    map['nicotine'] = _nicotine;

    return map;
  }

  //Extract Favs from map

  Favs.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._volume = map['volume'];
    this._finStrength = map['finStrength'];
    this._vg = map['vg'];
    this._pg = map['pg'];
    this._flavour = map['flavour'];
    this._nicotine = map['nicotine'];
  }
}
