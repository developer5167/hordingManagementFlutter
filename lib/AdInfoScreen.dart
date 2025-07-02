import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hording_management/model/GetAdsData.dart';

class AdInfoScreen extends StatelessWidget {
  final GetAdsData adsData;

  const AdInfoScreen({super.key, required this.adsData});

  @override
  Widget build(BuildContext context) {
    const Color approvedGreen = Color(0xFF4CAF50);
    const Color activeGreen = Color(0xFF4CAF50);
    const Color pausedGray = Color(0xFFBDBDBD);
    const Color deleteRed = Color(0xFFFF5A5F);
    const Color pauseOrange = Color(0xFFFFA726);
    const String mimeType = "image/png"; // or "video/mp4"
    const String mediaUrl = "https://via.placeholder.com/400"; // replace with your real media
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: Text('Ad info', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: _buildMediaPreview(mimeType, mediaUrl),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Title
              Text(
                "Lorem Ipsum has been the industry's standard dummy",
                style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
              ),
              const SizedBox(height: 4),
              Text(
                "it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged",
                style: GoogleFonts.poppins(fontSize: 13, color: Colors.black87),
              ),
              const SizedBox(height: 20),

              // Status Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  statusItem("Approved", approvedGreen),
                  statusItem("Active", activeGreen),
                  statusItem("Paused", pausedGray, withIcon: true),
                ],
              ),
              const SizedBox(height: 20),

              // Info Grid
              infoRow("Start Date", "12/10/2025", "Type", "image"),
              const SizedBox(height: 10),
              infoRow("End Date", "12/10/2025", "Ad Id", "AD-552656"),
              const SizedBox(height: 10),
              infoRow("Created at", "12/10/2025", "Device", "DID-12345"),
              const SizedBox(height: 20),
              // More info
              GestureDetector(
                onTap: (){},
                child: Row(
                  children: [
                    Text("More info", style: GoogleFonts.poppins(fontSize: 14)),
                    const SizedBox(width: 4),
                    const Icon(Icons.info_outline, size: 18, color: Colors.black54),
                  ],
                ),
              ),
              const Spacer(),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: deleteRed,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {},
                      icon: const Icon(Icons.delete, color: Colors.white),
                      label: Text("Delete", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.white)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: pauseOrange,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {},
                      icon: const Icon(Icons.pause_circle, color: Colors.white),
                      label: Text("Pause", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        ),
    );
  }

  Widget statusItem(String title, Color color, {bool withIcon = false}) {
    return Row(
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        const SizedBox(width: 4),
        withIcon ? const Icon(Icons.pause_circle_filled, color: Color(0xFFBDBDBD), size: 20) : Icon(Icons.check_circle, color: color, size: 20),
      ],
    );
  }

  Widget infoRow(String title1, String value1, String title2, String value2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        infoItem(title1, value1),
        infoItem(title2, value2),
      ],
    );
  }

  Widget infoItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(title, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black54),textAlign: TextAlign.center,),
        const SizedBox(height: 2),
        Text(value, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),textAlign: TextAlign.start),
      ],
    );
  }
}

Widget _buildMediaPreview(String mimeType, String url) {
  if (mimeType.startsWith("image/")) {
    return Image.network(
      url,
      width: double.infinity,
      height: 200,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Center(
        child: Text(
          'Failed to load image',
          style: GoogleFonts.poppins(fontSize: 14, color: Colors.redAccent),
        ),
      ),
    );
  } else if (mimeType.startsWith("video/")) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // A placeholder thumbnail or black background
        Container(color: Colors.black87),
        const Center(
          child: Icon(Icons.play_circle_fill, color: Colors.white, size: 50),
        ),
      ],
    );
    // You can replace this placeholder with a real video player (e.g. Chewie + VideoPlayer)
  } else {
    return Center(
      child: Text(
        'Unsupported media type',
        style: GoogleFonts.poppins(fontSize: 14, color: Colors.black54),
      ),
    );
  }
}
