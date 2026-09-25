import 'package:flutter/material.dart';

void main() {
  runApp(const JibBankApp());
}

class JibBankApp extends StatelessWidget {
  const JibBankApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'جیب بانک',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFFF5F5F7),
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
  double walletBalance = 0.0;
  int miningLevel = 0;
  double baseReward = 0.000001;
  bool isMining = false;

  void startMining() {
    setState(() {
      isMining = true;
    });

    // شبیه‌سازی ماینینگ
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        double reward = baseReward * (1 << miningLevel);
        walletBalance += reward;
        miningLevel++;
        isMining = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('ماینینگ موفق! موجودی: ${walletBalance.toStringAsFixed(6)}'),
          backgroundColor: Colors.green,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('جیب بانک', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // کارت موجودی
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.deepPurple, Colors.purpleAccent],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Text('موجودی کیف پول',
                      style: TextStyle(color: Colors.white70, fontSize: 16)),
                  const SizedBox(height: 10),
                  Text(
                    '${walletBalance.toStringAsFixed(6)} JIB',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'سطح ماینینگ: $miningLevel',
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // دکمه ماینینگ
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: isMining ? null : startMining,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: isMining
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2),
                          ),
                          SizedBox(width: 10),
                          Text('در حال ماینینگ...',
                              style: TextStyle(fontSize: 18, color: Colors.white)),
                        ],
                      )
                    : const Text('⛏️ شروع ماینینگ',
                        style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 16),

            // دکمه برداشت
            SizedBox(
              width: double.infinity,
              height: 60,
              child: OutlinedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('درخواست برداشت ثبت شد')),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.deepPurple, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text('💸 درخواست برداشت',
                    style: TextStyle(fontSize: 18, color: Colors.deepPurple)),
              ),
            ),
            const SizedBox(height: 24),

            // لیست تراکنش‌ها
            const Align(
              alignment: Alignment.centerRight,
              child: Text('تاریخچه تراکنش‌ها',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Center(
                child: Text('هنوز تراکنشی وجود ندارد',
                    style: TextStyle(color: Colors.grey)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
