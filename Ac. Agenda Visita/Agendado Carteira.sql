 SELECT 
 DT,dia, semana,  (SELECT COUNT(1) FROM NNPESSOAWVWEBPRD.tblvwagendavisita where cdrepresentante = 1 and flativo = 'S' and nudiasemana = p_dia and flsemanames = p_semana) qtd
 
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
             ROWNUM<=1))--((to_date(:dtini,'dd/mm/yyyy')) - TRUNC(to_date(:dtini,'dd/mm/yyyy'),'MM')) ))