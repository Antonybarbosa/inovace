SELECT 

CDEMPRESA,
CODVEND,
APELIDO,
COUNT(dtvisita) AS DIAS_VISITA,
SUM(FACEAMENTO) AS FACEAMENTOS,
ROUND((SUM(FACEAMENTO)*100/(COUNT(dtvisita)*2)),2) AS PERC

FROM

(select 

cdempresa,
ven.codvend,
apelido,
dtvisita,
NVL((

SELECT NVL(count(DISTINCT(FC.CDCLIENTE)),0) 
FROM nnpessoawvwebprd.tblvwfaceamentoestoque fc  
WHERE 
fc.dtcadastro = dtvisita 
AND fc.cdrepresentante = codvend
HAVING count(DISTINCT(FC.CDCLIENTE))>=2

),0) as faceamento

from

NNPESSOAWVWEBPRD.tblvwvisita,
TGFVEN VEN

where 

CDREPRESENTANTE = VEN.CODVEND AND
DTVISITA between :dtini and :dtfim
and cdempresa = :codemp  
AND CDREPRESENTANTE not in (43,35,52,42, 54,58,62,59)
--and CDREPRESENTANTE = :codvend 
and dtvisita = dtsaidavisita 

group by 

cdempresa,
ven.codvend,
apelido,
dtvisita

order by 

nnpessoawvwebprd.tblvwvisita.dtvisita)

GROUP BY 
CDEMPRESA,
CODVEND,
APELIDO

order by perc desc