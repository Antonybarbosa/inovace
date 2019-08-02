SELECT 

TO_CHAR(DTFERIADO,'d')

FROM
(SELECT 

to_char(dtferiado,'dd/mm'), to_char(:dtini,'yy') 

FROM 

TSIFER 

WHERE TO_CHAR(dtferiado,'MM') IN (TO_CHAR(to_date(:dtfim,'dd/mm/yyyy'),'mm'), to_char(to_date(:dtini,'dd/mm/yyyy'),'mm')))

WHERE

TO_CHAR(DTFERIADO,'d') not in (1,7)