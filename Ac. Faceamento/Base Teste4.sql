SELECT 

(TO_DATE(to_date(:dtini,'dd/mm/yyyy'))) + ROWNUM-1 dt        
FROM all_objects
WHERE 
ROWNUM<= ((to_date(:dtfim,'dd/mm/yyyy')) - to_date(:dtini,'dd/mm/yyyy'))