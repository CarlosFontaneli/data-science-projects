/* cd

problema(preparador_fisico) :- preparo_fisico(ruim).

problema(equipe_tecnica) :- atritos(constantes), situacao_psicologica(ruim).

problema(time) :- preparador_fisico(bom), situacao_gols(ruim).

problema(insatisfacao_financeira) :- atritos(constantes), salarios(atrasado).

atritos(constantes) :- jogador(X), tecnico(Y), discute(X, Y).

atritos(constantes) :- jogador(X), jogador(Y), discute(X, Y).

situacao_psicologica(ruim) :- jogador(X), suspenso(X).

situacao_psicologica(ruim) :- jogador(X), cortado(X).

situacao_gols(ruim) :- gols_sofridos(X), gols_feitos(Y), maior(X, Y).

suspenso(X) :- cartao_vermelho(X).

preparo_fisico(ruim) :- jogador(X), lento(X).

preparo_fisico(ruim) :- jogador(X), lesao(X).

maior(X, Y) :- X > Y.

/* 

% Situacao 1 - problema == preparo_fisico
jogador(reinaldo).
jogador(pablo).
lento(pablo).
tecnico(rogerio).

% Situacao 2 - problema == equipe_tecnica
jogador(leo).
cortado(leo).
tecnico(dorival).
discute(leo, dorival).

% Situacao 3 - problema == time
preparador_fisico(bom).
gols_feitos(9).
gols_sofridos(10).

% Situacao 4 - problema == insatisfacao_financeira
jogador(diego).
jogador(miranda).
discute(diego, miranda).
salarios(atrasado). 

*/

/* preparo_fisico(bom).
jogador(jorge).
cartao_vermelho(jorge).
tecnico(X).
discute(jorge, X).
gols_sofridos(1).
gols_feitos(2).
salarios(atrasado). */ */