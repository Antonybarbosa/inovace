Select 

count(1) 

from
(
SELECT 

(TO_DATE(to_date(:dtini,'dd/mm/yyyy'))) + ROWNUM-1 dt        
FROM all_objects
WHERE 
ROWNUM<= ((to_date(:dtfim,'dd/mm/yyyy')) - trunc(to_date(:dtini,'dd/mm/yyyy'),'MM'))+1
             )
             
             where 
             to_char(dt,'d')not in (1,7)