-- Fichier: tp05.sql
-- Base de données: compta2
-- Description: TP 05 - Mise à jour de données

-- ============================================
-- 1) DÉSACTIVATION DU MODE SAFE UPDATE
-- ============================================

-- EXPLICATION: Le mode safe update empêche les UPDATE/DELETE sans clause WHERE sur clé primaire
-- Cette commande permet d'exécuter les mises à jour en masse
SET SQL_SAFE_UPDATES = 0;



-- Ajout de données pour tester la question 3d (articles sans commande)
INSERT INTO ARTICLE (REF, DESIGNATION, PRIX, ID_FOU) VALUES 
('REF020', 'Article sans commande 1', 20.00, 1),
('REF021', 'Article sans commande 2', 15.50, 2),
('REF022', 'Article sans commande 3', 8.75, 3);

-- Modification de certaines désignations pour tester la question 3e
UPDATE ARTICLE SET DESIGNATION = 'Boulon (10mm acier)' WHERE ID = 11;
UPDATE ARTICLE SET DESIGNATION = 'Sachet (plastique recyclable)' WHERE ID = 12;
UPDATE ARTICLE SET DESIGNATION = 'Boulon (12mm inox)' WHERE ID = 13;




-- Question 3a: Mettez en minuscules la désignation de l'article dont l'identifiant est 2
UPDATE ARTICLE 
SET DESIGNATION = LOWER(DESIGNATION)
WHERE ID = 2;

-- Question 3b: Mettez en majuscules les désignations de tous les articles dont le prix est strictement supérieur à 10€
-- EXPLICATION: UPPER() convertit en majuscules, WHERE filtre sur PRIX > 10
UPDATE ARTICLE 
SET DESIGNATION = UPPER(DESIGNATION)
WHERE PRIX > 10.00;

-- Question 3c: Baissez de 10% le prix de tous les articles qui n'ont pas fait l'objet d'une commande

UPDATE ARTICLE 
SET PRIX = PRIX * 0.9
WHERE ID NOT IN (
    SELECT DISTINCT ID_ART 
    FROM COMPO
    WHERE ID_ART IS NOT NULL
);

-- Question 3d: Une erreur s'est glissée dans les commandes concernant Française d'imports. 
-- Il faut doubler les quantités de tous les articles commandés à cette société

UPDATE COMPO
SET QTE = QTE * 2
WHERE ID_BON IN (
    SELECT B.ID 
    FROM BON B
    INNER JOIN FOURNISSEUR F ON B.ID_FOU = F.ID
    WHERE F.NOM = "Française d'Imports"
);

-- Question 3e: Supprimez les éléments entre parenthèses dans les désignations

UPDATE ARTICLE
SET DESIGNATION = 
    CASE 
        -- Si on trouve une parenthèse ouvrante
        WHEN LOCATE('(', DESIGNATION) > 0 AND LOCATE(')', DESIGNATION) > LOCATE('(', DESIGNATION) THEN
            -- Prendre la partie avant '(' et la partie après ')'
            CONCAT(
                TRIM(SUBSTRING(DESIGNATION, 1, LOCATE('(', DESIGNATION) - 1)),
                TRIM(SUBSTRING(DESIGNATION, LOCATE(')', DESIGNATION) + 1))
            )
        -- Sinon garder la désignation originale
        ELSE DESIGNATION
    END
WHERE DESIGNATION LIKE '%(%' AND DESIGNATION LIKE '%)%';


