-- Scripts - Trabalho Integrado
-- André Beltrami
-- Gabriel Ferreira
-- Jhony Campanha


-- Consulta Específica 1 - Vitórias em casa/fora *******
-- Vitórias em casa
SELECT b.count as vitorias, nome, pais, esporte 
FROM time, (
	SELECT COUNT(1), id_time1 
	FROM jogo 
	WHERE vencedor=id_time1 
	AND data BETWEEN <data inicial> AND <data final>
	GROUP BY id_time1 ) b
WHERE id_time=id_time1 
ORDER BY vitorias DESC

-- Vitórias fora de casa
SELECT b.count as vitorias, nome, pais, esporte 
FROM time, (
	SELECT COUNT(1), id_time2 
	FROM jogo 
	WHERE vencedor=id_time2 
	AND data BETWEEN <data inicial> AND <data final>
	GROUP BY id_time1 ) b
WHERE id_time=id_time1 
ORDER BY vitorias DESC
-- ******************************************************

-- Consulta Específica 2 - Times Mais | Menos vitoriosos *
-- Maior numero de vitorias
SELECT vitorias, nome, t1.pais, t1.esporte
FROM times_vitorias t1, (
	SELECT MAX(vitorias) as maximo, pais, esporte
	FROM times_vitorias
	WHERE esporte like '%<esporte>%'
	GROUP BY pais, esporte) t2
WHERE t2.maximo = t1.vitorias AND t2.pais=t1.pais
ORDER BY vitorias DESC

-- Menor numero de vitorias
SELECT vitorias, nome, t1.pais, t1.esporte
FROM times_vitorias t1, (
	SELECT MIN(vitorias) as maximo, pais, esporte
	FROM times_vitorias
	WHERE esporte like '%<esporte>%'
	GROUP BY pais, esporte) t2
WHERE t2.maximo = t1.vitorias AND t2.pais=t1.pais
ORDER BY vitorias

-- View utilizada para essa consulta
create or replace view times_vitorias as 
SELECT * 
    FROM time t2 INNER JOIN (
			select COUNT(*) as vitorias, id_time
			from jogo, time
			WHERE id_time=vencedor 
			group by id_time) b
	using (id_time)

-- ********************************************************

-- Consulta Especifica 3 - Quantidade de vitórias por campeonato

--Maior numero de vitorias
SELECT t1.nome, nomeTeam, vitorias, esporte
FROM vitorias_campeonatos t1, (
	SELECT MAX(vitorias) AS maximo, id_campeonato
	FROM vitorias_campeonatos
	GROUP BY id_campeonato) t2
WHERE t2.maximo = t1.vitorias
AND esporte like '%<esporte>%'
AND t1.id_campeonato = t2.id_campeonato
ORDER BY vitorias DESC

--Menor numero de vitorias
SELECT t1.nome, nomeTeam, vitorias, esporte
FROM vitorias_campeonatos t1, (
	SELECT MIN(vitorias) AS minimo, id_campeonato
	FROM vitorias_campeonatos
	GROUP BY id_campeonato) t2
WHERE t2.minimo = t1.vitorias
AND esporte like '%<esporte>%'
AND t1.id_campeonato = t2.id_campeonato
ORDER BY vitorias

-- View utilizada para essa consulta

create or replace view vitorias_campeonatos as
select * 
	from (
		select COUNT(*) as vitorias, time.nome as nomeTeam, id_campeonato, esporte 
		from jogo, time 
		WHERE vencedor=id_time
		group by id_campeonato,id_time,time.nome) b
	INNER JOIN campeonato using (id_campeonato)

-- *************************************************************

-- Consulta Geral 1 - Times

SELECT nome, esporte, estadio, pais 
FROM time 
WHERE nome LIKE '%<NOME>%'
AND esporte LIKE '%<ESPORTE>%'
AND pais LIKE '%<PAIS>%'
ORDER BY nome

-- Consulta Geral 2 - Jogadores

SELECT nome, sobrenome, apelido, datanasc_dia, datanasc_mes, datanasc_ano, aposentado, aposenta_data, altura, peso 
FROM jogador 
WHERE nome LIKE '%<NOME>%' 
AND sobrenome LIKE '%<SOBRENOME>%' 
AND datanasc_dia = <DIA> 
AND datanasc_mes = <MES> 
AND datanasc_ano = <ANO> 
AND aposentado= <TRUE|FALSE> 
AND aposenta_data= <DATA> 
AND altura = <ALTURA>
AND peso = <PESO>
ORDER BY nome

