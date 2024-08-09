import 'package:change_language/cubit/change_language_cubit.dart';
import 'package:change_language/data/model/appLanguage.dart';
import 'package:change_language/utils/appLanguage.dart';
import 'package:change_language/utils/lableKey.dart';
import 'package:change_language/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _buildAppLanguageTile({
    required AppLanguage appLanguage,
    required BuildContext context,
    required String currentSelectedLanguageCode,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: GestureDetector(
        onTap: () {
          context
              .read<AppLocalizationCubit>()
              .changeLanguage(appLanguage.languageCode);
        },
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 1.75,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: appLanguage.languageCode == currentSelectedLanguageCode
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              appLanguage.languageName,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.secondary,
              ),
            )
          ],
        ),
      ),
    );
  }

  String? dropvalue;
  int firstbutton = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Utils.getTranslatedLabel(context, appTitlekey)),
        actions: [
          Container(
            margin: const EdgeInsets.all(5),
            height: MediaQuery.of(context).size.height * 0.03,
            child: DropdownButton(
              iconDisabledColor: Theme.of(context).colorScheme.secondary,
              iconEnabledColor: Theme.of(context).colorScheme.secondary,
              icon: const Center(child: Icon(Icons.arrow_drop_down)),
              // padding: const EdgeInsets.only(top: 10),
              underline: const SizedBox(),
              hint: Text(
                dropvalue ?? "English",
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
              alignment: Alignment.topCenter,
              items: [
                'English',
                'Hindi',
                'Gujrati',
              ].map((value) {
                return DropdownMenuItem(
                  alignment: Alignment.center,
                  value: value,
                  child: Container(
                    color: Colors.amber,
                    child: Text(value),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  dropvalue = value;
                  if (dropvalue == "Hindi") {
                    context.read<AppLocalizationCubit>().changeLanguage('hi');
                  } else if (dropvalue == "Gujrati") {
                    context.read<AppLocalizationCubit>().changeLanguage('gu');
                  } else if (dropvalue == "English") {
                    context.read<AppLocalizationCubit>().changeLanguage('en');
                  }
                });

                print("This is on changed value:-$dropvalue");
              },
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Text(
            textAlign: TextAlign.center,
            Utils.getTranslatedLabel(context, detailskey),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 20, left: 20),
                            child: Text(
                              "Application Language",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Divider(),
                          ),
                          BlocBuilder<AppLocalizationCubit,
                              AppLocalizationState>(
                            builder: (context, state) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  children: appLanguages
                                      .map(
                                        (appLanguage) => _buildAppLanguageTile(
                                          appLanguage: appLanguage,
                                          context: context,
                                          currentSelectedLanguageCode:
                                              state.language.languageCode,
                                        ),
                                      )
                                      .toList(),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.04,
              width: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: const Center(
                child: Text("Change New language"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
