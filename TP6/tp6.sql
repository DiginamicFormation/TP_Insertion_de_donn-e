-- a. Supprimer dans la table compo toutes les lignes concernant les bons de commande d'avril 2019

DELETE FROM COMPO
WHERE ID_BON IN (
    SELECT ID 
    FROM BON 
    WHERE MONTH(DATE_CMDE) = 4 AND YEAR(DATE_CMDE) = 2019
);
-- b. Supprimer dans la table bon tous les bons de commande d'avril 2019.

DELETE FROM BON
WHERE MONTH(DATE_CMDE) = 4 AND YEAR(DATE_CMDE) = 2019;