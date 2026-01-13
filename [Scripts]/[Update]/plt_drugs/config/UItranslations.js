const ConfiguredLanguage = 'en'; // 'en' or 'pl'

export const translations = {
  en: {
    potStatusTitle: "Pot Status",
    potStatusSubtitle: "Keep the plant healthy by filling all the bars",
    waterLevel: "Water Level",
    fertilizer: "Fertilizer",
    fans: "Fans",
    lights: "Lights",
    growth: "Growth",
    plantWeed: "Plant weed",
    plantCoke: "Plant coke",
    harvestWeed: "Harvest weed",
    harvestCoke: "Harvest coke",
    dryingRackTitle: "DRYING RACK",
    dryingRackInstructions: "Drag an item to dry it. Max capacity: 20",
    drying: "DRYING",
    takeOut: "TAKE OUT",
    claim: "Claim",
    confirm: "Confirm",
    brickPressInstructions: "Put in 20x dried weed or dried coke and brick it",
    drugOvenTitle: "DRUG OVEN",
    drugOvenInstructions: "Place 10x drugs or 1x liquid meth to oven it",
    cook: "Cook",
    packagingStationTitle: "PACKAGING STATION",
    packagingStationInstructions: "Place up to 10 drugs and 10 baggies to package",
    package: "Package",
    mixerStationTitle: "DRUG MIXER",
    mixerStationInstructions: "Place a base drug and an ingredient to create a new substance",
    base: "BASE",
    ingredient: "INGREDIENT",
    result: "RESULT",
    mix: "Mix",
    chemistryStationTitle: "CHEMISTRY STATION",
    chemistryStationInstructions: "Place ingredients to synthesize a new substance.",
    pseudo: "PSEUDO",
    acetone: "ACETONE",
    phosphorus: "PHOSPHORUS",
    cauldronStationTitle: "CAULDRON STATION",
    cauldronStationInstructions: "Place a base drug, gasoline, and acetone to create a new substance",
    gasoline: "GASOLINE",
    shopTitle: "BLACK MARKET",
    shopInstructions: "Select an item to purchase",
    close: "Close",
    buy: "BUY",
    perPiece: "/pcs",
    tooLateToFertilize: "Too late to fertilize"
  },
  pl: {
    potStatusTitle: "Status",
    potStatusSubtitle: "Utrzymuj roślinę w zdrowiu, wypełniając wszystkie paski",
    waterLevel: "Poziom Wody",
    fertilizer: "Nawóz",
    fans: "Wentylatory",
    lights: "Światła",
    growth: "Wzrost",
    plantWeed: "Zasadź marihuanę",
    plantCoke: "Zasadź kokainę",
    harvestWeed: "Zbierz marihuanę",
    harvestCoke: "Zbierz kokainę",
    dryingRackTitle: "SUSZARNIA",
    dryingRackInstructions: "Przeciągnij przedmiot, aby go wysuszyć. Maksymalna pojemność: 20",
    drying: "SUSZENIE",
    takeOut: "DO ODBIORU",
    claim: "Odbierz",
    confirm: "Zatwierdź",
    brickPressInstructions: "Włóż 20x suszonej marihuany lub suszonej kokainy i sprasuj",
    drugOvenTitle: "PIEC DO NARKOTYKÓW",
    drugOvenInstructions: "Umieść narkotyki w piecu, aby je przetworzyć",
    cook: "Gotuj",
    packagingStationTitle: "STANOWISKO PAKOWANIA",
    packagingStationInstructions: "Umieść do 10 narkotyków i 10 woreczków, aby je spakować",
    package: "Pakuj",
    mixerStationTitle: "MIKSOWNIK NARKOTYKÓW",
    mixerStationInstructions: "Umieść bazę i składnik, aby stworzyć nową substancję",
    base: "BAZA",
    ingredient: "SKŁADNIK",
    result: "WYNIK",
    mix: "Mieszaj",
    chemistryStationTitle: "STANOWISKO CHEMICZNE",
    chemistryStationInstructions: "Umieść składniki, aby zsyntetyzować nową substancję.",
    pseudo: "PSEUDO",
    acetone: "ACETON",
    phosphorus: "FOSFOR",
    cauldronStationTitle: "KOCIOŁ",
    cauldronStationInstructions: "Umieść bazę, benzynę i aceton, aby stworzyć nową substancję",
    gasoline: "BENZYNA",
    shopTitle: "CZARNY RYNEK",
    shopInstructions: "Wybierz przedmiot do zakupu",
    close: "Zamknij",
    buy: "KUP",
    perPiece: "/szt.",
    tooLateToFertilize: "Za poźno na nawóz"
  },
};

