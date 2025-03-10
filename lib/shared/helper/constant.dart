import 'package:flutter/material.dart';

bool isFirstTimeAppCH = false;
bool isNotiOnCH = true;
bool isFirstTimeAdkarCH = true;
bool isFirstTimeQuranCH = true;
TimeOfDay adkarTimeSabahCH = const TimeOfDay(hour: 6, minute: 00);
TimeOfDay adkarTimeMasaaCH = const TimeOfDay(hour: 16, minute: 30);
double sizeAdkarTextCH = 26;
String floatingNotificationIntervalCH = '30 دقيقة';
double arabicFontSize = 28;
double mushafFontSize = 40;

List<String> smallDo3a2 = [
  'اللَّهُمَّ إنِّي أَسْأَلُكَ الهُدَى وَالتُّقَى، وَالْعَفَافَ وَالْغِنَى',
  'رَبِّ إِنِّي أَعُوذُ بِكَ أَنْ أَسْأَلَكَ مَا لَيْسَ لِي بِهِ عِلْمٌ ۖ وَإِلَّا تَغْفِرْ لِي وَتَرْحَمْنِي أَكُن مِّنَ الْخَاسِرِينَ',
  'رَبَّنَا أَتْمِمْ لَنَا نُورَنَا وَاغْفِرْ لَنَا ۖ إِنَّكَ عَلَىٰ كُلِّ شَيْءٍ قَدِيرٌ',
  'رَّبِّ أَنزِلْنِي مُنزَلًا مُّبَارَكًا وَأَنتَ خَيْرُ الْمُنزِلِينَ',
  'اللَّهمَّ إنِّي أسألُك أنِّي أَشهَدُ أنَّك أنت اللهُ، لا إلهَ إلَّا أنت، الأحدُ الصمدُ، الذي لم يَلِدْ ولم يولَدْ، ولم يكُنْ له كُفوًا أحدٌ',
  'اللَّهُمَّ إنِّي أعُوذُ بكَ مِنَ الهَمِّ والحَزَنِ، والعَجْزِ والكَسَلِ، والبُخْلِ، والجُبْنِ، وضَلَعِ الدَّيْنِ، وغَلَبَةِ الرِّجالِ',
  'رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي الْآخِرَةِ حَسَنَةً وَقِنَا عَذَابَ النَّارِ',
  'لَّا إِلَٰهَ إِلَّا أَنتَ سُبْحَانَكَ إِنِّي كُنتُ مِنَ الظَّالِمِينَ',
  'رَّبِّ زِدْنِي عِلْمًا',
  'اللَّهمَّ إنِّي أسألُك من خيرِ ما أُمِرَتْ بِه وأعوذُ بِك من شرِّ ما أُمِرَت بِه',
  'اللهمَّ إني أسألُك من كل خيرٍ خزائنُه بيدِك، وأعوذُ بك من كل شرٍّ خزائنُه بيدِك',
  'رَبِّ أَوْزِعْنِي أَنْ أَشْكُرَ نِعْمَتَكَ الَّتِي أَنْعَمْتَ عَلَيَّ وَعَلَىٰ وَالِدَيَّ وَأَنْ أَعْمَلَ صَالِحًا تَرْضَاهُ وَأَصْلِحْ لِي فِي ذُرِّيَّتِي ۖ إِنِّي تُبْتُ إِلَيْكَ وَإِنِّي مِنَ الْمُسْلِمِينَ',
  'رَبَّنَا هَبْ لَنَا مِنْ أَزْوَاجِنَا وَذُرِّيَّاتِنَا قُرَّةَ أَعْيُنٍ وَاجْعَلْنَا لِلْمُتَّقِينَ إِمَامًا',
  'اللَّهُمَّ إنِّي أعُوذُ بكَ مِنَ البُخْلِ، وأَعُوذُ بكَ مِنَ الجُبْنِ، وأَعُوذُ بكَ أنْ أُرَدَّ إلى أرْذَلِ العُمُرِ، وأَعُوذُ بكَ مِن فِتْنَةِ الدُّنْيَا -يَعْنِي فِتْنَةَ الدَّجَّالِ- وأَعُوذُ بكَ مِن عَذَابِ القَبْرِ',
  'رَبَّنَا اغْفِرْ لَنَا ذُنُوبَنَا وَإِسْرَافَنَا فِي أَمْرِنَا وَثَبِّتْ أَقْدَامَنَا وَانصُرْنَا عَلَى الْقَوْمِ الْكَافِرِينَ',
  'رَبِّ هَبْ لِي مِن لَّدُنكَ ذُرِّيَّةً طَيِّبَةً ۖ إِنَّكَ سَمِيعُ الدُّعَاءِ',
  'رَبَّنَا لَا تُزِغْ قُلُوبَنَا بَعْدَ إِذْ هَدَيْتَنَا وَهَبْ لَنَا مِن لَّدُنكَ رَحْمَةً',
  'قَالَ رَبِّ اشْرَحْ لِي صَدْرِي*وَيَسِّرْ لِي أَمْرِي',
  'اللَّهُمَّ إنِّي أَعُوذُ بكَ مِن زَوَالِ نِعْمَتِكَ، وَتَحَوُّلِ عَافِيَتِكَ، وَفُجَاءَةِ نِقْمَتِكَ، وَجَمِيعِ سَخَطِكَ',
  'اللَّهمَّ إنِّي أعوذُ بِك من شرِّ ما عَمِلتُ ، ومن شرِّ ما لم أعمَلْ',
  'رَبِّ نَجِّنِي مِنَ الْقَوْمِ الظَّالِمِينَ',
  'رَبِّ هَبْ لِي حُكْمًا وَأَلْحِقْنِي بِالصَّالِحِينَ',
  'رَّبِّ أَعُوذُ بِكَ مِنْ هَمَزَاتِ الشَّيَاطِينِ',
  'اللَّهُمَّ اجْعَلْ في قَلْبِي نُورًا، وفي بَصَرِي نُورًا، وفي سَمْعِي نُورًا، وعَنْ يَمِينِي نُورًا، وعَنْ يَسارِي نُورًا، وفَوْقِي نُورًا، وتَحْتي نُورًا، وأَمامِي نُورًا، وخَلْفِي نُورًا، واجْعَلْ لي نُورًا',
  'اللَّهمَّ أحسَنتَ خَلقي فأحسِن خُلُقي',
  'رَبِّ اجْعَلْنِي مُقِيمَ الصَّلَاةِ وَمِن ذُرِّيَّتِي ۚ رَبَّنَا وَتَقَبَّلْ دُعَاءِ',
  'رَبَّنَا أَفْرِغْ عَلَيْنَا صَبْرًا وَثَبِّتْ أَقْدَامَنَا وَانصُرْنَا عَلَى الْقَوْمِ الْكَافِرِينَ',
  'رَبَّنَا تَقَبَّلْ مِنَّا إِنَّكَ أَنْتَ السَّمِيعُ الْعَلِيمُ',
  'وَتُبْ عَلَيْنَا إِنَّكَ أَنْتَ التَّوَّابُ الرَّحِيمُ',
  'اللهمَّ احفَظْني بالإسلام قائمًا، واحفَظْني بالإسلام قاعدًا، واحفظْني بالإسلام راقدًا، ولا تُشْمِتْ بي عدوًّا ولا حاسدًا',
  'اللَّهُمَّ أحْيِنِي ما كانَتِ الحَياةُ خَيْرًا لِي، وتَوَفَّنِي إذا كانَتِ الوَفاةُ خَيْرًا لِي',
  'رَبِّ أَوْزِعْنِي أَنْ أَشْكُرَ نِعْمَتَكَ الَّتِي أَنْعَمْتَ عَلَيَّ وَعَلَىٰ وَالِدَيَّ وَأَنْ أَعْمَلَ صَالِحًا تَرْضَاهُ وَأَدْخِلْنِي بِرَحْمَتِكَ فِي عِبَادِكَ الصَّالِحِينَ',
  'اللَّهُمَّ أعنَّا على شُكْرِكَ وذِكْرِكَ، وحُسنِ عبادتِكَ',
  'اللهمَّ اكفِنِي بحلالِكَ عن حرَامِكَ، وأغْنِنِي بفَضْلِكَ عمَّن سواكَ',
  'رَبَّنَا آتِنَا مِن لَّدُنكَ رَحْمَةً وَهَيِّئْ لَنَا مِنْ أَمْرِنَا رَشَدًا',
  'اللَّهمَّ إنِّي أعوذُ بِكَ منَ الفقرِ ، والقلَّةِ ، والذِّلَّةِ ، وأعوذُ بِكَ من أن أظلِمَ ، أو أُظلَمَ',
];

