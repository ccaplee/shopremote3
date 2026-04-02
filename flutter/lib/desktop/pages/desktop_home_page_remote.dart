import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopremote2/common.dart';
import 'package:shopremote2/consts.dart';
import 'package:shopremote2/desktop/pages/connection_page.dart';
import 'package:shopremote2/desktop/pages/desktop_tab_page.dart';
import 'package:shopremote2/models/state_model.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

/// Remote-only home page - simplified UI showing only client/remote functionality
/// No host/server features
class DesktopHomePageRemote extends StatefulWidget {
  const DesktopHomePageRemote({Key? key}) : super(key: key);

  @override
  State<DesktopHomePageRemote> createState() => _DesktopHomePageRemoteState();
}

class _DesktopHomePageRemoteState extends State<DesktopHomePageRemote>
    with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  final _scrollController = ScrollController();
  Timer? _updateTimer;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _updateTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: buildRemoteOnlyPane(context),
    );
  }

  Widget buildRemoteOnlyPane(BuildContext context) {
    final textColor = Theme.of(context).textTheme.titleLarge?.color;
    return Container(
      width: 320.0,
      color: Theme.of(context).colorScheme.background,
      child: Stack(
        children: [
          Column(
            children: [
              SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    buildLogoSection(context),
                    buildTitleSection(context),
                    buildConnectionInputSection(context),
                    buildRecentConnectionsSection(context),
                    buildAddressBookSection(context),
                  ],
                ),
              ),
              Expanded(child: Container())
            ],
          ),
          // Settings button in bottom left
          Positioned(
            bottom: 12,
            left: 12,
            child: buildSettingsButton(context, textColor),
          )
        ],
      ),
    );
  }

  Widget buildLogoSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Center(
        child: loadLogo(),
      ),
    );
  }

  Widget buildTitleSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            translate("Remote Control"),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            translate("Remote-only mode - Connect to computers"),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildConnectionInputSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 16, top: 16, bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: MyTheme.getPrimaryColor().withOpacity(0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            translate("Enter Device ID"),
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).textTheme.titleLarge?.color?.withOpacity(0.6),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              hintText: "e.g., 123456789",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            ),
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                _connectToRemote(value);
              }
            },
          ),
          SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: MyTheme.getPrimaryColor(),
              ),
              onPressed: () {
                // Handle connect action
              },
              child: Text(translate("Connect")),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRecentConnectionsSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 16, top: 8, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            translate("Recent Connections"),
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).dividerColor,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              translate("No recent connections"),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAddressBookSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 16, top: 8, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            translate("Address Book"),
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).dividerColor,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              translate("Address book is empty"),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSettingsButton(BuildContext context, Color? textColor) {
    return Container(
      decoration: BoxDecoration(
        color: MyTheme.getPrimaryColor(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: DesktopTabPage.onAddSetting,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.settings, size: 16, color: Colors.white),
                SizedBox(width: 6),
                Text(
                  translate("Settings"),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _connectToRemote(String id) {
    // TODO: Implement connection logic
    debugPrint("Connecting to remote: $id");
  }
}
