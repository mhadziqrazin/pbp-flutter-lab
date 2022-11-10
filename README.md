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

1. `Scaffold`: Memiliki fungsionalitas dasar untuk MaterialApp seperti AppBar, FloatingActionButton, dll.

2. `AppBar`: Biasanya ada di paling atas yang menampilkan _title_ aplikasi, _toolbar_, _action buttons_, dll.

3. `Center`: Memposisikan _child widget_-nya agar berada di tengah layar.

4. `Column`: Memposisikan _child widget_-nya agar tersusun secara vertikal (kolom).

5. `Text`: Menampilkan _string_ teks.

6. `TextStyle`: Mengatur _styling_ dari `Text`.

7. `Padding`: Memberikan jarak antara _content_ dengan batas _container_.

8. `Row`: Memposisikan _child widget_-nya agar tersusun secara horizontal (baris).

9. `Visibility`: Mengatur apakah _child widget_-nya nampak atau tidak.

10. `FloatingActionButton`: _Button_ yang memiliki suatu _action_ (fungsi) yang tampil di atas _widget_ lainnya.

11. `Icon`: Menambahkan gambar ikon pada suatu _widget_.
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