-- ***************************************************

-- Stored Procedure 1 - Aproveitamento

CREATE or REPLACE FUNCTION aproveitamento (in integer, total out real, casa out real, fora out real) as $aproveitamento$
DECLARE
	totalCasa integer;
	totalFora integer;
	vitoriasCasa integer;
	vitoriasFora integer;
BEGIN
	-- Quantidade de jogos em casa
	SELECT count (id_time1) INTO totalCasa FROM jogo
		WHERE id_time1 = $1;

	-- Quantidade de jogos fora
	SELECT count (id_time2) INTO totalFora FROM jogo
		WHERE id_time2 = $1;

	IF (totalCasa + totalFora) = 0 THEN
		RAISE EXCEPTION 'Time não cadastrado em nenhuma partida';
	END IF;
	-- Vitorias em casa
	SELECT count(id_time1) INTO vitoriasCasa FROM jogo
		WHERE vencedor = $1
		AND id_time1 = $1;

	-- Vitorias fora
	SELECT count(id_time2) INTO vitoriasFora FROM jogo
		WHERE vencedor = $1
		AND id_time2 = $1;



	total := ((vitoriasCasa + vitoriasFora) * 100) / (totalCasa + totalFora);
	casa := (vitoriasCasa * 100) / totalCasa;
	fora := (vitoriasFora * 100) / totalFora;
END;
$aproveitamento$ LANGUAGE plpgsql;

--Stored Procedure 2 - Detalhe Time

CREATE or REPLACE FUNCTION dadosTime (integer) RETURNS text as $dadosTime$
DECLARE
	id ALIAS FOR $1;
	jogos integer;
	texto text;
	timerow time%ROWTYPE;
	nome text;
	esporte text;
	pais text;
	estadio text;
BEGIN
	-- Quantidade de jogos
	SELECT sum(count) INTO jogos FROM (
		select count(1) from jogo 
		where id_time1 = id
		UNION 
		select count(1) from jogo 
		where id_time2 = id) as foo;

	-- Informações do time
	SELECT * INTO timerow FROM time where id_time = id;
	IF timerow IS NULL THEN
		RETURN 'Time não cadastrado';
	END IF;
	
	-- Atribuição às variáveis
	nome := timerow.nome;
	IF nome IS NULL THEN
		nome:= '';
	END IF;

	esporte := timerow.esporte;
	IF esporte IS NULL THEN
		esporte := '';
	END IF;

	pais := timerow.pais;
	IF pais IS NULL THEN
		pais := '';
	END IF;

	IF timerow.estadio IS NOT NULL THEN
		estadio := ', estádio ' || timerow.estadio;
	ELSE
		estadio := '';
	END IF;
		
		
	texto := nome || ', ' || esporte || ', ' || pais || estadio || '. ' || jogos || ' partidas jogadas.';
	RETURN texto;

END;
$dadosTime$ LANGUAGE plpgsql;

-- **************************************************************

-- Trigger
CREATE OR REPLACE FUNCTION jogo_check() RETURNS TRIGGER AS $checajogo$
	DECLARE
		esporte1 time.esporte%TYPE;
		esporte2 time.esporte%TYPE;
	BEGIN
		-- Verifica se os dois times são o mesmo
		IF NEW.id_time1 = NEW.id_time2 THEN
			RAISE EXCEPTION 'os times devem ter nomes diferentes';
		END IF;
		-- Verifica se o vencedor participou do jogo
		IF (NEW.vencedor <> NEW.id_time1) AND (NEW.vencedor <> NEW.id_time2) THEN
			RAISE EXCEPTION 'o vencedor deve participar do jogo';
		END IF;
	
		-- Verifica se ambos os times são do mesmo esporte
		SELECT esporte INTO esporte1 FROM time where id_time = NEW.id_time1;
		SELECT esporte INTO esporte2 FROM time where id_time = NEW.id_time2;
		IF esporte1 <> esporte2 THEN
			RAISE EXCEPTION 'os times devem ser do mesmo esporte';
		END IF;

		RETURN NEW;
	END;
$checajogo$ LANGUAGE plpgsql;

CREATE TRIGGER jogo_check BEFORE INSERT OR UPDATE ON jogo
	FOR EACH ROW EXECUTE PROCEDURE jogo_check();

-- ************************************************************* 