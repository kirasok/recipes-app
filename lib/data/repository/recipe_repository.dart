import 'package:cooklang/cooklang.dart';

class RecipeRepository {
  static final RecipeRepository _instance = RecipeRepository._();

  RecipeRepository._();

  factory RecipeRepository() => _instance;

  List<String> source = [
    """
>> source: https://www.traderjoes.com/home/recipes/balsamic-lentil-saute
>> serves: 2
>> total time: 30 minutes

Add @red onion{1/2%medium} to a #large skillet{} on medium heat then stir in @olive oil{1%Tbsp} and @garlic{2%cloves}. Add @spinach{2%handfuls} and @bell pepper{1%medium} and cook until spinach begins to wilt.

Empty half the package of @lentils{1/2%package} into the mix and then add @sun-dried tomatoes{2%Tbsp}. Heat and stir another ~{2%minutes} and then mix in the @parsley{2%Tbsp} and @balsamic glaze{2%Tbsp}.

Divide @brown rice{1%pouch} onto individual #plates{} and #ladle{} sauté over each serving. ~{28%minutes}""",
    """
>> source: https://www.allrecipes.com/recipe/83307/jeanies-falafel/
>> serves: 6

Mash the @garbanzo beans{1%can} in a #large bowl{}. Stir in the @onion{1%small}, @garlic{2%cloves}, @cilantro{1.5%Tbsps}, @parsley{1%tsp}, @cumin{2%tsp}, @turmeric{1/8%tsp}, @baking powder{1/2%tsp}, @bread crumbs{1%cup}, @salt and @pepper. Do not be afraid to use your hands. Shape the mixture into 1-1/2 inch balls; you should get 18 to 24. If the mixture does not hold together, add a little water.

Heat the @oil in a #deep fryer{} to 375°F (190°C). Carefully drop the balls into the hot oil, and fry until brown. If you do not have a deep fryer, heat the oil in a heavy deep skillet over medium-high heat. You may need to adjust the heat slightly after the first couple of falafels, and be sure to turn frequently so they brown evenly.
  """,
    """
>> source: https://minimalistbaker.com/saucy-moroccan-spiced-lentils/
>> time required: 30 minutes
>> image: https://minimalistbaker.com/wp-content/uploads/2017/11/Moroccan-Lentils-SQUARE.jpg

Cook @lentils{1%cup} first by bringing @water{2%cup} to a boil and adding lentils. Bring back to a boil. Then reduce heat to low and simmer (uncovered) for about ~{20%minutes} or until lentils are tender.

In the meantime, to a #food processor{} or small blender, add @garlic{3%cloves}*, @onion{1%medium} or shallot*, @bell pepper{1%large}, @tomato paste{2%Tbsp}, @coconut sugar{2%Tbsp}, @sea salt{1/2%tsp}, @paprika{1%Tbsp}, @cumin{1%tsp}, @coriander{1/2%tsp}, @ginger{1%tsp}, @turmeric{1/2%tsp}, @cayenne pepper{1/2%tsp}, and @apple cider vinegar{2%Tbsp}. Mix to thoroughly combine.

Taste and adjust flavor as needed, adding more tomato paste for depth of flavor, spices for more overall flavor (especially coriander and paprika), cayenne for heat, coconut sugar for sweetness, apple cider vinegar for acidity, or salt for saltiness. Set aside.

Once the lentils have cooked, drain off any excess liquid and then add spice mixture and @parsley or cilantro{3/4%cup} and mix well to combine.

Enjoy immediately with salads, rice (or cauliflower rice), bowls, and more. Store leftovers in the refrigerator up to 4-5 days or in the freezer up to 1 month.
    """
  ];

  List<Recipe> get() =>
      List.from(source.map((recipe) => parseFromString(recipe)));
}