List<dynamic> notifications = [
  {
    "description":
        'اللَّهُمَّ إنِّي أَسْأَلُكَ الهُدَى وَالتُّقَى، وَالْعَفَافَ وَالْغِنَى',
    "date": const TimeOfDay(hour: 00, minute: 00),
    "id": 1
  },
  {
    "description":
        'رَبِّ إِنِّي أَعُوذُ بِكَ أَنْ أَسْأَلَكَ مَا لَيْسَ لِي بِهِ عِلْمٌ ۖ وَإِلَّا تَغْفِرْ لِي وَتَرْحَمْنِي أَكُن مِّنَ الْخَاسِرِينَ',
    "date": const TimeOfDay(hour: 01, minute: 00),
    "id": 2
  },
  {
    "description":
        'رَبَّنَا أَتْمِمْ لَنَا نُورَنَا وَاغْفِرْ لَنَا ۖ إِنَّكَ عَلَىٰ كُلِّ شَيْءٍ قَدِيرٌ',
    "date": const TimeOfDay(hour: 02, minute: 00),
    "id": 3
  },
  {
    "description":
        'رَّبِّ أَنزِلْنِي مُنزَلًا مُّبَارَكًا وَأَنتَ خَيْرُ الْمُنزِلِينَ',
    "date": const TimeOfDay(hour: 3, minute: 00),
    "id": 4
  },
  {
    "description":
        'اللَّهمَّ إنِّي أسألُك أنِّي أَشهَدُ أنَّك أنت اللهُ، لا إلهَ إلَّا أنت، الأحدُ الصمدُ، الذي لم يَلِدْ ولم يولَدْ، ولم يكُنْ له كُفوًا أحدٌ',
    "date": const TimeOfDay(hour: 4, minute: 00),
    "id": 5
  },
  {
    "description":
        'اللَّهُمَّ إنِّي أعُوذُ بكَ مِنَ الهَمِّ والحَزَنِ، والعَجْزِ والكَسَلِ، والبُخْلِ، والجُبْنِ، وضَلَعِ الدَّيْنِ، وغَلَبَةِ الرِّجالِ',
    "date": const TimeOfDay(hour: 5, minute: 00),
    "id": 6
  },
  {
    "description":
        'رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي الْآخِرَةِ حَسَنَةً وَقِنَا عَذَابَ النَّارِ',
    "date": const TimeOfDay(hour: 6, minute: 00),
    "id": 7
  },
  {
    "description":
        'لَّا إِلَٰهَ إِلَّا أَنتَ سُبْحَانَكَ إِنِّي كُنتُ مِنَ الظَّالِمِينَ',
    "date": const TimeOfDay(hour: 7, minute: 00),
    "id": 8
  },
  {
    "description": 'رَّبِّ زِدْنِي عِلْمًا',
    "date": const TimeOfDay(hour: 8, minute: 00),
    "id": 9
  },
  {
    "description":
        'اللَّهمَّ إنِّي أسألُك من خيرِ ما أُمِرَتْ بِه وأعوذُ بِك من شرِّ ما أُمِرَت بِه',
    "date": const TimeOfDay(hour: 9, minute: 00),
    "id": 10
  },
  {
    "description":
        'اللهمَّ إني أسألُك من كل خيرٍ خزائنُه بيدِك، وأعوذُ بك من كل شرٍّ خزائنُه بيدِك',
    "date": const TimeOfDay(hour: 10, minute: 00),
    "id": 11
  },
  {
    "description":
        'رَبِّ أَوْزِعْنِي أَنْ أَشْكُرَ نِعْمَتَكَ الَّتِي أَنْعَمْتَ عَلَيَّ وَعَلَىٰ وَالِدَيَّ وَأَنْ أَعْمَلَ صَالِحًا تَرْضَاهُ وَأَصْلِحْ لِي فِي ذُرِّيَّتِي ۖ إِنِّي تُبْتُ إِلَيْكَ وَإِنِّي مِنَ الْمُسْلِمِينَ',
    "date": const TimeOfDay(hour: 11, minute: 00),
    "id": 12
  },
  {
    "description":
        'اللَّهُمَّ إنِّي أعُوذُ بكَ مِنَ البُخْلِ، وأَعُوذُ بكَ مِنَ الجُبْنِ، وأَعُوذُ بكَ أنْ أُرَدَّ إلى أرْذَلِ العُمُرِ، وأَعُوذُ بكَ مِن فِتْنَةِ الدُّنْيَا -يَعْنِي فِتْنَةَ الدَّجَّالِ- وأَعُوذُ بكَ مِن عَذَابِ القَبْرِ',
    "date": const TimeOfDay(hour: 12, minute: 00),
    "id": 13
  },
  {
    "description":
        'رَبَّنَا هَبْ لَنَا مِنْ أَزْوَاجِنَا وَذُرِّيَّاتِنَا قُرَّةَ أَعْيُنٍ وَاجْعَلْنَا لِلْمُتَّقِينَ إِمَامًا',
    "date": const TimeOfDay(hour: 13, minute: 00),
    "id": 14
  },
  {
    "description":
        'رَبَّنَا اغْفِرْ لَنَا ذُنُوبَنَا وَإِسْرَافَنَا فِي أَمْرِنَا وَثَبِّتْ أَقْدَامَنَا وَانصُرْنَا عَلَى الْقَوْمِ الْكَافِرِينَ',
    "date": const TimeOfDay(hour: 14, minute: 00),
    "id": 15
  },
  {
    "description":
        'رَبِّ هَبْ لِي مِن لَّدُنكَ ذُرِّيَّةً طَيِّبَةً ۖ إِنَّكَ سَمِيعُ الدُّعَاءِ',
    "date": const TimeOfDay(hour: 15, minute: 00),
    "id": 16
  },
  {
    "description":
        'رَبَّنَا لَا تُزِغْ قُلُوبَنَا بَعْدَ إِذْ هَدَيْتَنَا وَهَبْ لَنَا مِن لَّدُنكَ رَحْمَةً',
    "date": const TimeOfDay(hour: 16, minute: 00),
    "id": 17
  },
  {
    "description": 'قَالَ رَبِّ اشْرَحْ لِي صَدْرِي*وَيَسِّرْ لِي أَمْرِي',
    "date": const TimeOfDay(hour: 17, minute: 00),
    "id": 18
  },
  {
    "description":
        'اللَّهُمَّ إنِّي أَعُوذُ بكَ مِن زَوَالِ نِعْمَتِكَ، وَتَحَوُّلِ عَافِيَتِكَ، وَفُجَاءَةِ نِقْمَتِكَ، وَجَمِيعِ سَخَطِكَ',
    "date": const TimeOfDay(hour: 18, minute: 00),
    "id": 19
  },
  {
    "description":
        'اللَّهمَّ إنِّي أعوذُ بِك من شرِّ ما عَمِلتُ ، ومن شرِّ ما لم أعمَلْ',
    "date": const TimeOfDay(hour: 19, minute: 00),
    "id": 20
  },
  {
    "description": 'رَبِّ نَجِّنِي مِنَ الْقَوْمِ الظَّالِمِينَ',
    "date": const TimeOfDay(hour: 20, minute: 00),
    "id": 21
  },
  {
    "description": 'رَبِّ هَبْ لِي حُكْمًا وَأَلْحِقْنِي بِالصَّالِحِينَ',
    "date": const TimeOfDay(hour: 21, minute: 00),
    "id": 22
  },
  {
    "description": 'اللَّهمَّ أحسَنتَ خَلقي فأحسِن خُلُقي',
    "date": const TimeOfDay(hour: 22, minute: 00),
    "id": 23
  },
  {
    "description":
        'رَبِّ اجْعَلْنِي مُقِيمَ الصَّلَاةِ وَمِن ذُرِّيَّتِي ۚ رَبَّنَا وَتَقَبَّلْ دُعَاءِ',
    "date": const TimeOfDay(hour: 23, minute: 00),
    "id": 24
  },
  // {
  //   "description":
  //       'رَبَّنَا أَفْرِغْ عَلَيْنَا صَبْرًا وَثَبِّتْ أَقْدَامَنَا وَانصُرْنَا عَلَى الْقَوْمِ الْكَافِرِينَ',
  //   "date": TimeOfDay(hour: 24, minute: 00),
  //   "id": 25
  // },
];
