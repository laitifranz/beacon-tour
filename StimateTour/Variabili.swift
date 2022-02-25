//
//  Variabili.swift
//  StimateTour
//
//  Created by Francesco Laiti on 12/11/17.
//  Copyright © 2017 francescolaiti. All rights reserved.
//
import Foundation
//let iBeacon = [18722/*ipod*/,23782/*ipad bianco*/,5819/*ipad nero*/,16445/*iphone */]
let iBeacon = [
    283,//chiostro
    70, //atrio colonne
    339,//marani
    184,//antica cucina
    301,//sala benciolini
    267,//bandiere
    284,//sala degli archi
    175,//sala santi
    68,//ingresso ufficiale
    182,//oratorio
    196,//chiesa stimate
]

var luogo = [
    iBeacon[0]: NSLocalizedString("chiostro", comment: "chiostro"),
    iBeacon[1]: NSLocalizedString("atrio_colonne", comment: "atrio colonne"),
    iBeacon[2]: NSLocalizedString("marani", comment: "marani"),
    iBeacon[3]: NSLocalizedString("antica_cucina", comment: "antica cucina"),
    iBeacon[4]: NSLocalizedString("sala_Benciolini", comment: "sala Benciolini"),
    iBeacon[5]: NSLocalizedString("bandiere", comment: "bandiere"),
    iBeacon[6]: NSLocalizedString("sala_degli_Archi", comment: "sala degli Archi"),
    iBeacon[7]: NSLocalizedString("sala_Santi", comment: "sala Santi"),
    iBeacon[8]: NSLocalizedString("ingresso_ufficiale", comment: "ingresso ufficiale"),
    iBeacon[9]: NSLocalizedString("oratorio", comment: "oratorio"),
    iBeacon[10]: NSLocalizedString("chiesa_Stimate", comment: "chiesa Stimate"),
    000: "null",
    ]

let descrizione = [
    iBeacon[0]: NSLocalizedString("chiostro1", comment: "chiostro1"),
    iBeacon[1]: NSLocalizedString("atrio_colonne1", comment: "atrio colonne1"),
    iBeacon[2]: NSLocalizedString("marani1", comment: "marani1"),
    iBeacon[3]: NSLocalizedString("antica_cucina1", comment: "antica cucina1"),
    iBeacon[4]: NSLocalizedString("sala_Benciolini1", comment: "sala Benciolini1"),
    iBeacon[5]: NSLocalizedString("bandiere1", comment: "bandiere1"),
    iBeacon[6]: NSLocalizedString("sala_degli_Archi1", comment: "sala degli Archi1"),
    iBeacon[7]: NSLocalizedString("sala_Santi1", comment: "sala Santi1"),
    iBeacon[8]: NSLocalizedString("ingresso_ufficiale1", comment: "ingresso ufficiale1"),
    iBeacon[9]: NSLocalizedString("oratorio1", comment: "oratorio1"),
    iBeacon[10]: NSLocalizedString("chiesa_Stimate1", comment: "chiesa Stimate1"),
    
    000: "null",
    
    ]

var posizioneX = [
    iBeacon[0]: 45.434992,
    iBeacon[1]: 45.435084,
    iBeacon[2]: 45.435033,
    iBeacon[3]: 45.434972,
    iBeacon[4]: 45.434988,
    iBeacon[5]: 45.435173,
    iBeacon[6]: 45.435226,
    iBeacon[7]: 45.435268,
    iBeacon[8]: 45.435340,
    iBeacon[9]: 45.435252,
    iBeacon[10]: 45.435139,
    
    000: 45.435721,
    
    ]

var posizioneY = [
    iBeacon[0]: 10.993969,
    iBeacon[1]: 10.993608,
    iBeacon[2]: 10.993539,
    iBeacon[3]: 10.993467,
    iBeacon[4]: 10.993599,
    iBeacon[5]: 10.993602,
    iBeacon[6]: 10.993652,
    iBeacon[7]: 10.993505,
    iBeacon[8]: 10.993238,
    iBeacon[9]: 10.993157,
    iBeacon[10]: 10.993165,
    
    000: 10.993328,
    
    ]

var immagineDisplay = [
    
    iBeacon[0]: ["chiostro.JPG"],
    iBeacon[1]: ["atrio_c.JPG"],
    iBeacon[2]: ["marani.JPG","marani2.JPG"],
    iBeacon[3]: ["vecchia_c.JPG"],
    iBeacon[4]: ["benciolini.JPG"],
    iBeacon[5]: ["sala_bandiere.JPG"],
    iBeacon[6]: [""],
    iBeacon[7]: ["sala_santi.JPG","sala_santi2.JPG","sala_santi3.JPG"],
    iBeacon[8]: [""],
    iBeacon[9]: ["oratorio.JPG","oratorio1.JPG","oratorio2.JPG"],
    iBeacon[10]: ["chiesa.JPG","chiesa2.JPG","chiesa3.JPG","chiesa4.JPG"],

    000: [""],
    

    ]

//var codiceRegione = "8492E75F-4FD6-469D-B132-043FE94921D8" //estimote
var codiceRegione = "83E8D0D2-6599-4196-BDC7-2887937200F1" //joinTag

