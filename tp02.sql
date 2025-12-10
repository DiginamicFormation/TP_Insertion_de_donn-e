USE compta;


INSERT INTO FOURNISSEUR (ID, NOM) VALUES
(1, 'Française d’Imports'),
(2, 'FDM SA'),
(3, 'Dubois & Fils');


INSERT INTO ARTICLE (ID, REF, DESIGNATION, PRIX, ID_FOU) VALUES
(1, 'A01', 'Perceuse P1', 74.99, 1),
(2, 'F01', 'Boulon laiton 4 x 40 mm (sachet de 10)', 2.25, 2),
(3, 'F02', 'Boulon laiton 5 x 40 mm (sachet de 10)', 4.45, 2),
(4, 'D01', 'Boulon laiton 5 x 40 mm (sachet de 10)', 4.40, 3),
(5, 'A02', 'Meuleuse 125mm', 37.85, 1),
(6, 'D03', 'Boulon acier zingué 4 x 40mm (sachet de 10)', 1.80, 3),
(7, 'A03', 'Perceuse à colonne', 185.25, 1),
(8, 'D04', 'Coffret mèches à bois', 12.25, 3),
(9, 'F03', 'Coffret mèches plates', 6.25, 2),
(10,'F04', 'Fraîses d\'encastrement', 8.14, 2);


INSERT INTO BON (ID, NUMERO, DATE_CMDE, DELAI, ID_FOU)
VALUES (1, 'BC001', '2025-02-01', 3, 1);

INSERT INTO COMPO (ID, QTE, ID_ART, ID_BON) VALUES
(1, 3, 1, 1),
(2, 4, 5, 1),
(3, 1, 7, 1);