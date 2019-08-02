
SELECT

CDREPRESENTANTE,
--QTD, 
--CHEGADA,
--SUBSTR(CHEGADA,12,8) AS CHEGADA, 
--SAIDA, 
--SUBSTR(SAIDA,12,8) AS SAIDA,
SUBSTR(CHEGADA - SAIDA,12,8) AS TOTAL


FROM
(
SELECT
    CDREPRESENTANTE,
    --COUNT(dtvisita) AS QTD,    
    numtodsinterval(sum(
    SUBSTR(to_char(TO_DATE(dtchegadavisita ||' '|| hrchegadavisita,'DD/MM/YYYY hh24:mi:ss'), 'hh24:mi:ss'), 1, 2)*3600 + 
    SUBSTR(to_char(TO_DATE(dtchegadavisita ||' '|| hrchegadavisita,'DD/MM/YYYY hh24:mi:ss'), 'hh24:mi:ss'), 4, 2)*60 + 
    SUBSTR(to_char(TO_DATE(dtchegadavisita ||' '|| hrchegadavisita,'DD/MM/YYYY hh24:mi:ss'), 'hh24:mi:ss'), 7, 2)), 'SECOND') AS CHEGADA,
    
    numtodsinterval(sum(
    SUBSTR(to_char(TO_DATE(dtsaidavisita ||' '|| hrsaidavisita,'DD/MM/YYYY hh24:mi:ss'), 'hh24:mi:ss'), 1, 2)*3600 + 
    SUBSTR(to_char(TO_DATE(dtsaidavisita ||' '|| hrsaidavisita,'DD/MM/YYYY hh24:mi:ss'), 'hh24:mi:ss'), 4, 2)*60 + 
    SUBSTR(to_char(TO_DATE(dtsaidavisita ||' '|| hrsaidavisita,'DD/MM/YYYY hh24:mi:ss'), 'hh24:mi:ss'), 7, 2)), 'SECOND') AS SAIDA

    

FROM

NNPESSOAWVWEBPRD.tblvwvisita 

WHERE 

DTVISITA = :dtini 
and cdempresa = 1
and dtvisita = dtsaidavisita 
AND CDREPRESENTANTE = 15
group by dtvisita, CDREPRESENTANTE
)