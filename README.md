# **PBP Tugas 9**

## **Nama**&emsp;: Muhammad Hadziq Razin
## **NPM** &nbsp;&emsp;: 2106707076
## **Kelas** &emsp;: D

#

<br>

# **📱 Apakah bisa kita melakukan pengambilan data JSON tanpa membuat model terlebih dahulu? Apakah lebih baik?**

**Bisa**, tetapi penyimpanan data menjadi **kurang terstruktur** dibandingkan dengan membuat model terlebih dahulu. Membuat model membuat program menjadi lebih rapi dan lebih OOP sehingga lebih intuitif dan mudah.
<br>
<br>


# **📱 Sebutkan widget apa saja yang kamu pakai di proyek kali ini dan jelaskan fungsinya**

Sama dengan tugas 7 & 8, ditambah beberapa widget lain yakni:
1. `Checkbox`: Membuat checkbox.

2. `Flexible`: _Wrap text_ agar _responsive_.

3. `CircularProgressIndicator`: Menambahkan _loading indicator_ ketika menunggu data dari Future.

4. `Border`: Menambahkan _outline_ pada BoxDecoration Container.

5. `FutureBuilder`: Membuat _snapshot_ dari data yang di-_fetch_ oleh _method_ Future.
<br>
<br>

# **📱 Jelaskan mekanisme pengambilan data dari json hingga dapat ditampilkan pada Flutter**

1. Menambahkan _dependency_ `http` agar bisa melakukan _method_ get(). Caranya dengan menjalankan perintah berikut.
    ```
    flutter pub add http
    ```
2. Membuat fungsi Future untuk mengambil _snapshot_ data dari _url_ yang diinginkan. Fungsi ini dibuat pada file terpisah `get_my_watch_list.dart`.
    ```Dart
    Future<List<WatchList>> fetchWatchList() async {
        var url = Uri.parse('http://pbp-tugas2-hadziq.herokuapp.com/mywatchlist/json/');
        var response = await http.get(
            url,
            headers: {
            "Content-Type": "application/json",
            },
        );

        // melakukan decode response menjadi bentuk json
        var data = jsonDecode(utf8.decode(response.bodyBytes));

        // melakukan konversi data json menjadi object WatchList
        List<WatchList> listWatchList = [];
        for (var d in data) {
            if (d != null) {
            listWatchList.add(WatchList.fromJson(d));
            }
        }

        return listWatchList;
    }
    ```
    Pertama-tama _url_ diubah menjadi Uri, kemudian di-_fetch_ dan _response_ yang didapat di-_decode_ menjadi bentuk json. Data yang sudah di-_decode_ kemudian dimasukkan ke dalam List. Selanjutnya List ditampilkan menggunakan FutureBuilder yang ada di file `my_watch_list.dart`.
    ```Dart
    body: FutureBuilder(
        future: futureData,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(
              ...
            );
          } else {
            if (!snapshot.hasData) {
              return Column(
                ...
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index)=> InkWell(
                  onTap: () {
                    ...
                  },
                  child: Container(
                    ...
                    ),
                    child: Align(
                      ...
                      child: Row(
                        ...
                        children: [
                          Flexible(
                            child: Text(
                              "${snapshot.data![index].fields.title}",
                            )
                          ),
                          ...
    ```
<br>
<br>

# **📱 Cara Mengimplementasikan Langkah-Langkah Pengerjaan Tugas 9**

**✅ Menambahkan drawer/hamburger menu pada app yang telah dibuat sebeumnya**

Membuat file beranama `drawer.dart` kemudian menggunakannya dengan cara berikut.
```Dart
return scaffold(
    ...
    drawer: const DrawerTugas(),
    ...
)
```
<br>
<br>

**✅  Membuat satu file dart yang berisi model mywatchlist.**

Membuat file pada folder model dengan nama `watch_list.dart`. Model WatchList mempunyai atribut `pk` dan `fields`, sedangkan `fields` memiliki atribut `watched`, `title`, `rating`, `releaseDate`, `review`.
<br>
<br>

**✅ Menambahkan halaman mywatchlist**

Membuat file `my_watch_list.dart` kemudian mengisinya dengan _widget_-_widget_ yang menampilkan data yang disimpan di List yang sudah diisi fungsi Future. Contoh kode sudah ditunjukkan di atas.
<br>
<br>

**✅ Membuat navigasi dari setiap judul watch list ke halaman detail**

Menambahkan _widget_ `InkWell` untuk mendeteksi _gesture_ dari _user_.
```Dart
InkWell(
    onTap: () {
        ...
    },
    child: Container(
        ...
    )
)
```
<br>
<br>

**✅ Menambahkan halaman detail untuk setiap mywatchlist**

