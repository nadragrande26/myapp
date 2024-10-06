import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'InvestYuk',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: LoginScreen(), // Menggunakan LoginScreen sebagai halaman awal
    );
  }
}

class UMKM {
  String name;
  String location;
  String performance;

  UMKM({
    required this.name,
    required this.location,
    required this.performance,
  });
}

class HomeController extends GetxController {
  RxString username = ''.obs; // Menyimpan username
  RxInt balance = 1000000.obs;

  // List contoh berita
  RxList<String> news = <String>[
    'Investasi Saham Terbaik Tahun Ini',
    'Tips Memaksimalkan Return Investasi Anda',
    'Kenali Risiko di Pasar Saham',
    'Peluang Investasi di Sektor Teknologi',
    'Cara Mudah Diversifikasi Portofolio'
  ].obs;

  // List contoh UMKM
  RxList<UMKM> umkms = <UMKM>[
    UMKM(name: 'UMKM A: Makanan Sehat', location: 'Jakarta', performance: 'Baik'),
    UMKM(name: 'UMKM B: Produk Kerajinan Tangan', location: 'Bali', performance: 'Sedang'),
    UMKM(name: 'UMKM C: Fashion Ramah Lingkungan', location: 'Bandung', performance: 'Baik'),
    UMKM(name: 'UMKM D: Teknologi Pertanian', location: 'Yogyakarta', performance: 'Sangat Baik'),
    UMKM(name: 'UMKM E: Katering Sehat', location: 'Surabaya', performance: 'Baik'),
  ].obs;
}

class MainScreen extends StatelessWidget {
  final HomeController homeController = Get.find<HomeController>(); // Mengambil instance HomeController
  RxInt currentIndex = 0.obs; // Menyimpan indeks halaman saat ini

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        switch (currentIndex.value) {
          case 0:
            return WelcomeScreen();
          case 1:
            return UmkmSearchScreen();
          case 2:
            return ProfileScreen();
          default:
            return WelcomeScreen();
        }
      }),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Cari',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        currentIndex: currentIndex.value,
        selectedItemColor: Colors.green,
        onTap: (int index) {
          currentIndex.value = index; // Perbarui indeks halaman saat ini
        },
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController()); // Inisialisasi HomeController
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Simulasi login, ganti logika ini sesuai kebutuhan
                homeController.username.value = usernameController.text;
                Get.to(MainScreen()); // Navigasi ke MainScreen setelah login
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Get.to(RegisterScreen()); // Navigasi ke halaman register
              },
              child: const Text('Daftar'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                // Aksi untuk Pusat Bantuan
                Get.defaultDialog(
                  title: 'Pusat Bantuan',
                  content: const Text('Jika Anda memiliki pertanyaan, silakan hubungi kami di support@investyuk.com.'),
                );
              },
              child: const Text('Pusat Bantuan'),
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Simulasi register, ganti logika ini sesuai kebutuhan
                Get.back(); // Kembali ke halaman login setelah register
                Get.snackbar('Pendaftaran', 'Registrasi berhasil! Silakan login.');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('Daftar'),
            ),
          ],
        ),
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  final HomeController homeController = Get.find<HomeController>(); // Mengambil instance HomeController

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beranda - InvestYuk'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Obx(() => Text(
              'Selamat Datang, ${homeController.username.value}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            )),
            const SizedBox(height: 20),
            Obx(() => Text(
              'Saldo Anda: Rp ${homeController.balance.value}',
              style: const TextStyle(fontSize: 20),
            )),
            const SizedBox(height: 30),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Get.to(DepositScreen());
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.attach_money, size: 50, color: Colors.green),
                            SizedBox(height: 10),
                            Text(
                              'Deposit',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(WithdrawScreen());
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.money_off, size: 50, color: Colors.red),
                            SizedBox(height: 10),
                            Text(
                              'Withdraw',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(NewsScreen());
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.article, size: 50, color: Colors.blue),
                            SizedBox(height: 10),
                            Text(
                              'Berita',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(UmkmSearchScreen());
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.business_center, size: 50, color: Colors.orange),
                            SizedBox(height: 10),
                            Text(
                              'UMKM',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UmkmSearchScreen extends StatelessWidget {
  final HomeController homeController = Get.find<HomeController>(); // Mengambil instance HomeController

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cari UMKM'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          return ListView.builder(
            itemCount: homeController.umkms.length,
            itemBuilder: (context, index) {
              UMKM umkm = homeController.umkms[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  title: Text(umkm.name),
                  subtitle: Text('Lokasi: ${umkm.location}\nPerforma: ${umkm.performance}'),
                  isThreeLine: true,
                  onTap: () {
                    _showInvestmentDialog(context, umkm);
                  },
                ),
              );
            },
          );
        }),
      ),
    );
  }

  void _showInvestmentDialog(BuildContext context, UMKM umkm) {
    final TextEditingController investmentController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Investasi pada ${umkm.name}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Lokasi: ${umkm.location}'),
              Text('Performa: ${umkm.performance}'),
              TextField(
                controller: investmentController,
                decoration: const InputDecoration(
                  labelText: 'Jumlah Investasi',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                int investmentAmount = int.tryParse(investmentController.text) ?? 0;
                if (investmentAmount > 0) {
                  Get.find<HomeController>().balance.value -= investmentAmount; // Mengurangi saldo
                  Get.back(); // Menutup dialog
                  Get.snackbar('Sukses', 'Investasi sebesar Rp $investmentAmount telah berhasil dilakukan pada ${umkm.name}!');
                } else {
                  Get.snackbar('Error', 'Masukkan jumlah yang valid!');
                }
              },
              child: const Text('Investasi'),
            ),
            TextButton(
              onPressed: () {
                Get.back(); // Menutup dialog
              },
              child: const Text('Batal'),
            ),
          ],
        );
      },
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final HomeController homeController = Get.find<HomeController>(); // Mengambil instance HomeController

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Obx(() => Text(
              'Username: ${homeController.username.value}',
              style: const TextStyle(fontSize: 20),
            )),
            const SizedBox(height: 20),
            Obx(() => Text(
              'Saldo: Rp ${homeController.balance.value}',
              style: const TextStyle(fontSize: 20),
            )),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                _showEditProfileDialog(context); // Panggil dialog edit profil
              },
              child: const Text('Edit Profil'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Logout logic here
                Get.back(); // Kembali ke halaman login
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context) {
    final TextEditingController editController = TextEditingController();
    editController.text = homeController.username.value; // Set nilai awal dari TextEditingController

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Profil'),
          content: TextField(
            controller: editController,
            decoration: const InputDecoration(
              labelText: 'Nama Pengguna',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                homeController.username.value = editController.text; // Perbarui username
                Get.back(); // Tutup dialog
                Get.snackbar('Sukses', 'Nama profil berhasil diubah!'); // Tampilkan snackbar
              },
              child: const Text('Simpan'),
            ),
            TextButton(
              onPressed: () {
                Get.back(); // Tutup dialog
              },
              child: const Text('Batal'),
            ),
          ],
        );
      },
    );
  }
}

