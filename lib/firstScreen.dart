import 'dart:io'; // للتعامل مع الملفات في نظام التشغيل

import 'package:flutter/material.dart'; // المكتبة الأساسية للـ Flutter
import 'package:image_picker/image_picker.dart'; // مكتبة لالتقاط الصور من الكاميرا أو معرض الصور
import 'home/home_screen/home_page.dart'; // استيراد صفحة Home التي سننتقل إليها لاحقًا

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState(); // ينشئ كلاس الحالة للويدجت
// StatefulWidget مهم لأنه يسمح بتحديث واجهة المستخدم عند تغيير البيانات
}

// الفانكشن اللي هجيب بيها الصور
class _FirstScreenState extends State<FirstScreen> {

  ImagePicker picker = ImagePicker(); // كائن للتعامل مع اختيار الصور

  List<File>? selectedImage = []; // قائمة لتخزين الصور المختارة
  // من الأفضل تعريفها كـ List<File> selectedImage = []; بدون علامة ?

  // دالة لاختيار الصور من معرض الصور
  Future<void> imageSelector() async {
    List<XFile>? images = await picker.pickMultiImage(); // التقاط صور متعددة

    if (images != null && mounted) { // التحقق من أن الصور موجودة وأن الشاشة ما زالت مُركبة
      setState(() {
        // تحويل كل صورة XFile إلى File وإضافتها للقائمة
        selectedImage!.addAll(images.map((toElement) => File(toElement.path)).toList());
        // map تُطبق دالة على كل عنصر في القائمة وتُرجع قائمة جديدة
      });
    }
  }

  // متحكمات لحقول إدخال النص
  TextEditingController title = TextEditingController(); // للعنوان
  TextEditingController body = TextEditingController(); // للمحتوى

  @override
  void dispose() {
    // التخلص من الموارد عند إزالة الويدجت من شجرة الويدجت
    title.dispose(); // تحرير موارد متحكم العنوان
    body.dispose(); // تحرير موارد متحكم المحتوى
    super.dispose(); // استدعاء دالة dispose للكلاس الأب
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // يسمح للمحتوى بالامتداد خلف شريط التطبيق
      appBar: AppBar(
        backgroundColor: Colors.transparent, // شريط تطبيق شفاف
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background.jpg"), // صورة خلفية من الأصول
              fit: BoxFit.cover, // تغطي كامل المساحة
            )
        ),

        ////////////////////////////////////////////////////////////////////////
        child: ListView( // قائمة قابلة للتمرير عموديًا
          children: [
            SizedBox(height: 30), // مسافة علوية

            // تعبير شرطي: إذا كانت قائمة الصور فارغة يعرض زر الكاميرا الكبير، وإلا يعرض قائمة الصور مع زر كاميرا صغير
            selectedImage!.isEmpty ?
            Container(
              color: Colors.white38,
              height: 150,
              width: MediaQuery.of(context).size.width - 20, // عرض الشاشة ناقص 20
              child: IconButton(
                  onPressed: () {
                    imageSelector(); // استدعاء دالة اختيار الصور
                  },
                  icon: Icon(Icons.camera_alt)
              ),
            )
                :
            // تخطيط أفقي يعرض زر الكاميرا + الصور المختارة
            Row(
              children: [
                // زر الكاميرا الصغير
                Container(
                  color: Colors.white38,
                  height: 100,
                  width: 100,
                  child: IconButton(
                      onPressed: () {
                        imageSelector(); // استدعاء دالة اختيار الصور
                      },
                      icon: Icon(Icons.camera_alt)
                  ),
                ),

                // قائمة أفقية للصور المختارة
                SizedBox(
                  height: 100,
                  width: MediaQuery.of(context).size.width - 120, // عرض الشاشة ناقص 120
                  child: ListView(
                    scrollDirection: Axis.horizontal, // قائمة قابلة للتمرير أفقيًا

                    // تحويل كل ملف صورة إلى Widget
                    children: selectedImage!.map((toElement) => Stack(
                      children: [
                        // عرض الصورة
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Image.file(
                            toElement,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover, // تغطي كامل المساحة المخصصة
                          ),
                        ),
                        // زر حذف الصورة
                        IconButton(
                            onPressed: () {
                              setState(() {
                                selectedImage!.removeAt(selectedImage!.indexOf(toElement)); // حذف الصورة من القائمة
                              });
                            },
                            icon: Icon(Icons.cancel)
                        ),
                      ],
                    )).toList(), // تحويل Iterable إلى List
                  ),
                ),
              ],
            ),

            // حقل إدخال العنوان
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: title, // ربط بمتحكم العنوان
                decoration: InputDecoration(
                    hintText: "title", // نص تلميحي
                    border: OutlineInputBorder() // حدود الحقل
                ),
              ),
            ),

            // حقل إدخال المحتوى
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    controller: body, // ربط بمتحكم المحتوى
                    minLines: 3, // الحد الأدنى للأسطر
                    maxLines: 6, // الحد الأقصى للأسطر
                    decoration: InputDecoration(
                        hintText: "body", // نص تلميحي
                        border: OutlineInputBorder() // حدود الحقل
                    )
                )
            )
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save),
          onPressed: () {
            Navigator.push(
              context,
              // الانتقال إلى صفحة MyHomePage مع تمرير البيانات إليها
              MaterialPageRoute(
                  builder: (context) => MyHomePage(
                    title: title.text, // نص العنوان
                    body: body.text, // نص المحتوى
                    image: selectedImage, // قائمة الصور
                  )
              ),
            );
          }
      ),
    );
  }
}
