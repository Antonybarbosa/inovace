(SELECT
    cdrepresentante AS CODIGO,
    VEN.APELIDO,
    DTVISITA,
    COUNT(DISTINCT(CASE WHEN flvisitaagendada = 'S' THEN CDCLIENTE END)) AS VISITA_AGENDA



FROM

NNPESSOAWVWEBPRD.tblvwvisita,
TGFVEN VEN

WHERE 
CDREPRESENTANTE = VEN.CODVEND AND
DTVISITA between :dtini and :dtfim
and cdempresa = :codemp  
and dtvisita = dtsaidavisita 
AND CDREPRESENTANTE not in (43,35,52,42, 54,58,62,59,55)
group by  cdrepresentante, VEN.APELIDO,DTVISITA order by codigo, dtvisita)