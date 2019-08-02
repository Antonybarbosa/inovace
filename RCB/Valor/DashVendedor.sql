SELECT 
CODVEND,
VENDEDOR,
DECODE(GRUPO,
'FELINE HEALTH NUTRITION',	'F H N',
'FELINE HEALTH NUTRITION BREED',	'F H N BREED',
'FELINE HEALTH NUTRITION UMIDA',	'F H N UMIDA',
'FELINE HEALTH NUTRITION-PRO',	'F H N PRO',
'VET DIET CANINE SECA',	'V D C SECA',
'VET DIET CANINE UMIDA',	'V D C UMIDA',
'VET DIET FELINE SECA',	'V D F SECA',
'VET DIET FELINE UMIDA',	'V D F UMIDA',
GRUPO) AS GRUPO,

REALIZADO,
(REALIZADO-META) AS SALDO,
case when meta = 0 or realizado = 0 then -100 else (((REALIZADO/META)-1)*100) end  AS PERCENTUAL

FROM
(SELECT

CODVEND,
VENDEDOR,
GRUPO,
REALIZADO,
/*VALOR DO KG*/
DECODE(GRUPO,
'BREED'	,	META*	30.8	,
'FELINE HEALTH NUTRITION'	,	META*	32.12	,
'FELINE HEALTH NUTRITION BREED'	,	META*	32.22	,
'FELINE HEALTH NUTRITION UMIDA'	,	META*	65.22	,
'FELINE HEALTH NUTRITION-PRO'	,	META*	16.06	,
'GIANT'	,	META*	14.52	,
'MAXI'	,	META*	14.62	,
'MEDIUM'	,	META*	15.53	,
'MINI'	,	META*	29.56	,
'MINI WET'	,	META*	49.81	,
'PERFORMANCE'	,	META*	10.37	,
'PREMIUM CAT'	,	META*	14.91	,
'SIZE-PRO'	,	META*	12.14	,
'VET DIET CANINE SECA'	,	META*	35.54	,
'VET DIET CANINE UMIDA'	,	META*	72.32	,
'VET DIET FELINE SECA'	,	META*	41.48	,
'VET DIET FELINE UMIDA'	,	META*	84.92	,
'X-SMALL'	,	META*	34.32	) AS META

FROM

(
SELECT

CODVEND,
APELIDO AS VENDEDOR,
GRUPO,
NVL(SUM(ITEM),0) AS REALIZADO,

/*ADERITO*/
CASE
WHEN CODVEND = 	1	 AND GRUPO =	'BREED'	THEN	504.35
WHEN CODVEND = 	1	 AND GRUPO =	'FELINE HEALTH NUTRITION'	THEN	400
WHEN CODVEND = 	1	 AND GRUPO =	'FELINE HEALTH NUTRITION BREED'	THEN	104.94
WHEN CODVEND = 	1	 AND GRUPO =	'FELINE HEALTH NUTRITION UMIDA'	THEN	29.359
WHEN CODVEND = 	1	 AND GRUPO =	'FELINE HEALTH NUTRITION-PRO'	THEN	15
WHEN CODVEND = 	1	 AND GRUPO =	'GIANT'	THEN	30
WHEN CODVEND = 	1	 AND GRUPO =	'MAXI'	THEN	264
WHEN CODVEND = 	1	 AND GRUPO =	'MEDIUM'	THEN	535.59
WHEN CODVEND = 	1	 AND GRUPO =	'MINI'	THEN	1060
WHEN CODVEND = 	1	 AND GRUPO =	'MINI WET'	THEN	12
WHEN CODVEND = 	1	 AND GRUPO =	'PERFORMANCE'	THEN	1380.5
WHEN CODVEND = 	1	 AND GRUPO =	'PREMIUM CAT'	THEN	545.16
WHEN CODVEND = 	1	 AND GRUPO =	'SIZE-PRO'	THEN	44
WHEN CODVEND = 	1	 AND GRUPO =	'VET DIET CANINE SECA'	THEN	805.86
WHEN CODVEND = 	1	 AND GRUPO =	'VET DIET CANINE UMIDA'	THEN	90
WHEN CODVEND = 	1	 AND GRUPO =	'VET DIET FELINE SECA'	THEN	200
WHEN CODVEND = 	1	 AND GRUPO =	'VET DIET FELINE UMIDA'	THEN	9.405
WHEN CODVEND = 	1	 AND GRUPO =	'X-SMALL'	THEN	29.15
					
WHEN CODVEND = 	9	 AND GRUPO =	'BREED'	THEN	61.05
WHEN CODVEND = 	9	 AND GRUPO =	'FELINE HEALTH NUTRITION'	THEN	40
WHEN CODVEND = 	9	 AND GRUPO =	'FELINE HEALTH NUTRITION BREED'	THEN	3.3
WHEN CODVEND = 	9	 AND GRUPO =	'FELINE HEALTH NUTRITION UMIDA'	THEN	70.125
WHEN CODVEND = 	9	 AND GRUPO =	'FELINE HEALTH NUTRITION-PRO'	THEN	15
WHEN CODVEND = 	9	 AND GRUPO =	'GIANT'	THEN	15
WHEN CODVEND = 	9	 AND GRUPO =	'MAXI'	THEN	165
WHEN CODVEND = 	9	 AND GRUPO =	'MEDIUM'	THEN	15
WHEN CODVEND = 	9	 AND GRUPO =	'MINI'	THEN	115
WHEN CODVEND = 	9	 AND GRUPO =	'MINI WET'	THEN	6
WHEN CODVEND = 	9	 AND GRUPO =	'PERFORMANCE'	THEN	478.5
WHEN CODVEND = 	9	 AND GRUPO =	'PREMIUM CAT'	THEN	100
WHEN CODVEND = 	9	 AND GRUPO =	'SIZE-PRO'	THEN	20
WHEN CODVEND = 	9	 AND GRUPO =	'VET DIET CANINE SECA'	THEN	151.91
WHEN CODVEND = 	9	 AND GRUPO =	'VET DIET CANINE UMIDA'	THEN	32
WHEN CODVEND = 	9	 AND GRUPO =	'VET DIET FELINE SECA'	THEN	55
WHEN CODVEND = 	9	 AND GRUPO =	'VET DIET FELINE UMIDA'	THEN	4.488
WHEN CODVEND = 	9	 AND GRUPO =	'X-SMALL'	THEN	13.2
					
WHEN CODVEND = 	15	 AND GRUPO =	'BREED'	THEN	121
WHEN CODVEND = 	15	 AND GRUPO =	'FELINE HEALTH NUTRITION'	THEN	10
WHEN CODVEND = 	15	 AND GRUPO =	'FELINE HEALTH NUTRITION BREED'	THEN	5.39
WHEN CODVEND = 	15	 AND GRUPO =	'FELINE HEALTH NUTRITION UMIDA'	THEN	0.8415
WHEN CODVEND = 	15	 AND GRUPO =	'FELINE HEALTH NUTRITION-PRO'	THEN	15
WHEN CODVEND = 	15	 AND GRUPO =	'GIANT'	THEN	15
WHEN CODVEND = 	15	 AND GRUPO =	'MAXI'	THEN	49.5
WHEN CODVEND = 	15	 AND GRUPO =	'MEDIUM'	THEN	66
WHEN CODVEND = 	15	 AND GRUPO =	'MINI'	THEN	200
WHEN CODVEND = 	15	 AND GRUPO =	'MINI WET'	THEN	6
WHEN CODVEND = 	15	 AND GRUPO =	'PERFORMANCE'	THEN	363
WHEN CODVEND = 	15	 AND GRUPO =	'PREMIUM CAT'	THEN	313.28
WHEN CODVEND = 	15	 AND GRUPO =	'SIZE-PRO'	THEN	341.11
WHEN CODVEND = 	15	 AND GRUPO =	'VET DIET CANINE SECA'	THEN	73.7
WHEN CODVEND = 	15	 AND GRUPO =	'VET DIET CANINE UMIDA'	THEN	6
WHEN CODVEND = 	15	 AND GRUPO =	'VET DIET FELINE SECA'	THEN	70
WHEN CODVEND = 	15	 AND GRUPO =	'VET DIET FELINE UMIDA'	THEN	6
WHEN CODVEND = 	15	 AND GRUPO =	'X-SMALL'	THEN	4.4
					
 WHEN CODVEND = 	3	 AND GRUPO =	'BREED'	THEN	1584.55
WHEN CODVEND = 	3	 AND GRUPO =	'FELINE HEALTH NUTRITION'	THEN	430
WHEN CODVEND = 	3	 AND GRUPO =	'FELINE HEALTH NUTRITION BREED'	THEN	86.68
WHEN CODVEND = 	3	 AND GRUPO =	'FELINE HEALTH NUTRITION UMIDA'	THEN	71.808
WHEN CODVEND = 	3	 AND GRUPO =	'FELINE HEALTH NUTRITION-PRO'	THEN	15
WHEN CODVEND = 	3	 AND GRUPO =	'GIANT'	THEN	30
WHEN CODVEND = 	3	 AND GRUPO =	'MAXI'	THEN	918.61
WHEN CODVEND = 	3	 AND GRUPO =	'MEDIUM'	THEN	1196.58
WHEN CODVEND = 	3	 AND GRUPO =	'MINI'	THEN	2700
WHEN CODVEND = 	3	 AND GRUPO =	'MINI WET'	THEN	21.021
WHEN CODVEND = 	3	 AND GRUPO =	'PERFORMANCE'	THEN	1669.25
WHEN CODVEND = 	3	 AND GRUPO =	'PREMIUM CAT'	THEN	521.62
WHEN CODVEND = 	3	 AND GRUPO =	'SIZE-PRO'	THEN	176
WHEN CODVEND = 	3	 AND GRUPO =	'VET DIET CANINE SECA'	THEN	1483.02
WHEN CODVEND = 	3	 AND GRUPO =	'VET DIET CANINE UMIDA'	THEN	185
WHEN CODVEND = 	3	 AND GRUPO =	'VET DIET FELINE SECA'	THEN	325
WHEN CODVEND = 	3	 AND GRUPO =	'VET DIET FELINE UMIDA'	THEN	30.404
WHEN CODVEND = 	3	 AND GRUPO =	'X-SMALL'	THEN	129.25
					
 WHEN CODVEND = 	31	 AND GRUPO =	'BREED'	THEN	628.65
WHEN CODVEND = 	31	 AND GRUPO =	'FELINE HEALTH NUTRITION'	THEN	100
WHEN CODVEND = 	31	 AND GRUPO =	'FELINE HEALTH NUTRITION BREED'	THEN	14.52
WHEN CODVEND = 	31	 AND GRUPO =	'FELINE HEALTH NUTRITION UMIDA'	THEN	3.366
WHEN CODVEND = 	31	 AND GRUPO =	'FELINE HEALTH NUTRITION-PRO'	THEN	33
WHEN CODVEND = 	31	 AND GRUPO =	'GIANT'	THEN	30
WHEN CODVEND = 	31	 AND GRUPO =	'MAXI'	THEN	462
WHEN CODVEND = 	31	 AND GRUPO =	'MEDIUM'	THEN	371.47
WHEN CODVEND = 	31	 AND GRUPO =	'MINI'	THEN	460
WHEN CODVEND = 	31	 AND GRUPO =	'MINI WET'	THEN	12
WHEN CODVEND = 	31	 AND GRUPO =	'PERFORMANCE'	THEN	541.75
WHEN CODVEND = 	31	 AND GRUPO =	'PREMIUM CAT'	THEN	88.55
WHEN CODVEND = 	31	 AND GRUPO =	'SIZE-PRO'	THEN	66
WHEN CODVEND = 	31	 AND GRUPO =	'VET DIET CANINE SECA'	THEN	521.18
WHEN CODVEND = 	31	 AND GRUPO =	'VET DIET CANINE UMIDA'	THEN	39
 WHEN CODVEND = 	31	 AND GRUPO =	'VET DIET FELINE SECA'	THEN	80
WHEN CODVEND = 	31	 AND GRUPO =	'VET DIET FELINE UMIDA'	THEN	5.907
WHEN CODVEND = 	31	 AND GRUPO =	'X-SMALL'	THEN	36.85
					
 WHEN CODVEND = 	53	 AND GRUPO =	'BREED'	THEN	30
WHEN CODVEND = 	53	 AND GRUPO =	'FELINE HEALTH NUTRITION'	THEN	10
WHEN CODVEND = 	53	 AND GRUPO =	'FELINE HEALTH NUTRITION BREED'	THEN	6
WHEN CODVEND = 	53	 AND GRUPO =	'FELINE HEALTH NUTRITION UMIDA'	THEN	3
WHEN CODVEND = 	53	 AND GRUPO =	'FELINE HEALTH NUTRITION-PRO'	THEN	15
WHEN CODVEND = 	53	 AND GRUPO =	'GIANT'	THEN	15
WHEN CODVEND = 	53	 AND GRUPO =	'MAXI'	THEN	75
WHEN CODVEND = 	53	 AND GRUPO =	'MEDIUM'	THEN	60
WHEN CODVEND = 	53	 AND GRUPO =	'MINI'	THEN	50
WHEN CODVEND = 	53	 AND GRUPO =	'MINI WET'	THEN	6
WHEN CODVEND = 	53	 AND GRUPO =	'PERFORMANCE'	THEN	460
WHEN CODVEND = 	53	 AND GRUPO =	'PREMIUM CAT'	THEN	160
WHEN CODVEND = 	53	 AND GRUPO =	'SIZE-PRO'	THEN	22
WHEN CODVEND = 	53	 AND GRUPO =	'VET DIET CANINE SECA'	THEN	50
WHEN CODVEND = 	53	 AND GRUPO =	'VET DIET CANINE UMIDA'	THEN	135.135
 WHEN CODVEND = 	53	 AND GRUPO =	'VET DIET FELINE SECA'	THEN	10
WHEN CODVEND = 	53	 AND GRUPO =	'VET DIET FELINE UMIDA'	THEN	6
WHEN CODVEND = 	53	 AND GRUPO =	'X-SMALL'	THEN	10
					
 WHEN CODVEND = 	4	 AND GRUPO =	'BREED'	THEN	730.95
WHEN CODVEND = 	4	 AND GRUPO =	'FELINE HEALTH NUTRITION'	THEN	160
WHEN CODVEND = 	4	 AND GRUPO =	'FELINE HEALTH NUTRITION BREED'	THEN	79.86
WHEN CODVEND = 	4	 AND GRUPO =	'FELINE HEALTH NUTRITION UMIDA'	THEN	227.205
WHEN CODVEND = 	4	 AND GRUPO =	'FELINE HEALTH NUTRITION-PRO'	THEN	66
WHEN CODVEND = 	4	 AND GRUPO =	'GIANT'	THEN	30
WHEN CODVEND = 	4	 AND GRUPO =	'MAXI'	THEN	660.33
WHEN CODVEND = 	4	 AND GRUPO =	'MEDIUM'	THEN	387.86
WHEN CODVEND = 	4	 AND GRUPO =	'MINI'	THEN	800
WHEN CODVEND = 	4	 AND GRUPO =	'MINI WET'	THEN	22.308
WHEN CODVEND = 	4	 AND GRUPO =	'PERFORMANCE'	THEN	800
WHEN CODVEND = 	4	 AND GRUPO =	'PREMIUM CAT'	THEN	511.28
WHEN CODVEND = 	4	 AND GRUPO =	'SIZE-PRO'	THEN	20
WHEN CODVEND = 	4	 AND GRUPO =	'VET DIET CANINE SECA'	THEN	1180.96
WHEN CODVEND = 	4	 AND GRUPO =	'VET DIET CANINE UMIDA'	THEN	140
 WHEN CODVEND = 	4	 AND GRUPO =	'VET DIET FELINE SECA'	THEN	235
WHEN CODVEND = 	4	 AND GRUPO =	'VET DIET FELINE UMIDA'	THEN	20.636
WHEN CODVEND = 	4	 AND GRUPO =	'X-SMALL'	THEN	117.7
					
 WHEN CODVEND = 	39	 AND GRUPO =	'BREED'	THEN	200.2
WHEN CODVEND = 	39	 AND GRUPO =	'FELINE HEALTH NUTRITION'	THEN	30
WHEN CODVEND = 	39	 AND GRUPO =	'FELINE HEALTH NUTRITION BREED'	THEN	49.61
WHEN CODVEND = 	39	 AND GRUPO =	'FELINE HEALTH NUTRITION UMIDA'	THEN	6
WHEN CODVEND = 	39	 AND GRUPO =	'FELINE HEALTH NUTRITION-PRO'	THEN	15
WHEN CODVEND = 	39	 AND GRUPO =	'GIANT'	THEN	15
WHEN CODVEND = 	39	 AND GRUPO =	'MAXI'	THEN	115.5
WHEN CODVEND = 	39	 AND GRUPO =	'MEDIUM'	THEN	121
WHEN CODVEND = 	39	 AND GRUPO =	'MINI'	THEN	370
WHEN CODVEND = 	39	 AND GRUPO =	'MINI WET'	THEN	12
WHEN CODVEND = 	39	 AND GRUPO =	'PERFORMANCE'	THEN	1369.5
WHEN CODVEND = 	39	 AND GRUPO =	'PREMIUM CAT'	THEN	461.67
WHEN CODVEND = 	39	 AND GRUPO =	'SIZE-PRO'	THEN	176
WHEN CODVEND = 	39	 AND GRUPO =	'VET DIET CANINE SECA'	THEN	473.22
WHEN CODVEND = 	39	 AND GRUPO =	'VET DIET CANINE UMIDA'	THEN	80
WHEN CODVEND = 	39	 AND GRUPO =	'VET DIET FELINE SECA'	THEN	200
WHEN CODVEND = 	39	 AND GRUPO =	'VET DIET FELINE UMIDA'	THEN	17.369
WHEN CODVEND = 	39	 AND GRUPO =	'X-SMALL'	THEN	32.45
					
 WHEN CODVEND = 	5	 AND GRUPO =	'BREED'	THEN	464.4
WHEN CODVEND = 	5	 AND GRUPO =	'FELINE HEALTH NUTRITION'	THEN	150
WHEN CODVEND = 	5	 AND GRUPO =	'FELINE HEALTH NUTRITION BREED'	THEN	128.76
WHEN CODVEND = 	5	 AND GRUPO =	'FELINE HEALTH NUTRITION UMIDA'	THEN	6
WHEN CODVEND = 	5	 AND GRUPO =	'FELINE HEALTH NUTRITION-PRO'	THEN	15
WHEN CODVEND = 	5	 AND GRUPO =	'GIANT'	THEN	30
WHEN CODVEND = 	5	 AND GRUPO =	'MAXI'	THEN	150.6
WHEN CODVEND = 	5	 AND GRUPO =	'MEDIUM'	THEN	366.36
WHEN CODVEND = 	5	 AND GRUPO =	'MINI'	THEN	485
WHEN CODVEND = 	5	 AND GRUPO =	'MINI WET'	THEN	12
WHEN CODVEND =   5	 AND GRUPO =	'PERFORMANCE'	THEN	900
WHEN CODVEND = 	5	 AND GRUPO =	'PREMIUM CAT'	THEN	300
WHEN CODVEND = 	5	 AND GRUPO =	'SIZE-PRO'	THEN	48
WHEN CODVEND = 	5	 AND GRUPO =	'VET DIET CANINE SECA'	THEN	450.12
WHEN CODVEND = 	5	 AND GRUPO =	'VET DIET CANINE UMIDA'	THEN	80
 WHEN CODVEND = 	5	 AND GRUPO =	'VET DIET FELINE SECA'	THEN	165
WHEN CODVEND = 	5	 AND GRUPO =	'VET DIET FELINE UMIDA'	THEN	22.902
WHEN CODVEND = 	5	 AND GRUPO =	'X-SMALL'	THEN	55.2
					
WHEN CODVEND = 	19	 AND GRUPO =	'BREED'	THEN	504.35
WHEN CODVEND = 	19	 AND GRUPO =	'FELINE HEALTH NUTRITION'	THEN	20
WHEN CODVEND = 	19	 AND GRUPO =	'FELINE HEALTH NUTRITION BREED'	THEN	24.75
WHEN CODVEND = 	19	 AND GRUPO =	'FELINE HEALTH NUTRITION UMIDA'	THEN	6
WHEN CODVEND = 	19	 AND GRUPO =	'FELINE HEALTH NUTRITION-PRO'	THEN	15
WHEN CODVEND = 	19	 AND GRUPO =	'GIANT'	THEN	15
WHEN CODVEND = 	19	 AND GRUPO =	'MAXI'	THEN	198
WHEN CODVEND = 	19	 AND GRUPO =	'MEDIUM'	THEN	170.72
WHEN CODVEND = 	19	 AND GRUPO =	'MINI'	THEN	530
WHEN CODVEND = 	19	 AND GRUPO =	'MINI WET'	THEN	6
WHEN CODVEND = 	19	 AND GRUPO =	'PERFORMANCE'	THEN	3976.5
WHEN CODVEND = 	19	 AND GRUPO =	'PREMIUM CAT'	THEN	146.08
WHEN CODVEND = 	19	 AND GRUPO =	'SIZE-PRO'	THEN	20
WHEN CODVEND = 	19	 AND GRUPO =	'VET DIET CANINE SECA'	THEN	118.91
WHEN CODVEND = 	19	 AND GRUPO =	'VET DIET CANINE UMIDA'	THEN	8
WHEN CODVEND = 	19	 AND GRUPO =	'VET DIET FELINE SECA'	THEN	50
WHEN CODVEND = 	19	 AND GRUPO =	'VET DIET FELINE UMIDA'	THEN	6
WHEN CODVEND = 	19	 AND GRUPO =	'X-SMALL'	THEN	79.2
					
 WHEN CODVEND = 	8	 AND GRUPO =	'BREED'	THEN	359.15
WHEN CODVEND = 	8	 AND GRUPO =	'FELINE HEALTH NUTRITION'	THEN	170
WHEN CODVEND = 	8	 AND GRUPO =	'FELINE HEALTH NUTRITION BREED'	THEN	4.95
WHEN CODVEND = 	8	 AND GRUPO =	'FELINE HEALTH NUTRITION UMIDA'	THEN	9.713
WHEN CODVEND = 	8	 AND GRUPO =	'FELINE HEALTH NUTRITION-PRO'	THEN	15
WHEN CODVEND = 	8	 AND GRUPO =	'GIANT'	THEN	30
WHEN CODVEND = 	8	 AND GRUPO =	'MAXI'	THEN	638.11
WHEN CODVEND = 	8	 AND GRUPO =	'MEDIUM'	THEN	495.11
WHEN CODVEND = 	8	 AND GRUPO =	'MINI'	THEN	520
WHEN CODVEND = 	8	 AND GRUPO =	'MINI WET'	THEN	12
WHEN CODVEND = 	8	 AND GRUPO =	'PERFORMANCE'	THEN	1886.5
WHEN CODVEND = 	8	 AND GRUPO =	'PREMIUM CAT'	THEN	761.42
WHEN CODVEND = 	8	 AND GRUPO =	'SIZE-PRO'	THEN	154
WHEN CODVEND = 	8	 AND GRUPO =	'VET DIET CANINE SECA'	THEN	883.08
WHEN CODVEND = 	8	 AND GRUPO =	'VET DIET CANINE UMIDA'	THEN	130
 WHEN CODVEND = 	8	 AND GRUPO =	'VET DIET FELINE SECA'	THEN	330
WHEN CODVEND = 	8	 AND GRUPO =	'VET DIET FELINE UMIDA'	THEN	6.358
WHEN CODVEND = 	8	 AND GRUPO =	'X-SMALL'	THEN	63.8
					
 WHEN CODVEND = 	16	 AND GRUPO =	'BREED'	THEN	191.4
WHEN CODVEND = 	16	 AND GRUPO =	'FELINE HEALTH NUTRITION'	THEN	20
WHEN CODVEND = 	16	 AND GRUPO =	'FELINE HEALTH NUTRITION BREED'	THEN	8.69
WHEN CODVEND = 	16	 AND GRUPO =	'FELINE HEALTH NUTRITION UMIDA'	THEN	6
WHEN CODVEND = 	16	 AND GRUPO =	'FELINE HEALTH NUTRITION-PRO'	THEN	15
WHEN CODVEND = 	16	 AND GRUPO =	'GIANT'	THEN	15
WHEN CODVEND = 	16	 AND GRUPO =	'MAXI'	THEN	181.5
WHEN CODVEND = 	16	 AND GRUPO =	'MEDIUM'	THEN	33
WHEN CODVEND = 	16	 AND GRUPO =	'MINI'	THEN	105
WHEN CODVEND = 	16	 AND GRUPO =	'MINI WET'	THEN	6
WHEN CODVEND = 	16	 AND GRUPO =	'PERFORMANCE'	THEN	1985.5
WHEN CODVEND = 	16	 AND GRUPO =	'PREMIUM CAT'	THEN	126.5
WHEN CODVEND = 	16	 AND GRUPO =	'SIZE-PRO'	THEN	22
WHEN CODVEND = 	16	 AND GRUPO =	'VET DIET CANINE SECA'	THEN	157.96
WHEN CODVEND = 	16	 AND GRUPO =	'VET DIET CANINE UMIDA'	THEN	27
 WHEN CODVEND = 	16	 AND GRUPO =	'VET DIET FELINE SECA'	THEN	50
WHEN CODVEND = 	16	 AND GRUPO =	'VET DIET FELINE UMIDA'	THEN	6
WHEN CODVEND = 	16	 AND GRUPO =	'X-SMALL'	THEN	6
					
WHEN CODVEND = 	30	 AND GRUPO =	'BREED'	THEN	79.2
WHEN CODVEND = 	30	 AND GRUPO =	'FELINE HEALTH NUTRITION'	THEN	10
WHEN CODVEND = 	30	 AND GRUPO =	'FELINE HEALTH NUTRITION BREED'	THEN	6
WHEN CODVEND = 	30	 AND GRUPO =	'FELINE HEALTH NUTRITION UMIDA'	THEN	6
WHEN CODVEND = 	30	 AND GRUPO =	'FELINE HEALTH NUTRITION-PRO'	THEN	15
WHEN CODVEND = 	30	 AND GRUPO =	'GIANT'	THEN	15
WHEN CODVEND = 	30	 AND GRUPO =	'MAXI'	THEN	165
WHEN CODVEND = 	30	 AND GRUPO =	'MEDIUM'	THEN	15
WHEN CODVEND = 	30	 AND GRUPO =	'MINI'	THEN	210
WHEN CODVEND = 	30	 AND GRUPO =	'MINI WET'	THEN	6
WHEN CODVEND = 	30	 AND GRUPO =	'PERFORMANCE'	THEN	2326.5
WHEN CODVEND = 	30	 AND GRUPO =	'PREMIUM CAT'	THEN	203.06
WHEN CODVEND = 	30	 AND GRUPO =	'SIZE-PRO'	THEN	154
WHEN CODVEND = 	30	 AND GRUPO =	'VET DIET CANINE SECA'	THEN	34.32
WHEN CODVEND = 	30	 AND GRUPO =	'VET DIET CANINE UMIDA'	THEN	8
WHEN CODVEND = 	30	 AND GRUPO =	'VET DIET FELINE SECA'	THEN	55
WHEN CODVEND = 	30	 AND GRUPO =	'VET DIET FELINE UMIDA'	THEN	6
WHEN CODVEND = 	30	 AND GRUPO =	'X-SMALL'	THEN	6
					
 WHEN CODVEND = 	49	 AND GRUPO =	'BREED'	THEN	17.05
WHEN CODVEND = 	49	 AND GRUPO =	'FELINE HEALTH NUTRITION'	THEN	16.5
WHEN CODVEND = 	49	 AND GRUPO =	'FELINE HEALTH NUTRITION BREED'	THEN	10
WHEN CODVEND = 	49	 AND GRUPO =	'FELINE HEALTH NUTRITION UMIDA'	THEN	6
WHEN CODVEND = 	49	 AND GRUPO =	'FELINE HEALTH NUTRITION-PRO'	THEN	15
WHEN CODVEND = 	49	 AND GRUPO =	'GIANT'	THEN	15
WHEN CODVEND = 	49	 AND GRUPO =	'MAXI'	THEN	49.5
WHEN CODVEND = 	49	 AND GRUPO =	'MEDIUM'	THEN	45
WHEN CODVEND = 	49	 AND GRUPO =	'MINI'	THEN	55
WHEN CODVEND = 	49	 AND GRUPO =	'MINI WET'	THEN	6
WHEN CODVEND = 	49	 AND GRUPO =	'PERFORMANCE'	THEN	450
WHEN CODVEND = 	49	 AND GRUPO =	'PREMIUM CAT'	THEN	100
WHEN CODVEND = 	49	 AND GRUPO =	'SIZE-PRO'	THEN	22
WHEN CODVEND = 	49	 AND GRUPO =	'VET DIET CANINE SECA'	THEN	30
WHEN CODVEND = 	49	 AND GRUPO =	'VET DIET CANINE UMIDA'	THEN	8
 WHEN CODVEND = 	49	 AND GRUPO =	'VET DIET FELINE SECA'	THEN	20
WHEN CODVEND = 	49	 AND GRUPO =	'VET DIET FELINE UMIDA'	THEN	6
WHEN CODVEND = 	49	 AND GRUPO =	'X-SMALL'	THEN	10
					
WHEN CODVEND = 	12	 AND GRUPO =	'BREED'	THEN	385
WHEN CODVEND = 	12	 AND GRUPO =	'FELINE HEALTH NUTRITION'	THEN	18
WHEN CODVEND = 	12	 AND GRUPO =	'FELINE HEALTH NUTRITION BREED'	THEN	33.44
WHEN CODVEND = 	12	 AND GRUPO =	'FELINE HEALTH NUTRITION UMIDA'	THEN	2.431
WHEN CODVEND = 	12	 AND GRUPO =	'FELINE HEALTH NUTRITION-PRO'	THEN	15
WHEN CODVEND = 	12	 AND GRUPO =	'GIANT'	THEN	50
WHEN CODVEND = 	12	 AND GRUPO =	'MAXI'	THEN	82.5
WHEN CODVEND = 	12	 AND GRUPO =	'MEDIUM'	THEN	181.5
WHEN CODVEND = 	12	 AND GRUPO =	'MINI'	THEN	240
WHEN CODVEND = 	12	 AND GRUPO =	'MINI WET'	THEN	12
WHEN CODVEND = 	12	 AND GRUPO =	'PERFORMANCE'	THEN	1702.25
WHEN CODVEND = 	12	 AND GRUPO =	'PREMIUM CAT'	THEN	228.36
WHEN CODVEND = 	12	 AND GRUPO =	'SIZE-PRO'	THEN	22
WHEN CODVEND = 	12	 AND GRUPO =	'VET DIET CANINE SECA'	THEN	289.74
WHEN CODVEND = 	12	 AND GRUPO =	'VET DIET CANINE UMIDA'	THEN	45
WHEN CODVEND = 	12	 AND GRUPO =	'VET DIET FELINE SECA'	THEN	100
WHEN CODVEND = 	12	 AND GRUPO =	'VET DIET FELINE UMIDA'	THEN	2.112
WHEN CODVEND = 	12	 AND GRUPO =	'X-SMALL'	THEN	20.9
					
 WHEN CODVEND = 	10	 AND GRUPO =	'BREED'	THEN	0
WHEN CODVEND = 	10	 AND GRUPO =	'FELINE HEALTH NUTRITION'	THEN	0
WHEN CODVEND = 	10	 AND GRUPO =	'FELINE HEALTH NUTRITION BREED'	THEN	0
WHEN CODVEND = 	10	 AND GRUPO =	'FELINE HEALTH NUTRITION UMIDA'	THEN	0
WHEN CODVEND = 	10	 AND GRUPO =	'FELINE HEALTH NUTRITION-PRO'	THEN	150
WHEN CODVEND = 	10	 AND GRUPO =	'GIANT'	THEN	15
WHEN CODVEND = 	10	 AND GRUPO =	'MAXI'	THEN	49.5
WHEN CODVEND = 	10	 AND GRUPO =	'MEDIUM'	THEN	15
WHEN CODVEND = 	10	 AND GRUPO =	'MINI'	THEN	50
WHEN CODVEND = 	10	 AND GRUPO =	'MINI WET'	THEN	0
WHEN CODVEND = 	10	 AND GRUPO =	'PERFORMANCE'	THEN	0
WHEN CODVEND = 	10	 AND GRUPO =	'PREMIUM CAT'	THEN	0
WHEN CODVEND = 	10	 AND GRUPO =	'SIZE-PRO'	THEN	1600
WHEN CODVEND = 	10	 AND GRUPO =	'VET DIET CANINE SECA'	THEN	13.31
WHEN CODVEND = 	10	 AND GRUPO =	'VET DIET CANINE UMIDA'	THEN	0
 WHEN CODVEND = 	10	 AND GRUPO =	'VET DIET FELINE SECA'	THEN	0
WHEN CODVEND = 	10	 AND GRUPO =	'VET DIET FELINE UMIDA'	THEN	0
WHEN CODVEND = 	11	 AND GRUPO =	'X-SMALL'	THEN	0
					
WHEN CODVEND = 	17	 AND GRUPO =	'BREED'	THEN	122.1
WHEN CODVEND = 	17	 AND GRUPO =	'FELINE HEALTH NUTRITION'	THEN	190
WHEN CODVEND = 	17	 AND GRUPO =	'FELINE HEALTH NUTRITION BREED'	THEN	16.5
WHEN CODVEND = 	17	 AND GRUPO =	'FELINE HEALTH NUTRITION UMIDA'	THEN	101.915
WHEN CODVEND = 	17	 AND GRUPO =	'FELINE HEALTH NUTRITION-PRO'	THEN	495
WHEN CODVEND = 	17	 AND GRUPO =	'GIANT'	THEN	15
WHEN CODVEND = 	17	 AND GRUPO =	'MAXI'	THEN	198.33
WHEN CODVEND = 	17	 AND GRUPO =	'MEDIUM'	THEN	159.94
WHEN CODVEND = 	17	 AND GRUPO =	'MINI'	THEN	280
WHEN CODVEND = 	17	 AND GRUPO =	'MINI WET'	THEN	12
WHEN CODVEND = 	17	 AND GRUPO =	'PERFORMANCE'	THEN	1009.25
WHEN CODVEND = 	17	 AND GRUPO =	'PREMIUM CAT'	THEN	736.56
WHEN CODVEND = 	17	 AND GRUPO =	'SIZE-PRO'	THEN	2600
WHEN CODVEND = 	17	 AND GRUPO =	'VET DIET CANINE SECA'	THEN	316.03
WHEN CODVEND = 	17	 AND GRUPO =	'VET DIET CANINE UMIDA'	THEN	25
WHEN CODVEND = 	17	 AND GRUPO =	'VET DIET FELINE SECA'	THEN	135
WHEN CODVEND = 	17	 AND GRUPO =	'VET DIET FELINE UMIDA'	THEN	1.122
WHEN CODVEND = 	17	 AND GRUPO =	'X-SMALL'	THEN	16.5
					
 WHEN CODVEND = 	20	 AND GRUPO =	'BREED'	THEN	13.75
WHEN CODVEND = 	20	 AND GRUPO =	'FELINE HEALTH NUTRITION'	THEN	12
WHEN CODVEND = 	20	 AND GRUPO =	'FELINE HEALTH NUTRITION BREED'	THEN	8.25
WHEN CODVEND = 	20	 AND GRUPO =	'FELINE HEALTH NUTRITION UMIDA'	THEN	8.976
WHEN CODVEND = 	20	 AND GRUPO =	'FELINE HEALTH NUTRITION-PRO'	THEN	214.5
WHEN CODVEND = 	20	 AND GRUPO =	'GIANT'	THEN	30
WHEN CODVEND = 	20	 AND GRUPO =	'MAXI'	THEN	99
WHEN CODVEND = 	20	 AND GRUPO =	'MEDIUM'	THEN	30
WHEN CODVEND = 	20	 AND GRUPO =	'MINI'	THEN	45
WHEN CODVEND = 	20	 AND GRUPO =	'MINI WET'	THEN	6
WHEN CODVEND = 	20	 AND GRUPO =	'PERFORMANCE'	THEN	30
WHEN CODVEND = 	20	 AND GRUPO =	'PREMIUM CAT'	THEN	166.65
WHEN CODVEND = 	20	 AND GRUPO =	'SIZE-PRO'	THEN	6200
WHEN CODVEND = 	20	 AND GRUPO =	'VET DIET CANINE SECA'	THEN	155.54
WHEN CODVEND = 	20	 AND GRUPO =	'VET DIET CANINE UMIDA'	THEN	8
WHEN CODVEND = 	20	 AND GRUPO =	'VET DIET FELINE SECA'	THEN	50
WHEN CODVEND = 	20	 AND GRUPO =	'VET DIET FELINE UMIDA'	THEN	6
WHEN CODVEND = 	20	 AND GRUPO =	'X-SMALL'	THEN	6

 WHEN CODVEND = 	7	 AND GRUPO =	'BREED'	THEN	100
WHEN CODVEND = 	7	 AND GRUPO =	'FELINE HEALTH NUTRITION'	THEN	9
WHEN CODVEND = 	7	 AND GRUPO =	'FELINE HEALTH NUTRITION BREED'	THEN	9
WHEN CODVEND = 	7	 AND GRUPO =	'FELINE HEALTH NUTRITION UMIDA'	THEN	6
WHEN CODVEND = 	7	 AND GRUPO =	'FELINE HEALTH NUTRITION-PRO'	THEN	100
WHEN CODVEND = 	7	 AND GRUPO =	'GIANT'	THEN	15
WHEN CODVEND = 	7	 AND GRUPO =	'MAXI'	THEN	90
WHEN CODVEND = 	7	 AND GRUPO =	'MEDIUM'	THEN	75
WHEN CODVEND = 	7	 AND GRUPO =	'MINI'	THEN	30.5
WHEN CODVEND = 	7	 AND GRUPO =	'MINI WET'	THEN	6
WHEN CODVEND = 	7	 AND GRUPO =	'PERFORMANCE'	THEN	630
WHEN CODVEND = 	7	 AND GRUPO =	'PREMIUM CAT'	THEN	100
WHEN CODVEND = 	7	 AND GRUPO =	'SIZE-PRO'	THEN	100
WHEN CODVEND = 	7	 AND GRUPO =	'VET DIET CANINE SECA'	THEN	30
WHEN CODVEND = 	7	 AND GRUPO =	'VET DIET CANINE UMIDA'	THEN	5
WHEN CODVEND = 	7	 AND GRUPO =	'VET DIET FELINE SECA'	THEN	21
WHEN CODVEND = 	7	 AND GRUPO =	'VET DIET FELINE UMIDA'	THEN	3
WHEN CODVEND = 	7	 AND GRUPO =	'X-SMALL'	THEN	6
					
 WHEN CODVEND = 	11	 AND GRUPO =	'BREED'	THEN	964.5
WHEN CODVEND = 	11	 AND GRUPO =	'FELINE HEALTH NUTRITION'	THEN	190.1
WHEN CODVEND = 	11	 AND GRUPO =	'FELINE HEALTH NUTRITION BREED'	THEN	45.1
WHEN CODVEND = 	11	 AND GRUPO =	'FELINE HEALTH NUTRITION UMIDA'	THEN	40.05
WHEN CODVEND = 	11	 AND GRUPO =	'FELINE HEALTH NUTRITION-PRO'	THEN	100
WHEN CODVEND = 	11	 AND GRUPO =	'GIANT'	THEN	75.00
WHEN CODVEND = 	11	 AND GRUPO =	'MAXI'	THEN	455.2
WHEN CODVEND = 	11	 AND GRUPO =	'MEDIUM'	THEN	765.5
WHEN CODVEND = 	11	 AND GRUPO =	'MINI'	THEN	987.00
WHEN CODVEND = 	11	 AND GRUPO =	'MINI WET'	THEN	30.42
WHEN CODVEND = 	11	 AND GRUPO =	'PERFORMANCE'	THEN	547.5
WHEN CODVEND = 	11	 AND GRUPO =	'PREMIUM CAT'	THEN	241.2
WHEN CODVEND = 	11	 AND GRUPO =	'SIZE-PRO'	THEN	100
WHEN CODVEND = 	11	 AND GRUPO =	'VET DIET CANINE SECA'	THEN	1708.2
WHEN CODVEND = 	11	 AND GRUPO =	'VET DIET CANINE UMIDA'	THEN	83.28
WHEN CODVEND = 	11	 AND GRUPO =	'VET DIET FELINE SECA'	THEN	275.00
WHEN CODVEND = 	11	 AND GRUPO =	'VET DIET FELINE UMIDA'	THEN	5.46
WHEN CODVEND = 	11	 AND GRUPO =	'X-SMALL'	THEN	86.00



END AS META

FROM

(
(
SELECT

CAB.CODVEND AS CODVEND1,
VEN.APELIDO AS VENDEDOR,


CASE WHEN PR.CODGRUPOPROD IN(1010101,1010102,1010103,1010104) THEN (SELECT DESCRGRUPOPROD FROM TGFGRU WHERE CODGRUPOPROD = 1010100)
     WHEN PR.CODGRUPOPROD IN(1010301,1010302,1010303,1010304) THEN (SELECT DESCRGRUPOPROD FROM TGFGRU WHERE CODGRUPOPROD = 1010300)
     WHEN PR.CODGRUPOPROD IN(1010401,1010402,1010403,1010404) THEN (SELECT DESCRGRUPOPROD FROM TGFGRU WHERE CODGRUPOPROD = 1010400)
     WHEN PR.CODGRUPOPROD IN(1010501,1010502,1010503,1010504) THEN (SELECT DESCRGRUPOPROD FROM TGFGRU WHERE CODGRUPOPROD = 1010500)
     WHEN PR.CODGRUPOPROD IN(1010601,1010602,1010603,1010604) THEN (SELECT DESCRGRUPOPROD FROM TGFGRU WHERE CODGRUPOPROD = 1010600)
     WHEN PR.CODGRUPOPROD IN(1010701,1010702,1010703,1010704) AND CAB.CODVEND IN(17,20,10,14) THEN (SELECT DESCRGRUPOPROD FROM TGFGRU WHERE CODGRUPOPROD = 1010700)
     WHEN PR.CODGRUPOPROD IN(1010801,1010802,1010803,1010804) THEN (SELECT DESCRGRUPOPROD FROM TGFGRU WHERE CODGRUPOPROD = 1010800)
     WHEN PR.CODGRUPOPROD IN(1010901.1010902,1010903,1010904) THEN (SELECT DESCRGRUPOPROD FROM TGFGRU WHERE CODGRUPOPROD = 1010900)
     WHEN PR.CODGRUPOPROD IN(1011001,1011002,1011003,1011004) THEN (SELECT DESCRGRUPOPROD FROM TGFGRU WHERE CODGRUPOPROD = 1011000)
     WHEN PR.CODGRUPOPROD IN(1011101,1011102,1011103,1011104) THEN (SELECT DESCRGRUPOPROD FROM TGFGRU WHERE CODGRUPOPROD = 1011100)
     WHEN PR.CODGRUPOPROD IN(1011201,1011202,1011203        ) THEN (SELECT DESCRGRUPOPROD FROM TGFGRU WHERE CODGRUPOPROD = 1011200)
     WHEN PR.CODGRUPOPROD IN(1020101,1020102,1020103,1020104) THEN (SELECT DESCRGRUPOPROD FROM TGFGRU WHERE CODGRUPOPROD = 1020100)
     WHEN PR.CODGRUPOPROD IN(1020201,1020202,1020203,1020204) THEN (SELECT DESCRGRUPOPROD FROM TGFGRU WHERE CODGRUPOPROD = 1020200)
     WHEN PR.CODGRUPOPROD IN(1020301,1020302,1020303,1020304) THEN (SELECT DESCRGRUPOPROD FROM TGFGRU WHERE CODGRUPOPROD = 1020300)
     WHEN PR.CODGRUPOPROD IN(1020401,1020402,1020403,1020404,1020405)AND CAB.CODVEND IN(17,20,10,14)  THEN (SELECT DESCRGRUPOPROD FROM TGFGRU WHERE CODGRUPOPROD = 1020400)
     WHEN PR.CODGRUPOPROD IN(1020501,1020502,1020503,1020504) THEN (SELECT DESCRGRUPOPROD FROM TGFGRU WHERE CODGRUPOPROD = 1020500)
     WHEN PR.CODGRUPOPROD IN(1020601,1020602,1020603,1020604) THEN (SELECT DESCRGRUPOPROD FROM TGFGRU WHERE CODGRUPOPROD = 1020600)
     WHEN PR.CODGRUPOPROD IN(1020701,1020702,1020703,1020704) THEN (SELECT DESCRGRUPOPROD FROM TGFGRU WHERE CODGRUPOPROD = 1020700)
     WHEN PR.CODGRUPOPROD IN(1020801,1020802,1020803,1020804) THEN (SELECT DESCRGRUPOPROD FROM TGFGRU WHERE CODGRUPOPROD = 1020800)

     END AS GRUPO1,

NVL(SUM((((ITE.QTDNEG * ITE.VLRUNIT) + ITE.VLRIPI + ITE.VLRSUBST - ITE.VLRDESC - ITE.VLRREPRED) )),0) AS ITEM

FROM

TGFCAB CAB,
TGFITE ITE,
TGFPRO PR,
TGFVEN VEN

WHERE

CAB.NUNOTA = ITE.NUNOTA
AND CAB.CODVEND = VEN.CODVEND
AND ITE.CODPROD = PR.CODPROD
AND PR.CODGRUPOPROD in( select codgrupoprod from tgfgru where codgrupai in( 1010100, 1010200,1010300,1010400,1010500,1010600,1010700,1010800,1010900,1011000,1011100,1011200,1020100, 1020200,1020300,1020400,1020500,1020600,1020700,1020800) )
AND CAB.TIPMOV IN ('V')
AND CAB.STATUSNOTA = 'L'
AND (PR.CODGRUPOPROD >= 01 
AND PR.CODGRUPOPROD <= 5900000)
AND CAB.CODTIPOPER IN( 700, 703, 706, 707, 709, 715, 723,724, 725)
AND CAB.CODEMP = 1
AND CAB.CODVEND = (SELECT USU.CODVEND FROM TSIUSU USU WHERE USU.CODUSU = STP_GET_CODUSULOGADO())

AND TRUNC(CAB.DTFATUR) BETWEEN TO_DATE('17/05/2019','DD/MM/YYYY') AND TO_DATE('13/06/2019','DD/MM/YYYY') 
GROUP BY  CAB.CODVEND, VEN.APELIDO, PR.CODGRUPOPROD) b

full OUTER join

(
SELECT 

*

FROM

(select 
ven.codvend, 
ven.apelido,
CASE WHEN CODGRUPOPROD IN (1010700 ,1020400) THEN 
     CASE WHEN VEN.CODVEND IN(17,20,10,14)  THEN 1 ELSE 2 END
     ELSE CODGRUPOPROD
     END COD, 
gpr.grupo
from
(

select CODGRUPOPROD, DESCRgrupoprod as grupo
from tgfgru
where codgrupoprod
in( 1010100, 1010200,1010300,1010400,1010500,1010600,1010700,1010800,1010900,1011000,1011100,1011200,1020100, 1020200,1020300,1020400,1020500,1020600,1020700,1020800)
)gpr, tgfven ven where ven.CODEMP = 1 and VEN.CODVEND = (SELECT USU.CODVEND FROM TSIUSU USU WHERE USU.CODUSU = STP_GET_CODUSULOGADO())
) WHERE COD <> 2
)A ON A.GRUPO = B.GRUPO1 AND A.APELIDO = B.VENDEDOR

) GROUP BY  APELIDO,GRUPO,CODVEND

ORDER BY APELIDO,grupo
)WHERE META IS NOT NULL)