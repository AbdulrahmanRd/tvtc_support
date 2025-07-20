import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tvtc_support/screens/it_support_screen.dart';
import 'package:tvtc_support/screens/maintenance_request_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final String userName = 'عبدالرحمن';

  final List<ServiceCardModel> services = [
    ServiceCardModel(
      title: 'طلب صيانة',
      description: 'طلب صيانة للمرافق أو الأجهزة',
      icon: Icons.build,
      onTap: (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MaintenanceRequestScreen()),
        );
      },
    ),
    ServiceCardModel(
      title: 'طلب دعم فني',
      description: 'طلب دعم فني للمشاكل التقنية',
      icon: Icons.computer,
      onTap: (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ITSupportScreen()),
        );
      },
    ),
    ServiceCardModel(
      title: 'تطبيق البصمة',
      description: 'الانتقال إلى تطبيق البصمة',
      icon: Icons.fingerprint,
      onTap: (BuildContext context) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('سيتم فتح تطبيق البصمة')),
        );
      },
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Handle navigation based on index if needed
      if (index == 1) {
        // Navigate to requests screen
      } else if (index == 2) {
        // Navigate to profile screen
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FCFD),
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF00638B), // Dark Blue
                  Color(0xFF00A3B0), // Teal
                ],
              ),
            ),
          ),
          elevation: 0,
          title: Text(
            'نظام الدعم الفني والخدمات',
            style: GoogleFonts.cairo(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header with Logo and Welcome
              Container(
                padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF00A3B0), // Teal
                      Color(0xFF15B3B2), // Lighter Teal
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Logo
                    SvgPicture.asset(
                      'assets/images/idrwMbnV7-.svg',
                      height: 80,
                      width: 80,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 16),
                    // Welcome Text
                    Text(
                      'مرحباً بك',
                      style: GoogleFonts.cairo(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      userName,
                      style: GoogleFonts.cairo(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Services Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      'الخدمات المتاحة',
                      style: GoogleFonts.cairo(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1.1,
                      ),
                      itemCount: services.length,
                      itemBuilder: (context, index) {
                        return ServiceCard(service: services[index]);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              selectedItemColor: const Color(0xFF0066B2),
              unselectedItemColor: Colors.grey[600],
              selectedLabelStyle: GoogleFonts.cairo(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              unselectedLabelStyle: GoogleFonts.cairo(
                fontSize: 12,
              ),
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              elevation: 0,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              iconSize: 24,
              items: [
                BottomNavigationBarItem(
                  icon: Container(
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                    decoration: BoxDecoration(
                      color: _selectedIndex == 0 ? const Color(0xFFE6F2FF) : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      _selectedIndex == 0 ? Icons.home_rounded : Icons.home_outlined,
                      size: 24,
                    ),
                  ),
                  label: 'الرئيسية',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                    decoration: BoxDecoration(
                      color: _selectedIndex == 1 ? const Color(0xFFE6F2FF) : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      _selectedIndex == 1 ? Icons.list_alt_rounded : Icons.list_alt_outlined,
                      size: 24,
                    ),
                  ),
                  label: 'الطلبات',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ServiceCardModel {
  final String title;
  final String description;
  final IconData icon;
  final Function(BuildContext) onTap;

  ServiceCardModel({
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });
}

class ServiceCard extends StatelessWidget {
  final ServiceCardModel service;

  const ServiceCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24), // More rounded corners
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return InkWell(
            onTap: () => service.onTap(context),
            borderRadius: BorderRadius.circular(24), // Match card border radius
            child: Container(
              constraints: BoxConstraints(
                minHeight: 180,
                maxWidth: constraints.maxWidth,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24), // Match card border radius
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white,
                    Colors.grey[50]!,
                  ],
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF15B3B2), // #15B3B2
                        Color(0xFF00A3B0), // #00A3B0
                        Color(0xFF00638B), // #00638B
                      ],
                      stops: [0.0, 0.5, 1.0],
                    ),
                      borderRadius: BorderRadius.circular(16), // More rounded icon container
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      service.icon,
                      size: 28,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Flexible(
                    child: Text(
                      service.title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cairo(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1A365D),
                        height: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Flexible(
                    child: Text(
                      service.description,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.cairo(
                        fontSize: 12,
                        color: Colors.grey[600],
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}