import 'package:flutter/material.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  bool _isScrolled = false;
  String _hoveredItem = '';
  String _currentRoute = '/';
  bool _isMenuOpen = false;

  final Map<String, String> _routes = {
    'Home': '/',
    'About': '/about',
    'Services': '/services',
    'Pricing': '/pricing',
    'Blog': '/blog',
    'Contact': '/contact',
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScrollController scrollController = PrimaryScrollController.of(context);
      scrollController.addListener(() {
        setState(() {
          _isScrolled = scrollController.offset > 0;
        });
      });
      setState(() {
        _currentRoute = ModalRoute.of(context)?.settings.name ?? '/';
      });
    });
  }

  void _handleNavigation(String title) {
    final route = _routes[title];
    if (route != null && route != _currentRoute) {
      setState(() {
        _currentRoute = route;
        _isMenuOpen = false;
      });
      Navigator.pushNamed(context, route);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 1024;
    final isTablet = screenWidth > 768 && screenWidth <= 1024;

    return Material(
      elevation: _isScrolled ? 4 : 0,
      color: Colors.white,
      child: Container(
        height: _isMenuOpen && !isDesktop && !isTablet ? null : 70,
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 24 : 16,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.shade200,
              width: 1,
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildLogo(),
                  if (!isDesktop && !isTablet)
                    IconButton(
                      icon: Icon(
                        _isMenuOpen ? Icons.close : Icons.menu,
                        color: const Color(0xFF40A0C8),
                      ),
                      onPressed: () {
                        setState(() {
                          _isMenuOpen = !_isMenuOpen;
                        });
                      },
                    )
                  else
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: _routes.keys
                                  .map((title) => Flexible(
                                        child: _buildNavLink(
                                          title,
                                          isTablet: isTablet,
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                          const SizedBox(width: 24),
                          _buildAppointmentButton(isTablet: isTablet),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            if (!isDesktop && !isTablet && _isMenuOpen)
              Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height - 70,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ..._routes.keys
                          .map((title) => _buildMobileNavLink(title)),
                      const SizedBox(height: 16),
                      _buildAppointmentButton(isMobile: true),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return GestureDetector(
      onTap: () {
        if (_currentRoute != '/') {
          setState(() {
            _currentRoute = '/';
          });
          Navigator.pushNamed(context, '/');
        }
      },
      child: const Text(
        'Snoring Mind',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Color(0xFF40A0C8),
          letterSpacing: -0.5,
        ),
      ),
    );
  }

  Widget _buildNavLink(String title, {bool isTablet = false}) {
    final route = _routes[title];
    final isActive = route == _currentRoute;

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredItem = title),
      onExit: (_) => setState(() => _hoveredItem = ''),
      child: InkWell(
        onTap: () => _handleNavigation(title),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 8 : 12,
            vertical: 8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: isTablet ? 14 : 15,
                  color: isActive || _hoveredItem == title
                      ? const Color(0xFF40A0C8)
                      : Colors.grey.shade700,
                  fontWeight: isActive || _hoveredItem == title
                      ? FontWeight.w600
                      : FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: isActive || _hoveredItem == title ? 24 : 0,
                decoration: BoxDecoration(
                  color: const Color(0xFF7FDBBD), // Mint color
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobileNavLink(String title) {
    final route = _routes[title];
    final isActive = route == _currentRoute;

    return InkWell(
      onTap: () => _handleNavigation(title),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.shade200,
              width: 1,
            ),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: isActive ? const Color(0xFF40A0C8) : Colors.grey.shade700,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildAppointmentButton(
      {bool isTablet = false, bool isMobile = false}) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredItem = 'appointment'),
      onExit: (_) => setState(() => _hoveredItem = ''),
      child: ElevatedButton(
        onPressed: () {
          // TODO: Implement appointment booking
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: _hoveredItem == 'appointment'
              ? const Color(0xFF7FDBBD)
              : const Color(0xFF40A0C8),
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 16 : 24,
            vertical: 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
        ),
        child: Text(
          'Book Consultation',
          style: TextStyle(
            fontSize: isTablet ? 14 : 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }
}