export function getTrans(key) {
    const lang = translations[ConfiguredLanguage] ? ConfiguredLanguage : 'en';
    return translations[lang][key] || key;
}

export function initLocale() {
  const lang = translations[ConfiguredLanguage] ? ConfiguredLanguage : 'en';
  const t = translations[lang];

  $(".status-header h1").text(t.potStatusTitle);
  $(".status-header h2").text(t.potStatusSubtitle);
  $("#water-level .label").text(t.waterLevel);
  $("#fertilizer .label").text(t.fertilizer);
  $("#fans .label").text(t.fans);
  $("#lights .label").text(t.lights);
  $("#growth-level .label").text(t.growth);
  $("#plantweed .label").text(t.plantWeed);
  $("#plantcoke .label").text(t.plantCoke);
  $("#harvestweed .label").text(t.harvestWeed);
  $("#harvestcoke .label").text(t.harvestCoke);

  $(".ui-container .main-panel h1").text(t.dryingRackTitle);
  $(".ui-container .instructions").text(t.dryingRackInstructions);
  $(".ui-container .column:first-child .column-header").text(t.drying);
  $(".ui-container .column:nth-child(2) .column-header").text(t.takeOut);
  $("#claimButton").text(t.claim);
  $("#confirmDryingButton").text(t.confirm);

  $(".brickpress .instructions2").text(t.brickPressInstructions);
  $("#ConfirmBrickPress").text(t.confirm);

  $(".drug-oven .main-panel h1").text(t.drugOvenTitle);
  $(".drug-oven .instructions").text(t.drugOvenInstructions);
  $("#ConfirmDrugOven").text(t.cook);

  $(".packaging-station .main-panel h1").text(t.packagingStationTitle);
  $(".packaging-station .instructions").text(t.packagingStationInstructions);
  $("#ConfirmPackaging").text(t.package);

  $(".mixer-station .main-panel h1").text(t.mixerStationTitle);
  $(".mixer-station .instructions").text(t.mixerStationInstructions);
  $(".mixer-station .column:first-child .column-header").text(t.base);
  $(".mixer-station .column:nth-child(3) .column-header").text(t.ingredient);
  $(".mixer-station .column:last-child .column-header").text(t.result);
  $("#ConfirmMix").text(t.mix);

  $(".chemistry-station .main-panel h1").text(t.chemistryStationTitle);
  $(".chemistry-station .instructions").text(t.chemistryStationInstructions);
  $(".chemistry-station .column:nth-child(1) .column-header").text(t.pseudo);
  $(".chemistry-station .column:nth-child(3) .column-header").text(t.acetone);
  $(".chemistry-station .column:nth-child(5) .column-header").text(t.phosphorus);
  $(".chemistry-station .column:last-child .column-header").text(t.result);
  $("#ConfirmChemistry").text(t.cook);

  $(".cauldron-station .main-panel h1").text(t.cauldronStationTitle);
  $(".cauldron-station .instructions").text(t.cauldronStationInstructions);
  $(".cauldron-station .column:nth-child(1) .column-header").text(t.base);
  $(".cauldron-station .column:nth-child(3) .column-header").text(t.gasoline);
  $(".cauldron-station .column:nth-child(5) .column-header").text(t.acetone);
  $(".cauldron-station .column:last-child .column-header").text(t.result);
  $("#ConfirmCauldron").text(t.cook);

  $(".shop-ui #shopTitle").text(t.shopTitle);
  $(".shop-ui .instructions").text(t.shopInstructions);
  $("#CloseShop").text(t.close);
}
