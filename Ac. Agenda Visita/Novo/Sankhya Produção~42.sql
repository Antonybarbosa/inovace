select 

codigo, apelido, count(agenda) qtd, sum(case when perc >=90 then 1 else 0 end) realizado/*realizado 90% do dia*/

from
(select 

codigo, apelido, dtvisita, agenda, visita_agenda, round((visita_agenda/agenda)*100,0) as perc

from


(SELECT 
dt,
(SELECT COUNT(1) FROM NNPESSOAWVWEBPRD.tblvwagendavisita T where T.cdempresa = :codemp  and T.cdrepresentante = 1 and T.flativo = 'S' and T.nudiasemana = p_dia and T.flsemanames = p_semana) agenda
from
(SELECT 
  dt 
 ,TO_CHAR(dt, 'DY' , 'NLS_DATE_LANGUAGE=PORTUGUESE') dia
  ,CASE 
  WHEN dt - 8+TO_CHAR(TRUNC(dt,'MM'), 'D') <  TRUNC(dt,'MM')  THEN 1
  ELSE TO_CHAR (dt - 8+TO_CHAR(TRUNC(dt,'MM'), 'D') , 'W')+1     
  END semana
 ,DECODE( TO_CHAR(dt, 'DY' , 'NLS_DATE_LANGUAGE=PORTUGUESE'),
 'SEG', 2, 
 'TER',3, 
 'QUA', 4, 
 'QUI', 5, 
 'SEX', 6, 
 'SÁB',7,'DOM',1)  p_dia, 

 decode(CASE 
  WHEN dt - 8+TO_CHAR(TRUNC(dt,'MM'), 'D') <  TRUNC(dt,'MM')  THEN 1
 ELSE TO_CHAR (dt - 8+TO_CHAR(TRUNC(dt,'MM'), 'D') , 'W')+1     
  END, '1',1,'2',2,'3',3,'4',4,'5',5) p_semana
FROM (SELECT (TO_DATE(to_date(:dtini,'dd/mm/yyyy'))) + ROWNUM-1 dt        
             FROM all_objects
             WHERE 
             ROWNUM<= ((to_date(:dtfim,'dd/mm/yyyy')) - (to_date(:dtini,'dd/mm/yyyy')))+1 )) where p_dia not in ( 1, 7)) a
             
             full outer join 
             
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
AND CDREPRESENTANTE not in (43,35,52,42, 54,58,62,59,55,10,2)
group by  cdrepresentante, VEN.APELIDO,DTVISITA order by codigo, dtvisita) b on a.dt=b.dtvisita where agenda is not null order by b.codigo, b.dtvisita) group by codigo, apelido