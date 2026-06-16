import 'package:food_app_task/imports.dart';

class PaymentMethodSheet extends StatelessWidget {
  final String selectedPaymentMethod;
  final Function(String) onPaymentSelected;

  const PaymentMethodSheet({super.key, required this.selectedPaymentMethod, required this.onPaymentSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // Drag Handle
          Container(
            margin: EdgeInsets.only(top: spacingSmall),
            width: 40.sp,
            height: 4.sp,
            decoration: BoxDecoration(color: context.theme.dividerColor, borderRadius: BorderRadius.circular(2.sp)),
          ),

          // Header
          Padding(
            padding: paddingDefault,
            child: Row(
              children: [
                Text('select_payment_method'.tr, style: bodyLarge(context).copyWith(fontWeight: FontWeight.bold)),
                const Spacer(),
                IconButton(icon: const Icon(Icons.close), onPressed: () => pop()),
              ],
            ),
          ),

          Divider(height: 1, color: context.theme.dividerColor),

          // Payment Methods
          Expanded(
            child: ListView(
              padding: paddingDefault,
              children: [
                PaymentOption(
                  id: 'cash',
                  title: 'cash'.tr,
                  subtitle: 'pay_with_cash_subtitle'.tr,
                  icon: 'assets/images/cash.png',
                  isSelected: selectedPaymentMethod == 'cash',
                  onTap: () {
                    onPaymentSelected('cash');
                    pop();
                  },
                ),
                SizedBox(height: spacingMedium),
                PaymentOption(
                  id: 'card',
                  title: 'online'.tr,
                  subtitle: 'pay_with_card_subtitle'.tr,
                  icon: 'assets/images/card.png',
                  isSelected: selectedPaymentMethod == 'card',
                  onTap: () {
                    onPaymentSelected('card');
                    pop();
                  },
                ),
                SizedBox(height: spacingMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentOption extends StatelessWidget {
  final String id;
  final String title;
  final String subtitle;
  final String icon;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentOption({
    super.key,
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.sp),
        decoration: BoxDecoration(
          color: isSelected ? secondaryColor.withValues(alpha: 0.1) : context.theme.scaffoldBackgroundColor,
          borderRadius: borderRadiusDefault,
          border: Border.all(
            color: isSelected ? secondaryColor : context.theme.dividerColor,
            width: isSelected ? 2.sp : 1.sp,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40.sp,
              height: 40.sp,
              padding: EdgeInsets.all(6.sp),
              decoration: BoxDecoration(color: context.theme.cardColor, borderRadius: borderRadiusSmall),
              child: Image.asset(icon, fit: BoxFit.contain),
            ),
            SizedBox(width: spacingMedium),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: bodyMedium(context).copyWith(fontWeight: FontWeight.w600)),
                  SizedBox(height: 1.sp),
                  Text(
                    subtitle,
                    style: bodySmall(context).copyWith(color: context.theme.hintColor, fontSize: 10.sp),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Container(
                width: 24.sp,
                height: 24.sp,
                decoration: const BoxDecoration(color: secondaryColor, shape: BoxShape.circle),
                child: Icon(Icons.check, color: onPrimary, size: 16.sp),
              ),
          ],
        ),
      ),
    );
  }
}
