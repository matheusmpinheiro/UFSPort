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

insert into jogo values (1,1, '2014-05-25', 20, 'estadio1', 1, 21);
insert into jogo values (1,2, '2014-05-25', 20, 'estadio1', 3, 21);
insert into jogo values (1,462, '2014-05-25', 20, 'estadio1', 1, 21);
insert into jogo values (460,461, '2014-05-25', 20, 'estadio1', 1, 21);