 (SELECT 

count(1) 
FROM

(SELECT 

to_char(dtferiado,'dd/mm/')|| to_char(to_date(:dtini,'dd/mm/yyyy'),'yy') as dat

FROM 

TSIFER 

WHERE TO_CHAR(dtferiado,'MM') IN (TO_CHAR(to_date(:dtfim,'dd/mm/yyyy'),'mm'), to_char(to_date(:dtini,'dd/mm/yyyy'),'mm')))) as feriado

