import 'package:flutter/material.dart';

class DiseaseScreen extends StatelessWidget {

  final List<String> img = <String>[
    'https://cdn.britannica.com/s:690x388,c:crop/63/118663-050-FF34ACCE/Powdery-mildew-grapes.jpg',
    'https://static.vikaspedia.in/media/images_en/agriculture/crop-production/integrated-pest-managment/ipm-for-fruit-crops/ipm-strategies-for-grapes/Downymildew.jpg',
    'https://www.almanac.com/sites/default/files/styles/primary_image_in_article/public/image_nodes/anthracnose2-csiro_scienceimage-wikimedia_commons.jpg?itok=N_hv8JV2',
    'https://upload.wikimedia.org/wikipedia/commons/2/28/Guignardia_bidwellii_04.jpg',
  ];
  final List<String> name = <String>[
    "Powedery mildew",
    "Downy mildew",
    "Anthracnose",
    "Black rot",
  ];
  final List<String> info = <String>[
    "Powdery mildew, plant disease of worldwide occurrence that causes a powdery growth on the surface of leaves, buds, young shoots, fruits, and flowers. Powdery mildew is caused by many specialized races of fungal species in the genera Erysiphe, Microsphaera, Phyllactinia, Podosphaera, Sphaerotheca, and Uncinula. Hundreds of species of trees, shrubs, vines, flowers, vegetables, fruits, grasses, field crops, and weeds can be affected by powdery mildew ",
    "The fungus is an obligate pathogen which can attack all green parts of the vine.Symptoms of this disease are frequently confused with those of powdery mildew. Infected leaves develop pale yellow-green lesions which gradually turn brown. Severely infected leaves often drop prematurely.Infected petioles, tendrils, and shoots often curl, develop a shepherd's crook, and eventually turn brown and die.Young berries are highly susceptible to infection and are often covered with white fruiting structures of the fungus. Infected older berries of white cultivars may turn dull gray-green, whereas those of black cultivars turn pinkish red.",
    "Anthracnose is a fungal disease that tends to attack plants in the spring when the weather is cool and wet, primarily on leaves and twigs. The fungi overwinter in dead twigs and fallen leaves. Cool, rainy weather creates perfect conditions for the spores to spread.",
    "The disease attacks the leaves, stem, flowers and berries. All the new growth on the vineis prone to attack during the growing season.The symptoms are in the form of irregularly shapedreddish brown spots on the leaves and a black scab on berries.Occasionally, small elliptical darkcoloured canker lesions occur on the young stems and tendrils. Leaf, cane and tendril infection canoccur only when the tissue is young, but berries can be infected until almost fully-grown if an activefungicide residue is not present.The affected berries shrivel and become hard black mummies.",
  ];



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ListView.builder(
            itemCount: name.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                width: double.infinity,
                child: Card(

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(
                        img[index],
                        height: 250,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text(
                              name[index],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(info[index]),
                          ],
                        ),
                      )
                      
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
