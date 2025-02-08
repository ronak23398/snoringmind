import 'package:flutter/material.dart';

class MentalHealthItem {
  final String title;
  final String description;
  final List<Color> gradientColors;

  MentalHealthItem({
    required this.title,
    required this.description,
    required this.gradientColors,
  });
}

class ScrollingMentalHealthWidget extends StatefulWidget {
  const ScrollingMentalHealthWidget({super.key});

  @override
  _ScrollingMentalHealthWidgetState createState() =>
      _ScrollingMentalHealthWidgetState();
}

class _ScrollingMentalHealthWidgetState
    extends State<ScrollingMentalHealthWidget> {
  final ScrollController _scrollController = ScrollController();
  bool _isHovering = false;

  final List<MentalHealthItem> items = [
    MentalHealthItem(
      title: 'Depression',
      description:
          'Major depressive disorder affects daily life, causing persistent sadness, loss of interest, and changes in sleep and appetite.',
      gradientColors: [Colors.blue.shade300, Colors.purple.shade300],
    ),
    MentalHealthItem(
      title: 'Anxiety Disorders',
      description:
          'Excessive worry and fear about everyday situations, often accompanied by physical symptoms like rapid heartbeat.',
      gradientColors: [Colors.purple.shade300, Colors.pink.shade300],
    ),
    MentalHealthItem(
      title: 'Schizophrenia',
      description:
          'A complex condition affecting thinking, perception, and behavior, often including hallucinations and delusions.',
      gradientColors: [Colors.red.shade300, Colors.orange.shade300],
    ),
    MentalHealthItem(
      title: 'Bipolar Disorder',
      description:
          'Characterized by extreme mood swings, including emotional highs (mania) and lows (depression).',
      gradientColors: [Colors.yellow.shade300, Colors.green.shade300],
    ),
    MentalHealthItem(
      title: 'OCD',
      description:
          'Obsessive-Compulsive Disorder involves recurring unwanted thoughts and repetitive behaviors or mental acts.',
      gradientColors: [Colors.green.shade300, Colors.teal.shade300],
    ),
    MentalHealthItem(
      title: 'PTSD',
      description:
          'Post-Traumatic Stress Disorder can develop after exposure to severe psychological trauma, causing flashbacks and anxiety.',
      gradientColors: [Colors.teal.shade300, Colors.blue.shade300],
    ),
    MentalHealthItem(
      title: 'Social Anxiety',
      description:
          'Intense fear of social situations and interactions, often affecting work, school, and daily activities.',
      gradientColors: [Colors.indigo.shade300, Colors.purple.shade300],
    ),
    MentalHealthItem(
      title: 'Substance Use Disorders',
      description:
          'Addiction and dependency issues affecting mental health, behavior, and social relationships.',
      gradientColors: [Colors.purple.shade300, Colors.deepPurple.shade300],
    ),
    MentalHealthItem(
      title: 'Eating Disorders',
      description:
          'Serious conditions related to eating behaviors that negatively impact health, emotions, and daily functioning.',
      gradientColors: [Colors.pink.shade300, Colors.red.shade300],
    ),
    MentalHealthItem(
      title: 'Panic Disorder',
      description:
          'Recurring panic attacks with intense fear and physical symptoms like chest pain and shortness of breath.',
      gradientColors: [Colors.orange.shade300, Colors.amber.shade300],
    ),
    MentalHealthItem(
      title: 'Sleep Disorders',
      description:
          'Problems with sleep patterns affecting mental health, including insomnia and sleep apnea.',
      gradientColors: [Colors.blue.shade300, Colors.lightBlue.shade300],
    ),
    MentalHealthItem(
      title: 'ADHD',
      description:
          'Attention-Deficit/Hyperactivity Disorder affects focus, impulse control, and activity levels.',
      gradientColors: [Colors.green.shade300, Colors.lightGreen.shade300],
    ),
    MentalHealthItem(
      title: 'Stress-Related Disorders',
      description:
          'Chronic stress leading to various mental and physical health problems affecting daily functioning.',
      gradientColors: [Colors.deepOrange.shade300, Colors.orange.shade300],
    ),
    MentalHealthItem(
      title: 'Personality Disorders',
      description:
          'Long-term patterns of behavior and inner experience that deviate from cultural expectations.',
      gradientColors: [Colors.purple.shade300, Colors.deepPurple.shade300],
    ),
    MentalHealthItem(
      title: 'Internet Addiction',
      description:
          'Excessive use of internet and digital devices affecting mental health and social relationships.',
      gradientColors: [Colors.cyan.shade300, Colors.blue.shade300],
    ),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startScrolling();
    });
  }

  void _startScrolling() {
    if (!_isHovering) {
      Future.delayed(Duration(milliseconds: 50), () {
        if (_scrollController.hasClients) {
          double maxScroll = _scrollController.position.maxScrollExtent;
          double currentScroll = _scrollController.offset;

          if (currentScroll >= maxScroll) {
            _scrollController.jumpTo(0);
          } else {
            _scrollController.animateTo(
              currentScroll + 1,
              duration: Duration(milliseconds: 50),
              curve: Curves.linear,
            );
          }

          if (mounted) {
            _startScrolling();
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 230,
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovering = true),
        onExit: (_) {
          setState(() => _isHovering = false);
          _startScrolling();
        },
        child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Container(
              width: 200,
              margin: EdgeInsets.all(8),
              child: Card(
                elevation: 4,
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: items[index].gradientColors,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              items[index].title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              items[index].description,
                              style: TextStyle(fontSize: 12),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
