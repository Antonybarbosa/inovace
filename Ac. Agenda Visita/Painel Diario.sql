
SELECT
CODIGO,
APELIDO,
(SELECT min(dtchegadavisita ||' '|| hrchegadavisita) 
FROM NNPESSOAWVWEBPRD.tblvwvisita WHERE cdrepresentante = CODIGO and dtvisita = dtsaidavisita and DTVISITA = :dtini )  AS PRIMEIRA_VISITA,
(SELECT MAX(dtsaidavisita ||' '|| hrsaidavisita) 
FROM NNPESSOAWVWEBPRD.tblvwvisita WHERE cdrepresentante = CODIGO and dtvisita = dtsaidavisita and DTVISITA = :dtini )  AS ULTIMA_VISITA,
QTD as Visitas,
VISITA_AGENDA,
(SELECT 
 --DT,
 --dia, 
 --semana,  
 (SELECT COUNT(1) FROM NNPESSOAWVWEBPRD.tblvwagendavisita where cdempresa = :codemp  and cdrepresentante = codigo and flativo = 'S' and nudiasemana = p_dia and flsemanames = p_semana) qtd
 
 from
 
 
 
 (SELECT 
   dt 
  , TO_CHAR(dt, 'DY' , 'NLS_DATE_LANGUAGE=PORTUGUESE') dia
  , CASE 
  WHEN dt - 8+TO_CHAR(TRUNC(dt,'MM'), 'D') <  TRUNC(dt,'MM')  THEN 1
 ELSE TO_CHAR (dt - 8+TO_CHAR(TRUNC(dt,'MM'), 'D') , 'W')+1     
  END semana
 ,DECODE( TO_CHAR(dt, 'DY' , 'NLS_DATE_LANGUAGE=PORTUGUESE'),
 'SEG', 2, 
 'TER',3, 
 'QUA', 4, 
 'QUI', 5, 
 'SEX', 6, 
'SÁB',7,'DOM',1)  p_dia  
 , 
 
 decode(CASE 
  WHEN dt - 8+TO_CHAR(TRUNC(dt,'MM'), 'D') <  TRUNC(dt,'MM')  THEN 1
 ELSE TO_CHAR (dt - 8+TO_CHAR(TRUNC(dt,'MM'), 'D') , 'W')+1     
  END, '1',1,'2',2,'3',3,'4',4,'5',5) p_semana
FROM (SELECT TRUNC(TO_DATE(to_date(:dtini,'dd/mm/yyyy'))) + ROWNUM-1 dt        
             FROM all_objects
             WHERE 
             ROWNUM<=1))) agendado,
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
    COUNT(DISTINCT(CASE WHEN flvisitaagendada = 'S' THEN CDCLIENTE END)) AS VISITA_AGENDA, 

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
and cdempresa = :codemp  
and dtvisita = dtsaidavisita 
AND CDREPRESENTANTE not in (43,35,52,42, 54,58,62,59)
--AND CDREPRESENTANTE = 3
group by dtvisita, cdrepresentante, VEN.APELIDO
)