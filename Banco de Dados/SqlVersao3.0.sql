-- 1) Quantidade de vitorias em casa ou fora dos times de cada pais, ordenado pela quantidade de vitorias. (Entre as datas Y e Z -> Opcional) 
--Vitoria Em casa
select b.count as vitorias, nome, pais, esporte 
FROM time, (
	select COUNT(1), id_time1 
	from jogo 
	WHERE vencedor=id_time1 
	AND data BETWEEN '2000-06-05' AND '2100-06-20' 
	group by id_time1 ) b
WHERE id_time=id_time1
order by vitorias DESC

--Vitoria Fora de casa
select b.count as vitorias, nome, pais, esporte 
FROM time, (
	select COUNT(1), id_time2 
	from jogo 
	WHERE vencedor=id_time2 
	AND data BETWEEN '2000-06-05' AND '2100-06-20' 
	group by id_time2) b
WHERE id_time=id_time2 
order by vitorias DESC


-- 2) Times com o maior|menor numero de vitorias em cada pais, entre as datas X e Y (opcional), do esporte Z (opcional), ordenado pelo numero de vitorias
create view times_vitorias as 
SELECT * 
    FROM time t2 INNER JOIN (
			select COUNT(*) as vitorias, id_time
			from jogo, time
			WHERE time.id_time=jogo.vencedor
			AND data BETWEEN '2000-06-05' AND '2100-06-20'
			group by id_time) b
	using (id_time)

-- Maior numero de vitorias
select t1.pais, nome, t1.esporte, vitorias
from times_vitorias t1, (
	select MAX(vitorias) as maximo, pais, esporte
	from times_vitorias
	--where esporte = 'Futebol'
	group by pais, esporte) t2
where t2.maximo = t1.vitorias and t2.pais=t1.pais
order by vitorias DESC

-- Menor numero de vitorias
select t1.pais, nome, t1.esporte, vitorias
from times_vitorias t1, (
	select MIN(vitorias) as minimo, pais, esporte
	from times_vitorias
	--where esporte = 'Futebol'
	group by pais, esporte) t2
where t2.minimo = t1.vitorias and t2.pais=t1.pais
order by vitorias DESC

--3) Time com o maior|menor numero de vitorias em cada campeonato, do esporte X (opcional)
create view vitorias_campeonatos as 
select * 
	from ( 
		select COUNT(*) as vitorias, id_time, time.nome as time, time.esporte as esporte, id_campeonato 
		from jogo, time 
		WHERE vencedor=id_time 
		group by id_time, id_campeonato) b 
	INNER JOIN campeonato using (id_campeonato)

drop view vitorias_campeonatos


--Maior numero de vitorias
select t1.nome, t1.time, t1.esporte, vitorias
from vitorias_campeonatos t1, (
	select MAX(vitorias) as maximo, id_campeonato
	from vitorias_campeonatos
	--where esporte = 'futebol'
	group by id_campeonato order by id_campeonato) t2
where t2.maximo = t1.vitorias
AND t1.id_campeonato = t2.id_campeonato
order by vitorias DESC

select * from campeonato

--Menor numero de vitorias
select t1.nome, t1.time, t1.esporte, vitorias
from vitorias_campeonatos t1, (
	select MIN(vitorias) as maximo, esporte, id_campeonato
	from vitorias_campeonatos
	--where esporte = 'futebol'
	group by id_campeonato, esporte order by id_campeonato) t2
where t2.maximo = t1.vitorias
AND t1.id_campeonato = t2.id_campeonato
order by t1.id_campeonato, vitorias


select * from jogo