class DepositScreen extends StatelessWidget {
  final HomeController homeController = Get.find<HomeController>(); // Mengambil instance HomeController
  final TextEditingController amountController = TextEditingController();
  XFile? imageFile; // Menyimpan file gambar yang dipilih

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    imageFile = await picker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      Get.snackbar('Sukses', 'Gambar berhasil dipilih: ${imageFile!.name}');
    } else {
      Get.snackbar('Error', 'Gambar tidak dipilih!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deposit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: amountController,
              decoration: const InputDecoration(
                labelText: 'Jumlah Deposit',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage, // Panggil fungsi untuk memilih gambar
              child: const Text('Pilih Bukti Deposit'),
            ),
            const SizedBox(height: 20),
            if (imageFile != null) // Tampilkan gambar jika ada
              Column(
                children: [
                  Image.file(
                    File(imageFile!.path),
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ElevatedButton(
              onPressed: () {
                // Logika deposit
                if (amountController.text.isNotEmpty && imageFile != null) {
                  int amount = int.parse(amountController.text);
                  homeController.balance.value += amount; // Menambahkan saldo
                  Get.back(); // Kembali ke halaman utama
                  Get.snackbar('Sukses', 'Deposit berhasil sebesar Rp $amount');
                } else {
                  Get.snackbar('Error', 'Masukkan jumlah yang valid dan pilih gambar bukti deposit!');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('Deposit'),
            ),
          ],
        ),
      ),
    );
  }
}


  

class WithdrawScreen extends StatelessWidget {
  final HomeController homeController = Get.find<HomeController>(); // Mengambil instance HomeController
  final TextEditingController accountNameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  
  // Daftar bank untuk dropdown
  final List<String> banks = ['BCA', 'BNI', 'Mandiri', 'BRI'];
  String? selectedBank;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Withdraw'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Input untuk Nama Pemilik Rekening
            TextField(
              controller: accountNameController,
              decoration: const InputDecoration(
                labelText: 'Nama Pemilik Rekening',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            // Dropdown untuk Memilih Jenis Bank
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Pilih Bank',
                border: OutlineInputBorder(),
              ),
              items: banks.map((String bank) {
                return DropdownMenuItem<String>(
                  value: bank,
                  child: Text(bank),
                );
              }).toList(),
              onChanged: (String? value) {
                // Menyimpan pilihan bank
                selectedBank = value;
              },
              value: selectedBank,
              isExpanded: true,
              hint: const Text('Pilih Bank'), // Placeholder
            ),
            const SizedBox(height: 20),
            // Input untuk Jumlah Withdraw
            TextField(
              controller: amountController,
              decoration: const InputDecoration(
                labelText: 'Jumlah Withdraw',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            // Tombol Withdraw
            ElevatedButton(
              onPressed: () {
                // Logika withdraw
                if (accountNameController.text.isNotEmpty && selectedBank != null && amountController.text.isNotEmpty) {
                  int amount = int.parse(amountController.text);
                  if (amount <= homeController.balance.value) {
                    homeController.balance.value -= amount; // Mengurangi saldo
                    Get.back(); // Kembali ke halaman utama
                    Get.snackbar('Sukses', 'Withdraw sebesar Rp $amount ke rekening ${accountNameController.text} di bank $selectedBank berhasil.');
                  } else {
                    Get.snackbar('Error', 'Saldo tidak cukup!');
                  }
                } else {
                  Get.snackbar('Error', 'Mohon lengkapi semua field!');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('Withdraw'),
            ),
          ],
        ),
      ),
    );
  }
}

class NewsScreen extends StatelessWidget {
  final HomeController homeController = Get.find<HomeController>(); // Mengambil instance HomeController

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Berita'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          return ListView.builder(
            itemCount: homeController.news.length,
            itemBuilder: (context, index) {
              String newsItem = homeController.news[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  title: Text(newsItem),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}