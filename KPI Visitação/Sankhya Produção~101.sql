
SELECT
CODIGO,
APELIDO,
(SELECT min(dtchegadavisita ||' '|| hrchegadavisita) 
FROM NNPESSOAWVWEBPRD.tblvwvisita WHERE cdrepresentante = CODIGO and dtvisita = dtsaidavisita and DTVISITA = :dtini )  AS PRIMEIRA_VISITA,
(SELECT MAX(dtsaidavisita ||' '|| hrsaidavisita) 
FROM NNPESSOAWVWEBPRD.tblvwvisita WHERE cdrepresentante = CODIGO and dtvisita = dtsaidavisita and DTVISITA = :dtini )  AS ULTIMA_VISITA,
QTD as Visitas,
--CHEGADA,
--SUBSTR(CHEGADA,12,8) AS CHEGADA, 
--SAIDA, 
--SUBSTR(SAIDA,12,8) AS SAIDA,
SUBSTR(CHEGADA - SAIDA,12,8) AS TEMPO_TOTAL,
SUBSTR((CHEGADA - SAIDA)/QTD,12,8) AS TEMPO_MEDIO,
(SELECT NVL(COUNT(DISTINCT(FC.CDCLIENTE)),0) FROM nnpessoawvwebprd.tblvwfaceamentoestoque fc  
WHERE fc.dtcadastro = :dtini AND fc.cdrepresentante = CODIGO) AS FACEAMENTO,
nvl((SELECT SUM(PD.VLTOTALPEDIDO) FROM NNPESSOAWVWEBPRD.TBLVWPEDIDO PD
 WHERE PD.CDREPRESENTANTE = CODIGO AND pd.dtfechamento = :dtini AND
 PD.CDTIPOPEDIDO IN(606,604)),0) AS VALOR_PEDIDOS

FROM
(
SELECT
    cdrepresentante AS CODIGO,
    VEN.APELIDO,
    COUNT(DISTINCT(CDCLIENTE)) AS QTD, 

    numtodsinterval(sum(
    SUBSTR(to_char(TO_DATE(dtchegadavisita ||' '|| hrchegadavisita,'DD/MM/YYYY hh24:mi:ss'), 'hh24:mi:ss'), 1, 2)*3600 + 
    SUBSTR(to_char(TO_DATE(dtchegadavisita ||' '|| hrchegadavisita,'DD/MM/YYYY hh24:mi:ss'), 'hh24:mi:ss'), 4, 2)*60 + 
    SUBSTR(to_char(TO_DATE(dtchegadavisita ||' '|| hrchegadavisita,'DD/MM/YYYY hh24:mi:ss'), 'hh24:mi:ss'), 7, 2)), 'SECOND') AS CHEGADA,
    
    numtodsinterval(sum(
    SUBSTR(to_char(TO_DATE(dtsaidavisita ||' '|| hrsaidavisita,'DD/MM/YYYY hh24:mi:ss'), 'hh24:mi:ss'), 1, 2)*3600 + 
    SUBSTR(to_char(TO_DATE(dtsaidavisita ||' '|| hrsaidavisita,'DD/MM/YYYY hh24:mi:ss'), 'hh24:mi:ss'), 4, 2)*60 + 
    SUBSTR(to_char(TO_DATE(dtsaidavisita ||' '|| hrsaidavisita,'DD/MM/YYYY hh24:mi:ss'), 'hh24:mi:ss'), 7, 2)), 'SECOND') AS SAIDA
    
    

FROM

NNPESSOAWVWEBPRD.tblvwvisita,
TGFVEN VEN

WHERE 
CDREPRESENTANTE = VEN.CODVEND AND
DTVISITA = :dtini 
and cdempresa = 2
and dtvisita = dtsaidavisita 
--AND CDREPRESENTANTE = 3
group by dtvisita, cdrepresentante, VEN.APELIDO
)