Membuat file `detail.dart`. Page `detail.dart` akan dipanggil dengan parameter `watched`, `title`, `rating`, `releaseDate`, `review` dari film yang ditekan _user_. Kemudian masing-masing parameter disimpan di suatu variabel kemudian ditampilkan menggunakan _widget_ yang dibutuhkan.
```Dart
onTap: () {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyDetailPage(
                title: snapshot.data![index].fields.title,
                releaseDate: snapshot.data![index].fields.releaseDate,
                rating: snapshot.data![index].fields.rating,
                watched: snapshot.data![index].fields.watched,
                review: snapshot.data![index].fields.review,
            )
        )
    );
},
```
<br>
<br>

**✅ Menambahkan tombol untuk kembali ke daftar mywatchlist**
Menambahkan _widget_ `TextButton` pada halaman detail.
```Dart
TextButton(
    style: TextButton.styleFrom(
        ...
    ),
    onPressed: () {
        Navigator.pop(context);
    },
    child: const Text(
        'Back',
        ...
    ),
),
```
<br>
<br>

**🔱 BONUS:**<br>

**✅ Menambahkan checkbox pada setiap watchlist pada halaman mywatchlist. Dimana checkbox akan tercentang jika status ditonton bernilai true dan tidak jika bernilai false**

Menambahkan _widget_ `CheckBox` pada halaman MyWatchList.
```Dart
Checkbox(value: (snapshot.data![index].fields.watched == 'Already'),
    activeColor: Colors.green,
    onChanged: (bool? value) {
        setState(() {
            snapshot.data![index].fields.watched = (value!) ? 'Already' : "Haven't";
        });
    }
),
```
<br>
<br>

**✅ Menambahkan warna untuk outline pada setiap mywatchlist pada halaman mywatchlist berdasarkan status ditonton (Dua warna yang dipilih bebas)**

Menambahkan _widget_ Border pada BorderDecoration Container yang menampilkan daftar film.
```Dart
Border.all(
    color: (snapshot.data![index].fields.watched == 'Already') ?
        Colors.greenAccent : redPrimary,
    width: 3.0
),
```
<br>
<br>

**✅ Refactor function fetch data dari web service ke sebuah file terpisah.**

Membuat folder `utils` kemudian di dalamnya membuat file `get_my_watch_list.dart` yang berisi fungsi Future yang sudah ditunjukkan di atas. Fungsi ini bisa dipanggil pada halaman MyWatchList dengan meng-_import_-nya terlebih dahulu. Fungsi dipanggil saat InitState halaman MyWatchList agar datanya bisa diubah-ubah secara lokal (tidak terus-menerus _refresh_).
```Dart
import 'package:counter_7/utils/get_my_watch_list.dart';
```
```Dart
late Future<List<WatchList>> futureData;
@override
void initState() {
    super.initState();
    futureData = fetchWatchList();
}
```
<br>
<br>

# **PBP Tugas 8**

## **Nama**&emsp;: Muhammad Hadziq Razin
## **NPM** &nbsp;&emsp;: 2106707076
## **Kelas** &emsp;: D

#

<br>

# **📱 `Navigator.push` dan `Navigator.pushReplacement`**

**`Navigator.push`**

Menambahkan suatu halaman baru ke dalam _stack_ halaman yang diatur oleh _widget_ Navigator.
<br>
<br>

**`Navigator.pushReplacement`**

Mengganti halaman saat ini (_top of stack_) dengan suatu halaman baru.
<br>
<br>


