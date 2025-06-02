import 'dart:math';

import 'package:patriotic_pursuit/question.dart';

class Questions {
  static int unit6EconomicIndex = 0;
  static int unit6PoliticalIndex = 1;
  static int unit6SocialIndex = 2;
  static int unit7EconomicIndex = 3;
  static int unit7PoliticalIndex = 4;
  static int unit7SocialIndex = 5;

  static List<List<Question>> questions = [
    [
      Question('What labor system replaced slavery in the South?', 'sharecropping'),
      Question('What industry did Carnegie dominate?', 'steel'),
      Question('Who led the oil refining monopoly?', 'rockefeller'),
      Question('What act gave land to settlers?', 'homestead act'),
      Question('What railroad connected the East and West in 1869?', 'transcontinental railroad'),
      Question('What 1898 conflict marked the U.S. emergence as a world power?', 'spanish-american war'),
      Question('What 1890 law targeted monopolies?', 'sherman antitrust act'),
      Question('What 1887 law regulated railroads?', 'interstate commerce act'),
      Question('What tariff raised rates in 1890?', 'mckinley tariff'),
      Question('What 1873 event caused a depression?', 'panic of 1873'),
      Question('What business strategy did Carnegie use to control every step of the steel production process?', 'vertical integration'),
      Question('What business strategy did Rockefeller use to control the oil industry?', 'horizontal integration'),
      Question('What strike against a major steel company turned violent in 1892?', 'homestead strike'),
      Question('What invention allowed for faster communication across long distances in the late 1800s?', 'telegraph'),
      Question('Who opposed the gold standard due to falling crop prices?', 'farmers'),
    ],
    [
      Question('What laws enforced segregation in the South?', 'jim crow laws'),
      Question('What helped freedmen after the Civil War?', 'freedmen’s bureau'),
      Question('What philosophy justified inequality?', 'social darwinism'),
      Question('Who founded Hull House in Chicago (last name)?', 'addams'),
      Question('What religious movement pushed for social reform?', 'social gospel'),
      Question('Where did many immigrants live in cities?', 'tenements'),
      Question('What 1896 case upheld segregation?', 'plessy vs ferguson'),
      Question('What group was excluded by an 1882 law?', 'chinese'),
      Question('What did political machines trade for votes?', 'jobs'),
      Question('What schools aimed to assimilate Native Americans?', 'boarding schools'),
      Question('What ideology encouraged the rich to give back?', 'gospel of wealth'),
      Question('What immigrant group built many western railroads?', 'chinese'),
      Question('What group helped immigrants adapt to city life through education and social services?', 'settlement houses'),
      Question('Who faced nativism in urban areas?', 'immigrants'),
      Question('What social issue did settlement houses aim to address?', 'poverty'),
    ],
    [
      Question('Who became president after Lincoln (last name)?', 'johnson'),
      Question('What party led Reconstruction?', 'republicans'),
      Question('What agreement ended Reconstruction?', 'compromise of 1877'),
      Question('What 1883 act reformed civil service?', 'pendleton act'),
      Question('What act aimed to divide Native American tribal lands into individual plots?', 'dawes act'),
      Question('What event marked a major presidential dispute and led to a compromise in 1877?', 'election of 1876'),
      Question('What group was known for using violence and intimidation to oppose Reconstruction efforts?', 'ku klux klan'),
      Question('What political party emerged to represent farmers and laborers in the late 1800s?', 'populists'),
      Question('What system was introduced to make voting fairer by keeping ballots anonymous?', 'secret ballot'),
      Question('What fee did Southern states require voters to pay to prevent Black citizens from voting?', 'poll tax'),
      Question('What party wanted the U.S. to use silver as currency?', 'populists'),
      Question('What organization fought for an eight-hour workday and better labor conditions?', 'knights of labor'),
      Question('What party enforced segregation laws in the South?', 'democrats'),
      Question('What group was often excluded from voting?', 'blacks'),
      Question('What policy aimed to rebuild the South and protect rights of freed slaves after the Civil War?', 'reconstruction'),
    ],
    [
      Question('What was the day of the 1929 stock market crash called?', 'black tuesday'),
      Question('What 1930 tariff worsened the Great Depression?', 'hawley-smoot'),
      Question('What New Deal agency gave jobs to unemployed workers? (Abbreviation)', 'wpa'),
      Question('What New Deal program built dams and provided electricity in the South? (Abbreviation) ', 'tva'),
      Question('What 1935 law created retirement benefits for workers?', 'social security'),
      Question('What nickname was given to farmland ruined by drought?', 'dust bowl'),
      Question('What company revolutionized car production with the assembly line?', 'ford'),
      Question('What were FDR’s informal radio talks to Americans called?', 'fireside chats'),
      Question('What theory supports government spending during downturns?', 'keynesian'),
      Question('What was FDR’s overall economic recovery program called?', 'new deal'),
      Question('What nickname was given to makeshift homeless towns during the Depression?', 'hoovervilles'),
      Question('What plan helped Germany pay reparations after WWI?', 'dawes plan'),
      Question('What risky 1920s practice let people buy stocks with borrowed money?', 'margin'),
      Question('What laws were meant to break up monopolies and promote fair competition?', 'antitrust'),
      Question('What nickname was given to FDR’s programs?', 'alphabet agencies'),
    ],
    [
      Question('What president led the U.S. during WWI (last name)?', 'wilson'),
      Question('What law required young men to register for military service?', 'draft'),
      Question('What WWI law punished anti war speech?', 'sedition act'),
      Question('What 1913 law significantly lowered tariffs?', 'underwood tariff'),
      Question('What constitutional amendment banned alcohol?', '18th'),
      Question('What constitutional amendment gave women the right to vote? ', '19th'),
      Question('What foreign policy said the U.S. would stay out of Latin America?', 'good neighbor'),
      Question('What international peace group did the Senate reject after WWI?', 'league of nations'),
      Question('What country attacked Pearl Harbor in 1941?', 'japan'),
      Question('What president served more than two terms (last name)?', 'roosevelt'),
      Question('What scandal involved oil bribes during Harding’s presidency?', 'teapot dome'),
      Question('What president proposed the League of Nations (last name)?', 'wilson'),
      Question('What 1941 law let the U.S. send aid to Allied nations?', 'lend-lease'),
      Question('What court case upheld Japanese American internment?', 'korematsu'),
      Question('What president authorized Japanese internment camps (last name)?', 'roosevelt')
    ],
    [
      Question('What did women fight for in the early 1900s?', 'voting rights'),
      Question('What name was given to women who challenged norms in the 1920s?', 'flappers'),
      Question('What event celebrated African American culture in the 1920s?', 'harlem renaissance'),
      Question('What was the name for secret bars during Prohibition?', 'speakeasies'),
      Question('What 1911 fire led to major factory safety reforms?', 'triangle shirtwaist'),
      Question('What trial debated teaching evolution in schools?', 'scopes'),
      Question('What movement pushed to ban alcohol?', 'temperance'),
      Question('Who believed African Americans should gain economic success to earn respect (last name)?', 'washington'),
      Question('Who demanded immediate equality for African Americans (last name)?', 'du bois'),
      Question('What nickname was given to journalists exposing corruption?', 'muckrakers'),
      Question('What type of school was used to assimilate Native American children?', 'boarding'),
      Question('What Native American group’s language was used as secret code in WWII?', 'navajo'),
      Question('What was the movement of African Americans to northern cities for work called?', 'great migration'),
      Question('What reform movement led to child labor laws and better schools?', 'progressivism'),
      Question('What group filled factory jobs during WWII?', 'women')
    ]
  ];

  static Question getRandomQuestion(int index) {
    return questions[index][Random().nextInt(questions[index].length)];
  }
}
