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

select dadosTime(1)
select dadosTime(400)
select dadosTime(4000)

CREATE or REPLACE FUNCTION aproveitamento (in integer, total out real, casa out real, fora out real) as $aproveitamento$
DECLARE
	
	totalCasa integer;
	totalFora integer;
	vitoriasCasa integer;
	derrotasCasa integer;
	vitoriasFora integer;
	derrotasFora integer;
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

	-- Derrotas em casa
	SELECT count(id_time1) INTO derrotasCasa FROM jogo
		WHERE vencedor <> $1
		AND id_time1 = $1;

	-- Vitorias fora
	SELECT count(id_time2) INTO vitoriasFora FROM jogo
		WHERE vencedor = $1
		AND id_time2 = $1;

	-- Derrotas fora
	SELECT count(id_time2) INTO derrotasFora FROM jogo
		WHERE vencedor <> $1
		AND id_time2 = $1;

	total := ((vitoriasCasa + vitoriasFora) * 100) / (totalCasa + totalFora);
	casa := (vitoriasFora * 100) / totalCasa;
	fora := (derrotasCasa *100) / totalFora;
END;
$aproveitamento$ LANGUAGE plpgsql;

select * from aproveitamento(20)
select * from aproveitamento(40)
select * from aproveitamento(4000)
