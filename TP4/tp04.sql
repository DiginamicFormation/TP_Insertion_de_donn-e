--Objectifs du TP
--Apprendre à écrire des requêtes SQL avec les diverses clauses possibles :
--WHERE
--ORDER BY
--GROUP BY
--HAVING


-- Question 2a: Listez les articles dans l'ordre alphabétique des désignations
SELECT * 
FROM ARTICLE 
ORDER BY DESIGNATION;

-- Question 2b: Listez les articles dans l'ordre des prix du plus élevé au moins élevé
SELECT * 
FROM ARTICLE 
ORDER BY PRIX DESC;

-- Question 2c: Listez tous les articles qui sont des « boulons » et triez les résultats par ordre de prix ascendant
SELECT * 
FROM ARTICLE 
WHERE DESIGNATION LIKE '%boulon%'
ORDER BY PRIX ASC;

-- Question 2d: Listez tous les articles dont la désignation contient le mot « sachet »
SELECT * 
FROM ARTICLE 
WHERE DESIGNATION LIKE '%sachet%';

-- Question 2e: Listez tous les articles dont la désignation contient le mot « sachet » indépendamment de la casse !
SELECT * 
FROM ARTICLE 
WHERE LOWER(DESIGNATION) LIKE '%sachet%';

-- Question 2f: Listez les articles avec les informations fournisseur correspondantes

SELECT ARTICLE.*, FOURNISSEUR.NOM as NOM_FOURNISSEUR
FROM ARTICLE
INNER JOIN FOURNISSEUR ON ARTICLE.ID_FOU = FOURNISSEUR.ID
ORDER BY FOURNISSEUR.NOM ASC, ARTICLE.PRIX DESC;

-- Question 2g: Listez les articles de la société « Dubois & Fils »
SELECT ARTICLE.*, FOURNISSEUR.NOM
FROM ARTICLE
INNER JOIN FOURNISSEUR ON ARTICLE.ID_FOU = FOURNISSEUR.ID
WHERE FOURNISSEUR.NOM = 'Dubois et Fils';

-- Question 2h: Calculez la moyenne des prix des articles de la société « Dubois & Fils »
SELECT 
    FOURNISSEUR.NOM,
    ROUND(AVG(ARTICLE.PRIX), 2) as MOYENNE_PRIX
FROM ARTICLE
INNER JOIN FOURNISSEUR ON ARTICLE.ID_FOU = FOURNISSEUR.ID
WHERE FOURNISSEUR.NOM = 'Dubois et Fils'
GROUP BY FOURNISSEUR.NOM;

-- Question 2i: Calculez la moyenne des prix des articles de chaque fournisseur
SELECT 
    FOURNISSEUR.NOM,
    ROUND(AVG(ARTICLE.PRIX), 2) as MOYENNE_PRIX,
    COUNT(ARTICLE.ID) as NOMBRE_ARTICLES
FROM ARTICLE
INNER JOIN FOURNISSEUR ON ARTICLE.ID_FOU = FOURNISSEUR.ID
GROUP BY FOURNISSEUR.ID, FOURNISSEUR.NOM
ORDER BY MOYENNE_PRIX DESC;

-- Question 2j: Sélectionnez tous les bons de commande émis entre le 01/03/2019 et le 05/04/2019 à 12h00
SELECT * 
FROM BON 
WHERE DATE_CMDE BETWEEN '2019-03-01' AND '2019-04-05';

-- Question 2k: Sélectionnez les divers bons de commande qui contiennent des boulons
SELECT DISTINCT BON.*
FROM BON
INNER JOIN COMPO ON BON.ID = COMPO.ID_BON
WHERE COMPO.ID_ART IN (
    SELECT ID FROM ARTICLE 
    WHERE LOWER(DESIGNATION) LIKE '%boulon%'
);

-- Question 2l: Sélectionnez les divers bons de commande qui contiennent des boulons avec le nom du fournisseur associé
SELECT DISTINCT 
    BON.NUMERO,
    BON.DATE_CMDE,
    FOURNISSEUR.NOM as NOM_FOURNISSEUR
FROM BON
INNER JOIN FOURNISSEUR ON BON.ID_FOU = FOURNISSEUR.ID
INNER JOIN COMPO ON BON.ID = COMPO.ID_BON
INNER JOIN ARTICLE ON COMPO.ID_ART = ARTICLE.ID
WHERE LOWER(ARTICLE.DESIGNATION) LIKE '%boulon%';

-- Question 2m: Calculez le prix total de chaque bon de commande
SELECT 
    BON.ID,
    BON.NUMERO,
    BON.DATE_CMDE,
    SUM(ARTICLE.PRIX * COMPO.QTE) as PRIX_TOTAL
FROM BON
INNER JOIN COMPO ON BON.ID = COMPO.ID_BON
INNER JOIN ARTICLE ON COMPO.ID_ART = ARTICLE.ID
GROUP BY BON.ID, BON.NUMERO, BON.DATE_CMDE
ORDER BY BON.ID;

-- Question 2n: Comptez le nombre d'articles de chaque bon de commande
SELECT 
    BON.ID,
    BON.NUMERO,
    COUNT(COMPO.ID_ART) as NOMBRE_ARTICLES_DIFFERENTS,
    SUM(COMPO.QTE) as QUANTITE_TOTALE
FROM BON
LEFT JOIN COMPO ON BON.ID = COMPO.ID_BON
GROUP BY BON.ID, BON.NUMERO
ORDER BY BON.ID;

-- Question 2o: Affichez les numéros de bons de commande qui contiennent plus de 25 articles 
SELECT 
    BON.ID,
    BON.NUMERO,
    SUM(COMPO.QTE) as TOTAL_ARTICLES
FROM BON
INNER JOIN COMPO ON BON.ID = COMPO.ID_BON
GROUP BY BON.ID, BON.NUMERO
HAVING SUM(COMPO.QTE) > 25
ORDER BY TOTAL_ARTICLES DESC;

-- Question 2p: Calculez le coût total des commandes effectuées sur le mois d'avril
SELECT 
    SUM(ARTICLE.PRIX * COMPO.QTE) as COUT_TOTAL_AVRIL
FROM BON
INNER JOIN COMPO ON BON.ID = COMPO.ID_BON
INNER JOIN ARTICLE ON COMPO.ID_ART = ARTICLE.ID
WHERE MONTH(BON.DATE_CMDE) = 4 AND YEAR(BON.DATE_CMDE) = 2019;

