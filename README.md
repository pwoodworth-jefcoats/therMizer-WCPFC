# therMizer-WCPFC

This repository holds code for collaboration to run therMizer over the WCPFC domain.

Collaboration elements include:  
* incorporating spatial heteorogeneity and/or movement into therMizer,
* adding structural and parametric uncertainty to simulations, and
* providing probability distributions for estimates.

This ReadMe will be further updated as the collaboration comes together.

---

### WCPFC convention area
The boundaries of the WCPFC convention area are:  
* 141°E from the south coast of Australia to 55°S,  
* 55°S from 141°E to 150°E,  
* 150°E from 55°S to 60°S,  
* 60°S from 150°E to 130°W,  
* 130°W from 60°S to 4°S, 
* 4°S from 130°W to 150°W,  
* 150°W from 4°S to an unspecified northern latitude, presumably the coast of 
Alaska
(Article 3, [Convention on the Conservation and Management of Highly Migratory 
Fish Stocks in the Western and Central Pacific Ocean](https://www.wcpfc.int/doc/convention-conservation-and-management-highly-migratory-fish-stocks-western-and-central-pacific), 
5 September 2000).  
The [convention area map](https://www.wcpfc.int/doc/convention-area-map) has a 
northern boundary of about 55°N, but we can use 50°N to avoid the Aleutian 
Islands.

This area is further broken down into 9 regions for bigeye tuna (Day et al. 
2023, Ducharme-Barth et al. 2020, Harley et al. 2014) though recent work has 
suggested that these regions could be simplified to six (Hamer et al. 2023).

Oceanographically, the WCPFC convention area could be separated into areas 
including the equatorial upwelling zone, Western Pacific Warm Pool, Kuroshio
Current and extension region, North Pacific subtropical gyre, North Pacific
Transition Zone, South Pacific subtropical gyre, and South Pacific convergence
zone.  These regions are defined through a variety of variables including sea
surface temperature, chlorophyll-a concentration, and geostrophic currents, and
have footprints which vary seasonally.

The WCPFC convention area can additionally be delineated as either high-seas or
waters within countries' EEZs, and EEZs can further be grouped as those which are
and are not parties to the Nauru Agreement (e.g., Bell et al. 2021).

---

### References
Bell JD, Senina I, Adams T, Aumont O, Calmettes B, Clark S, et al. 
(2021). Pathways to sustaining tuna-dependent Pacific Island economies during 
climate change. Nat. Sustain. 4, 900–910. doi: 10.1038/s41893-021-00745-z

Day J, Magnusson A, Teears T, Hampton J, Davies N, Castillo Jordán C, Peatman T, 
Scott R, Scutt Phillips J, McKechnie S, Scott F, Yao N, Natadra R, Pilling G, 
Williams P, Hamer P. (2023). Stock assessment of bigeye tuna in the western and 
central Pacific Ocean: 2023 WCPFC-SC19-2023/SA-WP-05 (Rev. 2)

Ducharme-Barth N, Vincent M, Hampton J, Hamer P, Williams P, Pilling G. (2020).
Stock assessment of bigeye tuna in the western and central Pacific Ocean. 
WCPFC-SC16-2020/SA-WP-03 [REV3]

Hamer P, Macdonald J, Potts J, Vidal T, Teears T, Senina I. (2023). Review and 
analyses to inform conceptual models of population structure and spatial 
stratification of bigeye and yellowfin tuna assessments in the Western and 
Central Pacific Ocean. WCPFC-SC19-2023/SA-WP-02

Harley S,	Davies N,	Hampton J, McKechnie S. (2014). Stock Assessment of Bigeye 
Tuna in the Western and Central Pacific Ocean. WCPFC‐SC10‐2014/SA‐WP‐01 [Rev1]




