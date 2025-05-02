import 'dart:io'; // للتعامل مع ملفات النظام (مثل ملفات الصور)
import 'package:flutter/material.dart'; // المكتبة الأساسية للـ Flutter
import 'package:task1/firstScreen.dart'; // استيراد الشاشة الأولى للتنقل إليها
import 'package:task1/profile/profile_page/profile_page.dart'; // استيراد صفحة الملف الشخصي
import '../home_widget/home_widget.dart'; // استيراد الويدجت الخاصة بالصفحة الرئيسية

class MyHomePage extends StatelessWidget {
  final String? title; // العنوان القادم من الشاشة الأولى (FirstScreen)
  final String? body; // المحتوى القادم من الشاشة الأولى
  final List<File>? image; // قائمة الصور القادمة من الشاشة الأولى

  // منشئ الكلاس - يقبل العنوان والمحتوى والصور كمعاملات اختيارية
  const MyHomePage({this.image, this.title, this.body, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          // زر للانتقال إلى صفحة الملف الشخصي
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
            icon: Icon(Icons.account_box),
          ),
        ],
        title: Text("The ${title ?? "tree"}"), // يعرض العنوان أو كلمة "tree" إذا كان العنوان فارغًا
        centerTitle: true, // توسيط العنوان في شريط التطبيق
      ),
      body: SingleChildScrollView( // تتيح التمرير العمودي للمحتوى إذا كان طويلًا
        child: Column(
          children: [
            // تحقق من وجود صور - إذا لم توجد صور يعرض صورة افتراضية من الأصول
            image == null || image!.isEmpty
                ? Image.asset(
              "assets/tree.jpg", // صورة افتراضية
            )
                : Image.file(
              image![0], // عرض الصورة الأولى من القائمة المستلمة
              height: 300,
              fit: BoxFit.cover, // تغطي المساحة المخصصة بالكامل
              width: double.infinity, // عرض الصورة بعرض الشاشة كاملًا
            ),

            // صف يحتوي على أيقونات التفاعل (المفضلة والمشاركة)
            Row(
              mainAxisAlignment: MainAxisAlignment.end, // محاذاة العناصر لليمين
              children: [
                FavoriteIcon(), // ويدجت مخصص للإعجاب (موجود في ../home_widget/home_widget.dart)
                IconButton(onPressed: () {}, icon: Icon(Icons.share)), // زر المشاركة
              ],
            ),

            // عرض المحتوى النصي
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text(
                body ?? "no text the text no found", // عرض المحتوى أو نص افتراضي
                textAlign: TextAlign.justify, // محاذاة النص
                style: TextStyle(fontSize: 25), // حجم الخط
              ),
            ),

            // عرض الصور المتعددة - يعتمد على وجود الصور المستلمة
            image == null || image!.isEmpty
                ? Row( // إذا لم توجد صور، يعرض صور افتراضية للفصول
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Season(url: "assets/tree_fall.jpg", text: "fall"), // ويدجت مخصص من ../home_widget/home_widget.dart
                Season(url: "assets/tree_spring.jpg", text: "spring"),
              ],
            )
                : SizedBox( // إذا وجدت صور، يعرضها في شبكة
              height: 500,
              child: GridView.builder( // شبكة ديناميكية لعرض الصور
                itemCount: image!.length, // عدد العناصر في الشبكة
                itemBuilder: (context, index) => Image.file(
                  image![index], // عرض كل صورة في القائمة المستلمة
                  fit: BoxFit.cover,
                  height: 100,
                  width: 200,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // عدد الأعمدة في الشبكة
                  mainAxisSpacing: 10, // المسافة الرأسية بين العناصر
                  crossAxisSpacing: 10, // المسافة الأفقية بين العناصر
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FirstScreen()), // الانتقال إلى الشاشة الأولى
          );
        },
        child: Icon(Icons.next_plan),
      ),
    );
  }
}

// A tree is a majestic and vital part of nature, standing tall with its strong trunk and widespread branches. Its leaves, whether vibrant green in spring or golden in autumn, provide shade, oxygen, and beauty to the environment. Deep roots anchor it firmly in the soil, absorbing water and nutrients to sustain life. Birds, insects, and animals find shelter within its branches, making it a small ecosystem of its own. Whether in a dense forest or standing alone in a quiet field