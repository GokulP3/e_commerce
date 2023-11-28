import 'package:flutter/material.dart';
import '../../utils/responsive.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({Key? key}) : super(key: key);

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  @override
  Widget build(BuildContext context) {
    final width = Responsive(context).width;
    final height = Responsive(context).height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _userProfile(width, height),
            Padding(
              padding: EdgeInsets.only(left: width * 0.03, top: height * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Profile",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  _editAddress(width, height),
                  _editProfile(width, height),
                  _loggedDevice(width, height),
                  _plusMember(width, height),
                  _payment(width, height),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.03, top: height * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Notification & Theme",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  notification(width, height),
                  darkTheme(width, height)
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.03, top: height * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Regional",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  appLanguage(width, height)
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.02, right: width * 0.02),
              child: const Divider(
                thickness: 0.8,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: height * 0.01, left: width * 0.03),
              child: SizedBox(
                height: height * 0.3,
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    contactUs(width, height),
                    privacyPolicy(width, height),
                    userAgreement(width, height),
                    signOut(width, height),
                    version(width, height)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// *************** profile image and name ***********
  ///
  Widget _userProfile(width, height) {
    return Padding(
      padding: EdgeInsets.only(left: width * 0.03, top: height * 0.03),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/profile.png",
                width: width * 0.2,
              )
            ],
          ),
          SizedBox(
            width: width * 0.04,
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Gokul P",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              Text(
                "gokulpugal117@gmail.com",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              )
            ],
          )
        ],
      ),
    );
  }

  /// *************** edit user address ***********

  Widget _editAddress(width, height) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.only(
            top: height * 0.02, right: width * 0.03, bottom: height * 0.02),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.map),
                    SizedBox(
                      width: width * 0.06,
                    ),
                    Text("Edit Address",
                        style: Theme.of(context).textTheme.headlineSmall),
                  ],
                ),
              ],
            ),
            const Column(
              children: [
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 20,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// *************** edit profile ***********

  Widget _editProfile(width, height) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.only(
            top: height * 0.015, right: width * 0.03, bottom: height * 0.02),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.note_alt_outlined),
                    SizedBox(
                      width: width * 0.06,
                    ),
                    Text("Edit Profile",
                        style: Theme.of(context).textTheme.headlineSmall),
                  ],
                )
              ],
            ),
            const Column(
              children: [
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 20,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// *************** logged device details ***********

  Widget _loggedDevice(width, height) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.only(
            top: height * 0.015, right: width * 0.03, bottom: height * 0.02),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.people_alt),
                    SizedBox(
                      width: width * 0.06,
                    ),
                    Text("Logged Devices",
                        style: Theme.of(context).textTheme.headlineSmall),
                  ],
                )
              ],
            ),
            const Column(
              children: [
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 20,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// *************** plus member ***********

  Widget _plusMember(width, height) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.only(
            top: height * 0.015, right: width * 0.03, bottom: height * 0.02),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.workspace_premium),
                    SizedBox(
                      width: width * 0.06,
                    ),
                    Text("Plus Member",
                        style: Theme.of(context).textTheme.headlineSmall),
                  ],
                )
              ],
            ),
            const Column(
              children: [
                Column(
                  children: [
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 20,
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  /// *************** payment ***********

  Widget _payment(width, height) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.only(
            top: height * 0.0125, right: width * 0.03, bottom: height * 0.0125),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.currency_rupee_outlined),
                    SizedBox(
                      width: width * 0.06,
                    ),
                    Text(
                      "Payment",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                )
              ],
            ),
            const Column(
              children: [
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 20,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// *************** notification ***********

  Widget notification(width, height) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Row(
              children: [
                const Icon(Icons.notifications),
                SizedBox(
                  width: width * 0.06,
                ),
                Text(
                  "Notification",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            )
          ],
        ),
        Column(
          children: [Switch(value: true, onChanged: (bool value) {})],
        )
      ],
    );
  }

  /// *************** dark mode ***********

  Widget darkTheme(width, height) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.only(
            top: height * 0.015, bottom: height * 0.02, right: width * 0.03),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.light_mode_rounded),
                    SizedBox(
                      width: width * 0.06,
                    ),
                    Text("App Theme",
                        style: Theme.of(context).textTheme.headlineSmall),
                  ],
                )
              ],
            ),
            const Column(
              children: [
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 20,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// *************** app language  ***********

  Widget appLanguage(width, height) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.only(
            top: height * 0.015, bottom: height * 0.02, right: width * 0.03),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.language),
                    SizedBox(
                      width: width * 0.06,
                    ),
                    Text(
                      "Language",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                )
              ],
            ),
            const Column(
              children: [
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 20,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// *************** contact us  ***********

  Widget contactUs(width, height) {
    return Text(
      "Contact Us",
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }

  /// *************** privacy policy  ***********

  Widget privacyPolicy(width, height) {
    return Text("Privacy Policy",
        style: Theme.of(context).textTheme.bodyMedium);
  }

  /// *************** user agreement  ***********

  Widget userAgreement(width, height) {
    return Text("User Agreement",
        style: Theme.of(context).textTheme.bodyMedium);
  }

  /// *************** signOut  ***********

  Widget signOut(width, height) {
    return InkWell(
        onTap: () {
          // ShowLoading().loading(context);
          // GoogleSignInSignOut().userSignOut(context);
        },
        child: Text("Sign Out", style: Theme.of(context).textTheme.bodyMedium));
  }

  /// *************** app version  ***********

  Widget version(width, height) {
    return Text("VERSION: 1.0.0",
        style: Theme.of(context).textTheme.bodyMedium);
  }
}
