(

SELECT 

CODIGO,
APELIDO,


AGENDADO,
VISITA_AGENDA,
QTD,
ROUND(VISITA_AGENDA*100/agendado,2) AS PERC


FROM

(


SELECT 

CODIGO,
APELIDO,
QTD, 
VISITA_AGENDA,
(SELECT 

 SUM((SELECT COUNT(1) FROM NNPESSOAWVWEBPRD.tblvwagendavisita T where T.cdempresa = :codemp  and T.cdrepresentante = CODIGO and T.flativo = 'S' and T.nudiasemana = p_dia and T.flsemanames = p_semana)) qtd

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
FROM (SELECT (TO_DATE(to_date(:dtini,'dd/mm/yyyy'))) + ROWNUM-1 dt        
             FROM all_objects
             WHERE 
             ROWNUM<= ((to_date(:dtfim,'dd/mm/yyyy')) - (to_date(:dtini,'dd/mm/yyyy')))+1 ))) agendado

             FROM
(SELECT
    cdrepresentante AS CODIGO,
    VEN.APELIDO,
    COUNT(DISTINCT(CDCLIENTE)) AS QTD, 
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
group by  cdrepresentante, VEN.APELIDO)

)
)