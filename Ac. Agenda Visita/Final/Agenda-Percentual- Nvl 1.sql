select 

codigo, 
apelido, 
round(case when positivado <>0 then qtd_dias/positivado else 0 end,2)  perc

from

(select 

codigo, 
apelido,
count(dtvisita) qtd_dias,

sum((case when agenda <> 0 then
      
      case when round((visita_agenda/agenda)*100,0) >= 90 then 1 else 0 end 
      
      else 0 end )) positivado

from

(select 

codigo, 
apelido, 
dtvisita, 
--agenda, 
visita_agenda, 
(SELECT COUNT(1) FROM NNPESSOAWVWEBPRD.tblvwagendavisita T where T.cdempresa = :codemp  and T.cdrepresentante = codigo and T.flativo = 'S' and T.nudiasemana = p_dia and T.flsemanames = p_semana) agenda--,
--round((visita_agenda/agenda)*100,0) as perc

from


(SELECT 

 dt,
 p_dia,
 p_semana

from
(SELECT 
    
  dt, 
 TO_CHAR(dt, 'DY' , 'NLS_DATE_LANGUAGE=PORTUGUESE') dia,
  CASE 
  WHEN dt - 8+TO_CHAR(TRUNC(dt,'MM'), 'D') <  TRUNC(dt,'MM')  THEN 1
  ELSE TO_CHAR (dt - 8+TO_CHAR(TRUNC(dt,'MM'), 'D') , 'W')+1     
  END semana,
  DECODE( TO_CHAR(dt, 'DY' , 'NLS_DATE_LANGUAGE=PORTUGUESE'),
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
AND CDREPRESENTANTE not in (43,35,52,42, 54,58,62,59,55,10,2,46)
group by  
cdrepresentante, 
VEN.APELIDO, 
DTVISITA 
order by 
codigo, 
dtvisita) b on a.dt=b.dtvisita order by b.codigo, b.dtvisita) where codigo is not null group by codigo, apelido)