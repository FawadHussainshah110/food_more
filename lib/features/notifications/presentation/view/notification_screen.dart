import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:food_app_task/imports.dart';
import 'package:food_app_task/features/notifications/presentation/controller/notification_controller.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  void handleBack() {
    pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: titleMedium(context).copyWith(
            fontWeight: FontWeight.bold
          )
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: handleBack
        )
      ),
      body: SafeArea(
        child: GetBuilder<NotificationController>(
          builder: (controller) {
            if (controller.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            final list = controller.notifications;
            if (list.isEmpty) {
              return const Center(child: Text('No new notifications'));
            }

            return ListView.builder(
              padding: paddingDefault,
              itemCount: list.length,
              itemBuilder: (context, index) {
                final item = list[index];
                return Dismissible(
                  key: Key('notification_item_${item.id}'),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    controller.deleteNotificationItem(item.id);
                    HapticFeedback.lightImpact();
                  },
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: spacingLarge),
                    decoration: BoxDecoration(
                      color: context.theme.colorScheme.error.withValues(alpha: 0.1),
                      borderRadius: borderRadiusLarge
                    ),
                    child: Icon(
                      Icons.delete_outline_rounded,
                      color: context.theme.colorScheme.error,
                      size: 28.sp
                    )
                  ),
                  child: GestureDetector(
                    onTap: () {
                      controller.markNotificationAsRead(item.id);
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      margin: EdgeInsets.only(bottom: spacingDefault),
                      padding: paddingDefault,
                      decoration: BoxDecoration(
                        color: item.isRead ? context.theme.cardColor : context.theme.primaryColor.withValues(alpha: 0.05),
                        borderRadius: borderRadiusLarge,
                        border: Border.all(
                          color: item.isRead ? context.theme.disabledColor.withValues(alpha: 0.15) : context.theme.primaryColor.withValues(alpha: 0.3),
                          width: 1.sp
                        ),
                        boxShadow: AppShadows.cardShadow
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            item.type == 'promo'
                                ? Icons.local_offer_outlined
                                : item.type == 'order'
                                    ? Icons.shopping_bag_outlined
                                    : Icons.delivery_dining_outlined,
                            color: context.theme.primaryColor,
                            size: 24.sp
                          ),
                          SizedBox(width: spacingDefault),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: bodyMedium(context).copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: item.isRead ? null : context.theme.primaryColor
                                  )
                                ),
                                SizedBox(height: spacingExtraSmall),
                                Text(
                                  item.message,
                                  style: bodySmall(context).copyWith(
                                    color: context.theme.hintColor
                                  )
                                )
                              ]
                            )
                          )
                        ]
                      )
                    )
                  )
                );
              }
            );
          }
        )
      )
    );
  }
}
