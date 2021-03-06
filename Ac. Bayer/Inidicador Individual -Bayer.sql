SELECT

CODVEND, 
APELIDO, 
NVL(SUM(CASE WHEN PERCENTUAL>=100 THEN 1 END),0) REALIZADO,
29 AS META,
ROUND((NVL(SUM(CASE WHEN PERCENTUAL>=100 THEN 1 END),0)*100/29),2) AS PERCENTUAL
--COUNT(PERCENTUAL) AS TOTAL

FROM


(
SELECT 
codvend, 
apelido,
CODPROD,
DESCRPROD,
NVL(REALIZADO,0) AS REALIZADO,
META,
NVL(REALIZADO,0)-META AS SALDO,
((NVL(REALIZADO,0)*100/META)) AS PERCENTUAL

FROM 

(SELECT 
B.codvend,
b.apelido,
B.CODPROD,
B.DESCRPROD,
MESES,
NVL(A.QTD,0) AS REALIZADO,
DECODE(b.codvend, 
1	,	CEIL(B.META*	0.09) *NVL(MESES,1)	,
9	,	CEIL(B.META*	0.04) *NVL(MESES,1)	,
15	,	CEIL(B.META*	0.04) *NVL(MESES,1)	,
42	,	CEIL(B.META*	0.07) *NVL(MESES,1)	,
3	,	CEIL(B.META*	0.16) *NVL(MESES,1)	,
31	,	CEIL(B.META*	0.065) *NVL(MESES,1),
53	,	CEIL(B.META*	0.03) *NVL(MESES,1)	,
4	,	CEIL(B.META*	0.055) *NVL(MESES,1),
17	,	CEIL(B.META*	0.025) *NVL(MESES,1),
39	,	CEIL(B.META*	0.045) *NVL(MESES,1),
20	,	CEIL(B.META*	0.01) *NVL(MESES,1)	,
7	,	CEIL(B.META*	0.02) *NVL(MESES,1)	,
19	,	CEIL(B.META*	0.06) *NVL(MESES,1)	,
8	,	CEIL(B.META*	0.155) *NVL(MESES,1),
5	,	CEIL(B.META*	0.055) *NVL(MESES,1),
16	,	CEIL(B.META*	0.02) *NVL(MESES,1)	,
30	,	CEIL(B.META*	0.045) *NVL(MESES,1),
49	,	CEIL(B.META*	0.02) *NVL(MESES,1)	,
12	,	CEIL(B.META*	0.065)	*NVL(MESES,1),
B.META*NVL(MESES,1))

AS META


FROM
(SELECT
cab.codvend,
ITE.CODPROD,
PR.DESCRPROD,
SUM(ITE.QTDNEG) AS QTD,
TO_NUMBER(TO_CHAR(TO_DATE(:dtfim,'DD/MM/YYYY'),'MM') - TO_CHAR(TO_DATE(:dtini,'DD/MM/YYYY'),'MM') + 1) MESES
FROM
TGFITE ITE,
TGFPRO PR,
TGFCAB CAB
WHERE
    cab.nunota = ite.nunota
AND ite.codprod = pr.codprod
AND cab.dtfatur BETWEEN :dtini AND :dtfim
AND cab.tipmov = 'V'
AND CAB.CODVEND not in (43,35,52,42, 54,58,62,59, 27, 40,2,32,44,20,11,10,17,14,64,24 )
--AND (CAB.CODVEND = :CODVEND OR (:CODVEND IS NULL))
AND CAB.STATUSNOTA = 'L'
AND PR.CODPROD IN (283,	281,	1142,	1155,	243,	246,	242,	5662,	
5746,	5747,	5748,	249,	3229,	3230,	3231,	3232,	247,	251,	252,	
253,	3046,	3163,	254,	255,	258,	257,	4548,	259,	261,	262,	
263,	264,	3589,	3590,	265,	4326,	267,	268,	7189,	271,	284,	
241,	273,	274,	3843,	5597,	5595,	5598,	5599)
    AND cab.codemp = 1
    AND CAB.CODTIPOPER  IN (700,703,706,707,709,715,723,724,725) GROUP BY ITE.CODPROD,PR.DESCRPROD, cab.codvend ) A
    
    FULL OUTER JOIN
    
    (SELECT 
    ven.codvend,
    ven.apelido,
    PRO.CODPROD,
    PRO.DESCRPROD,
    DECODE (PRO.CODPROD, 
    283,	3,
281,	1,
1142,	1,
1155,	1,
243,	15,
246,	13,
242,	11,
5662,	3,
5746,	3,
5747,	6,
5748,	6,
249,	4,
3229,	8,
3230,	13,
3231,	16,
3232,	6,
247,	8,
251,	12,
252,	15,
253,	6,
3046,	72,
3163,	60,
254,	58,
255,	50,
258,	223,
257,	119,
4548,	21,
259,	287,
261,	60,
262,	30,
263,	35,
264,	24,
3589,	70,
3590,	65,
265,	208,
4326,	282,
267,	469,
268,	642,
7189,	39,
271,	365,
284,	9,
241,	29,
273,	71,
274,	48,
3843,	690,
5597,	3,
5595,	27,
5598,	7,
5599,	3) AS META

FROM 

TGFPRO PRO,
TGFVEN VEN 

WHERE 

VEN.CODEMP = 1 
AND ven.codvend not in (43,35,52,42, 54,58,62,59, 27, 40,2,32,44,20,11,10,17,14,64,24) AND 
PRO.CODPROD IN (283,	281,	1142,	1155,	243,	246,	242,	5662,	
5746,	5747,	5748,	249,	3229,	3230,	3231,	3232,	247,	251,	252,	
253,	3046,	3163,	254,	255,	258,	257,	4548,	259,	261,	262,	
263,	264,	3589,	3590,	265,	4326,	267,	268,	7189,	271,	284,	
241,	273,	274,	3843,	5597,	5595,	5598,	5599)) B ON B.CODPROD = A.CODPROD and a.codvend = b.codvend) order by codvend ) GROUP BY CODVEND, APELIDO