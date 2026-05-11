import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kontak App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController phoneController =
      TextEditingController();

  List<Map<String, String>> contacts = [
    {
      'name': 'Andi Saputra',
      'phone': '08123456789',
    },
    {
      'name': 'Budi Santoso',
      'phone': '08234567890',
    },
    {
      'name': 'Siti Aminah',
      'phone': '08345678901',
    },
  ];

  void addContact() {
    String name = nameController.text.trim();
    String phone = phoneController.text.trim();

    if (name.isEmpty || phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Nama dan Nomor HP wajib diisi',
          ),
        ),
      );
      return;
    }

    setState(() {
      contacts.add({
        'name': name,
        'phone': phone,
      });
    });

    nameController.clear();
    phoneController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Kontak berhasil ditambahkan',
        ),
      ),
    );
  }

  void deleteContact(int index) {
    setState(() {
      contacts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kontak App'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// INPUT NAMA
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Nama Kontak',
                prefixIcon: const Icon(Icons.person),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 12),

            /// INPUT NOMOR
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Nomor HP',
                prefixIcon: const Icon(Icons.phone),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: addContact,
                child: const Text(
                  'Tambah Kontak',
                ),
              ),
            ),

            const SizedBox(height: 24),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Daftar Kontak',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            /// LIST
            Expanded(
              child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final contact = contacts[index];

                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          contact['name']![0],
                        ),
                      ),
                      title: Text(
                        contact['name']!,
                      ),
                      subtitle: Text(
                        contact['phone']!,
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          deleteContact(index);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}