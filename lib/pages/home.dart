import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whisper_arts_tests/dataclass/clockData.dart';
import 'package:whisper_arts_tests/pages/clockDetails.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static List<String> nameClock = [
    'Oyster Perpetual 41',
    'Perpetual Sky‑Dweller',
    'Cosmograph Daytona',
    'Submariner',
    'Air‑King',
    'Sea-Dweller',
    'Milgauss',
    'Yacht-Master',
    'Cellini',
    'Lady‑Datejust',
  ];
  static List<String> priceClock = [
    '500.000.000 ₽',
    '730.000.000 ₽',
    '30.000.000 ₽',
    '1.450.000.000 ₽',
    '980.000 ₽',
    '395.000.000 ₽',
    '589.000.000 ₽',
    '3.456.000 ₽',
    '45.500.000 ₽',
    '500.000.000 ₽',
  ];
  static List<String> descriptionClock = [
    'Часы Oyster Perpetual обладают эстетическими качествами, благодаря которым они могут служить образцом универсального классического стиля. Их отличает безупречная гармония формы и функциональности, характерная для часов Rolex с момента основания этой новаторской компании.',
    'Компания Rolex представляет часы Perpetual Sky-Dweller из 18-каратного желтого золота с браслетом Oysterflex. Это первая модель из категории Классических часов с инновационным браслетом из эластомера высокого качества. Эти часы сочетают циферблат глубокого черного цвета с солнечным переливом со стрелками и часовыми указателями из 18-каратного желтого золота. Игра света на дужках и боковых сторонах корпусного кольца подчеркивает форму корпуса Oyster диаметром 42 мм.',
    'Представленные в 1963 году часы Cosmograph Daytona были созданы для профессиональных автогонщиков. Название и функции этих легендарных часов однозначно указывают на их принадлежность к миру автомобильного спорта. На протяжении более 50 лет с момента своего создания модель Cosmograph Daytona постоянно развивалась, оставаясь уникальной в своем роде и непревзойденной среди спортивных хронографов.',
    'Часы Submariner, увидевшие свет в 1953 году, стали первой моделью наручных часов для дайвинга, способной сохранять водонепроницаемость до глубины 100 метров. Они ознаменовали второй грандиозный прорыв в решении проблемы водонепроницаемости после изобретения в 1926 году первых в мире водонепроницаемых часов Oyster. В истории часового дела модель Submariner ознаменовала переломный момент, задав новый стандарт для дайверских часов. Часы Submainer водонепроницаемы до глубины 300 метров.',
    'Модель Air‑King с корпусом диаметром 40 мм из стали Oystersteel, выразительным черным циферблатом и браслетом Oyster с массивными звеньями, оснащенным застежкой Oysterclasp, увековечивает авиационное наследие оригинальных часов Rolex Oyster.',
    'Модель Sea-Dweller компании Rolex, выпущенная в 1967 году, водонепроницаема до глубины 1220 метров, модель Rolex Deepsea, появившаяся в 2008 году, – до глубины 3900 метров. Это высшее достижение Rolex в области часовых технологий, используемых в дайверских часах, и результат многолетнего сотрудничества часовой марки с профессионалами дайвинга.',
    'Созданные в 1956 году, они способны выдерживать магнитные поля напряженностью до 1000 гауссов. В названии модели лежит французское слово mille – тысяча. Часы Milgauss – первые часы такого рода – сочетают в себе уникальную эстетику и научное наследие.',
    'Вдохновленные богатым наследием, связавшим Rolex с миром парусного спорта с 1950-х годов, часы Yacht-Master сочетают функциональность и стиль, а часы Yacht-Master II являются примером лучших технологий Rolex, использованных для создания яхтенного хронографа, предназначенного для парусных регат.',
    'Эти часы сочетают лучшее ноу-хау и требования Rolex к совершенству с подходом, который воспевает часовое наследие в его самой неподвластной времени форме. Строгие и утонченные линии, благородные материалы, роскошная отделка – каждая деталь часов Cellini создана с учетом законов часового искусства.',
    'Женская версия легендарных часов Datejust 1945 года была выпущена в 1957 году. Эти часы диаметром всего 28 мм характеризуются вневременной элегантностью и функциональностью.',
  ];

  static List url = [
    'https://content.rolex.com/dam/model-page/gallery/m124300-0002/model-page-oyster-perpetual-41_m124300-0002_2001ac_002_medium_2.jpg?imwidth=420',
    'https://content.rolex.com/dam/new-watches-2020/new-sky-dweller/roller-beauty/new-sky-dweller-everose-gold-01.jpg?imwidth=420',
    'https://content.rolex.com/dam/watches/family-pages/cosmograph-daytona/roller-design/professional-watches-cosmograph-daytona-yellow-gold_m116518ln_0040_1701ac_005_press.jpg?imwidth=420',
    'https://content.rolex.com/dam/watches/family-pages/submariner/rollers/roller-features/submariner-winding-crown-beauty-shot-m124060-0001_2009pp_002.jpg?imwidth=420',
    'https://content.rolex.com/dam/watches/family-pages/air-king/family-page-air-king-beauty_m116900-0001_1601ac_003.jpg?imwidth=1920',
    'https://content.rolex.com/dam/watches/family-pages/sea-dweller/roller-design/family-page-sea-dweller-roller-design-beauty_m126603-0001_1901ac_004.jpg?imwidth=420',
    'https://content.rolex.com/dam/watches/family-pages/milgauss/family-page-milgauss-beauty_m116400gv0001_amb_003.jpg?imwidth=1920',
    'https://content.rolex.com/dam/watches/family-pages/yacht-master/roller-design-ym-ii/professional-watches-yacht-master-ii_m116681-0002_1909jva_001.jpg?imwidth=420',
    'https://content.rolex.com/dam/watches/family-pages/cellini/roller-design/family-page-cellini-dual-time_m50505-0020_1601jdm_001.jpg?imwidth=420',
    'https://content.rolex.com/dam/watches/family-pages/lady-datejust/family-page-lady-datejust-beauty-shot_m279173_0011_ambiance_flagship_campaign_pub_iso_r_e.jpg?imwidth=1920',
  ];
  final List<ClockData> clockList = List.generate(
      nameClock.length,
      (index) => ClockData('${nameClock[index]}', '${url[index]}',
          '${descriptionClock[index]}', '${priceClock[index]}'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'ROLEX',
          style: TextStyle(color: Colors.grey[700]),
        ),
        backgroundColor: Colors.grey[300],
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: clockList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(clockList[index].imageUrl),
                      fit: BoxFit.cover)),
              height: 600,
              child: GestureDetector(
                child: Card(
                    color: Colors.transparent,
                    key: Key(nameClock[index]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ListTile(
                          title: Text(
                            clockList[index].nameClock,
                            style: TextStyle(
                              fontFamily: 'BebasNeue',
                              fontSize: 71,
                              fontWeight: FontWeight.bold,
                              backgroundColor: Colors.transparent,
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                        Text(
                          clockList[index].priceClock,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: 'Birthstone',
                            fontSize: 40,
                            backgroundColor: Colors.transparent,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ClockDetails(
                            clockData: clockList[index],
                          )));
                },
              ),
            );
          }),
    );
  }
}
