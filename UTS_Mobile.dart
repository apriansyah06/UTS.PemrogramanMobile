import 'dart:math';

abstract class Transportasi{
  String id, nama;
  double _tarifDasar;
  int kapasitas;

  Transportasi(this.id, this.nama, this._tarifDasar, this.kapasitas);

  double get tarifDasar => _tarifDasar;
  double hitungTarif(int jumlahPenumpang);

  void tampilInfo(){
    print("[$id] $nama - Kapasitas: $kapasitas, Tarif dasar: Rp$_tarifDasar");
  }
}

class Taksi extends Transportasi{
  double jarak;

  Taksi(String id, String nama, double tarifDasar, int kapasitas, this.jarak)
  :super(id, nama, tarifDasar, kapasitas);

  @override
  double hitungTarif(int jumlahPenumpang) =>tarifDasar * jarak;
}

class Bus extends Transportasi{
  bool adaWifi;

  Bus(String id, String nama, double tarifDasar, int kapasitas, this.adaWifi)
  :super(id, nama, tarifDasar, kapasitas);

  @override
  double hitungTarif(int jumlahPenumpang) => 
  (tarifDasar * jumlahPenumpang) + (adaWifi ? 5000 : 0);
}

class Pesawat extends Transportasi{
  String kelas;

  Pesawat(String id, String nama, double tarifDasar, int kapasitas, this.kelas)
  :super(id, nama, tarifDasar, kapasitas);

  @override
  double hitungTarif(int jumlahPenumpang) =>
  tarifDasar * jumlahPenumpang * (kelas == "Bisnis" ? 1.5 : 1.0);
}

class Pemesanan{
  String idPemesanan, namaPelanggan;
  Transportasi transportasi;
  int jumlahPenumpang;
  double totalTarif;

  Pemesanan(this.idPemesanan, this.namaPelanggan, this.transportasi, this.jumlahPenumpang, this.totalTarif);

  void cetakStruk(){
    print("\=== STRUK PEMESANAN ===");
    print("ID:$idPemesanan | Nama:$namaPelanggan");
    print("Transportasi: ${transportasi.nama}");
    print("Jumlah Penumpang:$jumlahPenumpang");
    print("Total:Rp${totalTarif.toStringAsFixed(0)}");
  }
}

Pemesanan buatPemesanan(Transportasi t, String nama, int jumlahPenumpang){
  var id= "PSN${Random().nextInt(9999).toString().toString().padLeft(4, '0')}";
  return Pemesanan(id, nama, t, jumlahPenumpang, t.hitungTarif(jumlahPenumpang));
}

void tampilSemuaPemesanan(List<Pemesanan>daftar){
  print("\n===DAFTAR PEMESANAN===");
  for (var p in daftar){
    p.cetakStruk();
    print("");
  }
  print("Total data: ${daftar.length}");
}

void main(){
  var taksi= Taksi("T01", "BlueBird", 7000, 4, 12);
  var bus= Bus("B01", "TransJakarta", 3500, 30, true);
  var pesawat= Pesawat("P01", "Garuda Indonesia", 800000, 150, "Bisnis");

  var daftar=[
    buatPemesanan(taksi, "Rizky", 1), 
    buatPemesanan(bus, "Dewi", 5),
    buatPemesanan(pesawat, "Andi", 2),
  ];

  tampilSemuaPemesanan(daftar);
}