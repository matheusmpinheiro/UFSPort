-- 1) Quantidade de vitorias em casa ou fora dos times de cada pais, ordenado pela quantidade de vitorias. (Entre as datas Y e Z -> Opcional) 
--Vitoria Em casa
select b.count as vitorias, nome, pais, esporte 
FROM time, (
	select COUNT(1), id_time1 
	from jogo 
	WHERE vencedor=id_time1 
	AND data BETWEEN '1500-06-05' AND '2100-06-20' 
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
order by vitorias

-- 2) Times com o maior|menor numero de vitorias em cada pais, entre as datas X e Y (opcional), do esporte Z (opcional), ordenado pelo numero de vitorias
create or replace view times_vitorias as 
SELECT * 
    FROM time t2 INNER JOIN (
			select COUNT(*) as vitorias, id_time
			from jogo, time
			WHERE id_time=vencedor 
			group by id_time) b
	using (id_time)


-- Maior numero de vitorias
select vitorias, nome, t1.pais, t1.esporte
from times_vitorias t1, (
	select MAX(vitorias) as maximo, pais, esporte
	from times_vitorias
	where esporte like '%%'
	group by pais, esporte) t2
where t2.maximo = t1.vitorias and t2.pais=t1.pais
order by vitorias DESC


-- Menor numero de vitorias
select vitorias, nome, t1.pais, t1.esporte
from times_vitorias t1, (
	select MIN(vitorias) as minimo, pais, esporte
	from times_vitorias
	where esporte like '%%'
	group by pais, esporte) t2
where t2.minimo = t1.vitorias and t2.pais=t1.pais
order by vitorias, nome, pais, esporte DESC

--3) Times por pais e por esporte(opcional) que tem o maior|menor numero de vitorias por campeonato
create or replace view vitorias_campeonatos as
select * 
	from (
		select COUNT(*) as vitorias, time.nome as nomeTeam, id_campeonato, esporte 
		from jogo, time 
		WHERE vencedor=id_time
		group by id_campeonato,id_time,time.nome) b
	INNER JOIN campeonato using (id_campeonato)

select * from time

--Maior numero de vitorias
select t1.nome, nomeTeam, vitorias, esporte
from vitorias_campeonatos t1, (
	select MAX(vitorias) as maximo, id_campeonato
	from vitorias_campeonatos
	group by id_campeonato) t2
where t2.maximo = t1.vitorias
AND esporte like '%%'
AND t1.id_campeonato = t2.id_campeonato
order by vitorias DESC, nometeam, nome 

--Menor numero de vitorias
select t1.nome, nomeTeam, vitorias, esporte
from vitorias_campeonatos t1, (
	select MIN(vitorias) as maximo, id_campeonato
	from vitorias_campeonatos
	group by id_campeonato) t2
where t2.maximo = t1.vitorias
AND esporte like '%%'
AND t1.id_campeonato = t2.id_campeonato
order by vitorias, nometeam, nome DESC limit 10


select count(*) from (
select b.count as vitorias, nome, pais, esporte FROM time, (      select COUNT(1), id_time1      from jogo      WHERE vencedor=id_time1      AND data BETWEEN '1500-01-01' AND '2014-06-05'      group by id_time1 ) b WHERE id_time=id_time1 order by vitorias DESC) as c

select count(*) from ( select vitorias, nome, t1.pais, t1.esporte from times_vitorias t1, ( select max(vitorias) as maximo, pais, esporte from times_vitorias where esporte like '%%' group by pais, esporte) t2 where t2.maximo = t1.vitorias and t2.pais=t1.pais order by vitorias ) as f

	SELECT nome, esporte, estadio, pais 
	FROM time 
	WHERE nome LIKE '%%'
	AND esporte LIKE '%%'
	AND pais LIKE '%%'
	ORDER BY nome, id_time

	SELECT nome, sobrenome, apelido, datanasc_dia, datanasc_mes, datanasc_ano, aposentado, aposenta_data, altura, peso 
FROM jogador 
WHERE nome LIKE '%%' 
AND sobrenome LIKE '%%' 
AND apelido LIKE '%%' 
AND datanasc_dia = <DIA> 
AND datanasc_mes = <MES> 
AND datanasc_ano = <ANO> 
AND aposentado= <TRUE|FALSE> 
AND aposenta_data= <DATA> 
AND altura= <ALTURA> 
AND peso=<PESO>
ORDER BY nome



