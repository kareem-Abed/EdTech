import 'package:flutter/material.dart';
import 'package:edtech/common/widgets/custom_shaps/containers/primary_header_container.dart';
import 'package:edtech/utils/constants/colors.dart';
import 'package:edtech/utils/constants/sizes.dart';

class KPrimaryHeaderAppBar extends StatelessWidget {
  const KPrimaryHeaderAppBar(
      {super.key, required this.title, this.goBack = true});
  final String title;
  final bool goBack;
  @override
  Widget build(BuildContext context) {
    return KPrimaryHeaderContainer(
      child: Column(
        children: [
          const SizedBox(
            height: KSizes.spaceBtwSections * 1.5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              goBack
                  ? IconButton(
                      icon: const Icon(Icons.chevron_left,
                          size: 32, color: KColors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  : const SizedBox(
                      height: KSizes.spaceBtwSections,
                      width: double.infinity,
                    ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall!.apply(
                      color: KColors.light,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                width: 32,
              ),
            ],
          ),
          const SizedBox(
            height: KSizes.spaceBtwSections,
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}
