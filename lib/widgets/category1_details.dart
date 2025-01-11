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
    return Directionality(
      textDirection: TextDirection.rtl, // Set text direction to RTL
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/bc10.jpg', // Replace with your image path
            fit: BoxFit.cover,
          ),
          _buildSectionHeader('تفاصيل إضافية', textTheme, colorScheme),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'منزل أحلامك في انتظارك! تم تصميم هذا المنزل بعناية فائقة ليجمع بين الفخامة والراحة، ويقع ضمن مجمع واحة الياسمين السكني الذي يوفر بيئة مثالية للحياة العصرية. استمتع بالتصميمات الواسعة والإطلالات الخلابة على بحر النجف والخدمات الشاملة التي تلبي كافة احتياجاتك. اجعل هذا المنزل خيارك الأمثل لحياة مليئة بالأناقة والفخامة.',
              style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
              textAlign: TextAlign.right, // Align text to the right
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'تعد منازل أحمد الخيار الأمثل للعائلات التي تبحث عن تصاميم عصرية ومخططات واسعة تلبي احتياجاتها اليومية، حيث تم بناء هذه المنازل على مساحة أرض تبلغ 250 متراً مربعاً بأبعاد 12.5×20 متراً مربعاً، بمساحة بناء إجمالية تبلغ 258.5 متراً مربعاً موزعة على طابقين.',
              style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
              textAlign: TextAlign.right, // Align text to the right
            ),
          ),
          Image.asset(
            'assets/bc12.jpg', // Replace with your image path
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'تفاصيل الطابق الأرضي:',
              style: textTheme.titleMedium?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right, // Align text to the right
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'موقف السيارات: أبعاده 9×4م، مما يوفر موقف مناسب لسيارة واحدة.\n'
                  'الحديقة الأمامية: أبعادها 8×5.15م، تضيف جمالاً وراحة للمدخل.\n'
                  'الحديقة الداخلية: أبعادها 2.1×5.85م، مما يعزز الإضاءة الطبيعية والتهوية.\n'
                  'المدخل الرئيسي: أبعاده 1.5×1.75م مع حمام للضيوف 1.5×1.6م.\n'
                  'غرفة الاستقبال: أبعادها 4×7م، مثالية لاستقبال الضيوف في أجواء فاخرة.\n'
                  'غرفة المعيشة: أبعادها 6×3.75 متر، متصلة بالدرج لتصميم سلس.\n'
                  'غرفة النوم: أبعادها 4×6م، تفتح على الحديقة الداخلية لإضفاء جو هادئ.\n'
                  'المطبخ: أبعاده 3.75×6م، مصمم ليكون عملياً وعصرياً.\n'
                  'حمام إضافي: أبعاده 1.75×2.25 متر.\n'
                  'غرفة الغسيل: أبعادها 1.75×1.25م، تلبي احتياجات المنزل اليومية.',
              style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
              textAlign: TextAlign.right, // Align text to the right
            ),
          ),
          Image.asset(
            'assets/bc11.jpg', // Replace with your image path
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'تفاصيل الطابق الأول:',
              style: textTheme.titleMedium?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right, // Align text to the right
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'منطقة المعيشة العائلية: أبعادها 6×3.75 متر، متصلة بالدرج، مما يوفر مساحة معيشة إضافية.\n'
                  'غرفة نوم رئيسية (جناح): أبعادها 4×7 متر مع حمام خاص 1.5×3.6 متر.\n'
                  'غرفة النوم الثانية: أبعادها 3.75×6م مع حمام خاص 2.25×1.75م.\n'
                  'غرفة التخزين: أبعادها 1.75×3.25 متر، مثالية لتخزين الأدوات والمستلزمات الأساسية.\n'
                  'الشرفة الخلفية: تتضمن سلالم تؤدي إلى السطح الثاني.',
              style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
              textAlign: TextAlign.right, // Align text to the right
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'الميزات الإضافية:',
              style: textTheme.titleMedium?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right, // Align text to the right
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'تصميم عصري يعمل على استغلال المساحة بكفاءة.\n'
                  'تخلق المساحات الخضراء الأمامية والداخلية بيئة مريحة ومريحة.\n'
                  'مساحات معيشة واسعة مصممة لتلبية احتياجات العائلة بأكملها.',
              style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
              textAlign: TextAlign.right, // Align text to the right
            ),
          ),
          // Add images here if needed
          Image.asset(
            'assets/bc14.jpg', // Replace with your image path
            fit: BoxFit.cover,
          ),
        ],
      ),
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
        textAlign: TextAlign.right, // Align text to the right
      ),
    );
  }
}