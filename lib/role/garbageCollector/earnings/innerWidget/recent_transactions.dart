
import 'package:flutter/material.dart';
import 'package:project_borla/role/components/custom_container.dart';
import '../../../../../models/riderModels/earnings_model.dart';

import '../../../../theme/app_color.dart';
import '../../../components/text/common_text.dart';

class RecentTransactionsWidget extends StatelessWidget {
  final List<EarningTransaction> transactions;
  const RecentTransactionsWidget({Key? key, required this.transactions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12,),
        const CommonText(
          text: 'Recent Transaction',
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),

        const SizedBox(height: 16),

        /// Transaction List
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: transactions.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            return _buildTransactionCard(transactions[index]);
          },
        ),
      ],
    );
  }

  Widget _buildTransactionCard(EarningTransaction transaction) {
    return CustomContainer(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      borderRadius: 4,
      borderColor: AppColors.green300,
      borderWidth: 0.5,
      child: Row(
        children: [
          /// Left section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: transaction.title,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(height: 6),
                CommonText(
                  text: transaction.createdAt,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.gray400,
                ),
              ],
            ),
          ),

          /// Right section
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CommonText(
                text: '${transaction.type == 'debit' ? '-' : '+'}₵${transaction.amount}',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: transaction.type == 'debit' ? AppColors.red500 : AppColors.green500,
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(
                    Icons.credit_card,
                    size: 16,
                    color: AppColors.gray500,
                  ),
                  const SizedBox(width: 4),
                  CommonText(
                    text: transaction.paymentMethod,
                    fontSize: 14,
                    color: AppColors.gray500,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
