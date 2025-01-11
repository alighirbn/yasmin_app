import 'package:flutter/material.dart';

class Category1Details extends StatelessWidget {
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  const Category1Details({
    Key? key,
    required this.colorScheme,
    required this.textTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('تفاصيل إضافية', textTheme, colorScheme),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'منزل أحلامك في انتظارك! وقد تم تصميم هذا المنزل بدقة ليجمع بين الفخامة والراحة، ويقع ضمن مجمع واحة الياسمين السكني، والذي يوفر بيئة مثالية للحياة العصرية. استمتع بمساحات واسعة، وإطلالة خلابة على بحر النجف، وخدمات شاملة تلبي كافة احتياجاتك. اجعل هذا المنزل خيارك الأمثل لحياة مليئة بالأناقة والرفاهية.',
            style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'بيوت الرقية هي الخيار الأمثل للعائلات التي تبحث عن تصميم يجمع بين الأناقة والعملية. تم بناء هذه المنازل على مساحة أرض 200 متر مربع بأبعاد 10×20 متر، ومساحة بناء إجمالية تبلغ 205.6 متر مربع موزعة على طابقين.',
            style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'تفاصيل الطابق الأرضي:',
            style: textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'جراج السيارات: أبعاده 3.75×5.75م.\n'
                'الحديقة الأمامية: أبعادها 5.75×5.75 م توفر مساحة خضراء جميلة.\n'
                'الحديقة الداخلية: أبعادها 2×5.85 م تضفي لمسة من الطبيعة على الداخل.\n'
                'المدخل الرئيسي: الأبعاد 1.5×2 م مع حمام للضيوف 1.5×1.7 م.\n'
                'غرفة الاستقبال: أبعادها 4×5.75 م، مما يوفر مساحة واسعة للضيوف.\n'
                'غرفة المعيشة: أبعادها 4×5.35 م مفتوحة على منطقة الاستقبال والحديقة الداخلية.\n'
                'غرفة النوم: أبعادها 3.5×6م بإطلالة على الحديقة الداخلية.\n'
                'المطبخ: أبعاده 3.5×5 م، مصمم مع أخذ التطبيق العملي والحداثة في الاعتبار.\n'
                'الحمام: أبعاده 1.5×2.35م.\n'
                'المساحات الإضافية: تشمل سلالم وموزع وبئر إضاءة مركزية حسب التصميم.',
            style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'تفاصيل الطابق الأول:',
            style: textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'غرفة النوم الرئيسية (الجناح): أبعادها 4×7.25م مع حمام خاص 1.5×2م.\n'
                'غرفة النوم الثانية (الجناح): أبعادها 3.5×5 م مع حمام خاص 1.5×1.7 م.\n'
                'الشرفة الخلفية: تشتمل على سلالم تؤدي إلى السطح.',
            style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'ميزات إضافية:',
            style: textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'يضمن التصميم المعاصر التدفق السلس للمساحات.\n'
                'مناظر خلابة للحدائق الداخلية والخارجية.\n'
                'مناطق مخصصة لكل فرد من أفراد الأسرة لضمان الراحة والخصوصية.',
            style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
          ),
        ),
        // Add images here if needed
        Image.asset(
          'assets/images/building_category_1.jpg', // Replace with your image path
          fit: BoxFit.cover,
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, TextTheme textTheme, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: textTheme.titleLarge?.copyWith(
          color: colorScheme.onPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}