![page-transition-stack2 drawio](https://user-images.githubusercontent.com/88391977/202354670-196e8c55-4b8b-427c-86ee-d84fc6f5aa1d.png)

sumber gambar: https://www.technicalfeeder.com/2021/11/flutter-page-transition/
<br>
<br>


# **📱 Widget apa saja yang dipakai di proyek ini dan penjelasannya**

Sama dengan tugas 7, ditambah beberapa widget lain yakni:
1. `Budget`: Objek _card_ untuk ditampilkan yang menyimpan data _input_ dari _user_.

2. `MyFormPage`: halaman yang menampilkan form untuk _user_ meng-_input_ data.

3. `TextFormField`: Tempat _input_ yang _value_-nya berupa `String`.

4. `DropDownButtonFormField`: _Button_ untuk menampilkan pilihan _dropdown_.

5. `TextButton`: _Button_ berupa teks yang bisa diatur _behaviour_-nya ketika ditekan.

6. `Drawer` _Widget_ untuk menyembunyikan _tools_-_tools_ layaknya sebuah laci.

7. `Navigator`: _Widget_ untuk menavigasi halaman aplikasi.

8. `DrawerTugas`: _Drawer_ sesuai ketentuan soal yang saya buat agar bisa dipakai dengan mudah di halaman-halaman aplikasi.

9. `Expanded`: Mengisi baris atau kolom yang kosong.

10. `ListTile`: Menampung _widget_ dalam sebuah list.
<br>
<br>

# **📱 Jenis-Jenis Event di Flutter**

1. `onEnter`
2. `onExit`
3. `onHover`
4. `onPressed`
5. `onSaved`
6. `onChanged`
<br>
<br>

# **📱 Cara Navigator dalam mengganti "Halaman" pada Flutter**

Menggunakan _stack_ sebagai tempat menyimpan halaman. Halaman baru yang ditambahkan bisa dengan menambah tumpukan _stack_ atau mengganti _top of stack_ . Jika ingin ke halaman lama bisa dengan pop() _stack_.
<br>
<br>

# **📱 Cara Mengimplementasikan Langkah-Langkah Pengerjaan Tugas 8**

**✅ Menambahkan drawer/hamburger menu pada app yang telah dibuat sebeumnya**

Membuat file beranama `drawer.dart` kemudian menggunakannya dengan cara berikut:
```
return scaffold(
    ...
    drawer: const DrawerTugas(),
    ...
)
```
<br>

**✅  Menambahkan tiga tombol navigasi pada drawer/hamburger**

Dengan cara menggunakan _widget_ ListTile seperti pada file `drawer.dart`.
<br>

**✅ Menambahkan halaman form**

Membuat file `form.dart` kemudian mengisinya dengan _widget_-_widget_ Input Field sesuai yang diinginkan.
<br>

**✅ Menambahkan halaman data budget**

Menampilkan List Widget yang ada pada `form.dart` dalam sebuah _widget_ ListView.

**✅ Bonus: Menambahkan Date Picker**<br>

Menambahkan TextFormField yang berisi date input menggunakan dependencies `intl: ^0.17.0`. Cara penggunaannya saya dapat dari website ini: https://www.fluttercampus.com/guide/39/how-to-show-date-picker-on-textfield-tap-and-get-formatted-date/#dart-code-to-show-date-picker-in-flutter .
<br>

# **PBP Tugas 7**

## **Nama**&emsp;: Muhammad Hadziq Razin
## **NPM** &nbsp;&emsp;: 2106707076
## **Kelas** &emsp;: D

#

<br>

# **📱 Stateless Widget & Stateful Widget**

_State_ dalam Flutter bagaikan data yang tersimpan dan dibutuhkan untuk membuat _user interface_ (UI) aplikasi kita. State ini dapat berubah-ubah sepanjang eksekusi aplikasi. _Widget_ yang digunakan dalam Flutter dapat memiliki parameter berupa data (_state_) sebagai properti (contohnya tampilan _widget_) dari _widget_ tersebut. Oleh karena itu, _widget_ dibagi menjadi dua tipe, yaitu Stateless Widget dan Stateful Widget.
<br>
<br>

**Stateless Widget**

Adalah _widget_ yang _state_-nya tidak bisa berubah ketika aplikasi sudah dijalankan. Contoh Stateless Widget dalam aplikasi ini adalah _text_ judul "PBP Tugas 7" dan _icon button_ "+" dan "-". Ketiganya tidak akan berubah sepanjang aplikasi dijalankan.
<br>
<br>

**Stateful Widget**

Adalah _widget_ yang _state_-nya dapat berubah-ubah ketika aplikasi berjalan, oleh karena itu tampilan atau fungsi _widget_-nya pun berubah. Salah satu contoh hal yang dapat mengubah _state_ adalah ketika _user_ melakukan interaksi dengan aplikasi kita seperti menekan _button_. Contoh Sateful Widget dalam aplikasi ini adalah _text_ keterangan "GANJIL" atau "GENAP", _text_ angka _counter_, _visibility button_ "-" dan fungsinya ketika _counter_ bernilai 0.
<br>
<br>
<img width="200" alt="Screen Shot 2022-11-10 at 06 03 53" src="https://user-images.githubusercontent.com/88391977/200960967-bb6d45c0-98cc-4265-ae48-50266a6a497f.png"> <img width="200" alt="Screen Shot 2022-11-10 at 06 04 12" src="https://user-images.githubusercontent.com/88391977/200961054-b2649a73-c9a4-42cb-923f-dc8c8495949c.png">

<br>
<br>

# **📱 Widget apa saja yang dipakai di proyek ini dan penjelasannya**

1. `MaterialApp`: Menyediakan banyak `tools` atau `theme` untuk aplikasi.

2. `ThemeData`: Mengatur tema untuk keseluruhan aplikasi.

3. `MyHomePage`: Menampilkan halaman utama aplikasi kita.

4. `Scaffold`: Memiliki fungsionalitas dasar untuk MaterialApp seperti AppBar, FloatingActionButton, dll.

5. `AppBar`: Biasanya ada di paling atas yang menampilkan _title_ aplikasi, _toolbar_, _action buttons_, dll.

6. `Center`: Memposisikan _child widget_-nya agar berada di tengah layar.

7. `Column`: Memposisikan _child widget_-nya agar tersusun secara vertikal (kolom).

8. `Text`: Menampilkan _string_ teks.

9. `TextStyle`: Mengatur _styling_ dari `Text`.

10. `Padding`: Memberikan jarak antara _content_ dengan batas _container_.

11. `Row`: Memposisikan _child widget_-nya agar tersusun secara horizontal (baris).

12. `Visibility`: Mengatur apakah _child widget_-nya nampak atau tidak.

13. `FloatingActionButton`: _Button_ yang memiliki suatu _action_ (fungsi) yang tampil di atas _widget_ lainnya.

14. `Icon`: Menambahkan gambar ikon pada suatu _widget_.
<br>
<br>

# **📱 Fungsi `setState()` dan _variable_ yang terdampak**

`setState()` berfungsi untuk mengisyaratkan adanya _rebuild_ pada _widget_ yang memanggilnya secara _asynchronous_. Setelah kita meng-_update_ suatu data di aplikasi kita, kita bisa memanggil `setState()` untuk 'membuat ulang' _widget_ yang men-_trigger_-nya agar tampil sesuai data terkini. _Variable_ yang terdampak adalah _variable class_ `Widget()` yang memanggil `setState()`.
<br>
<br>

# **📱 Perbedaan antara `const` dan `final`**

`final` | `const`
--------| -------
Sekalinya suatu _value_ di-_assign_ ke _final variable_, _value_ itu tidak akan bsia berubah. | _value_ yang di-_assign_ ke _const variable_ dapat berubah atau dimodifikasi.
<br>
<br>

# **📱 Cara Mengimplementasikan Langkah-Langkah Pengerjaan Tugas 7**

**✅ Membuat sebuah program Flutter baru dengan nama counter_7**

Pada terminal, masuk ke direktori folder yang diinginkan untuk membuat aplikasi, lalu menjalankan perintah:
```
flutter create counter_7
```
<br>

**✅ Mengubah tampilan program menjadi seperti soal**

Inisiasi `home: MyHomPage()` dengan `title: 'Program Counter'`.
<br>
<br>

**✅ Mengimplementasikan logika berikut pada program**

1. **Tombol '+' menambahkan angka sebanyak satu satuan**

    Untuk logikanya sebagai berikut:
    ```
    void _incrementCounter() {
        setState(() {
            _counter++;
        });
    }
    ```

2. **Tombol '-' mengurangi angka sebanyak satu satuan. Apabila counter bernilai 0, maka tombol - tidak memiliki efek apapun pada counter**<br>
    Untuk logikanya sebagai berikut:
    ```
    void _decrementCounter() {
        setState(() {
            _counter--;
        });
    }
    ```
    Untuk tampilan kedua tombol di atas sebagai berikut:
    ```
    floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Visibility(
              visible: (_counter != 0) ? true : false,
              child: FloatingActionButton(
                onPressed: (_counter != 0) ? _decrementCounter : null,
                tooltip: 'Decrement',
                child: const Icon(Icons.remove),
              ),
            ),

            FloatingActionButton(
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          ],
        ),
      )
    ```

3. **Apabila counter bernilai ganjil, maka teks indikator berubah menjadi "GANJIL" dengan warna biru**

    Untuk logika dan tampilannya sebagai berikut:
    ```
    if (_counter % 2 != 0)
        const Text(
            'GANJIL',
            style: TextStyle(
                color: Colors.blue,
                fontSize: 15,
            )
        ),
    ```

4. **Apabila counter bernilai genap, maka teks indikator berubah menjadi "GENAP" dengan warna merah**

    Untuk logika dan tampilannya sebagai berikut:
    ```
    if (_counter % 2 == 0)
        const Text(
            'GENAP',
            style: TextStyle(
                color: Colors.red,
                fontSize: 15,
            )
        ),
    ```
<br>

**✅ Bonus: Menyembunyikan/menghilangkan tombol '-' apabila counter bernilai 0**<br>

Menambahkan _widget_ `Visibility()` pada _button_ '-' agar bisa kita atur status nampaknya.

Berikut tampilannya:
```
Visibility(
    visible: (_counter != 0) ? true : false,
    child: FloatingActionButton( 
        ...
    ),
),
```