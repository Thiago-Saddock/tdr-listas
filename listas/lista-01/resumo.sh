#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 2 ]; then
    echo "Erro: Faltam argumentos." >&2
    echo "Rodando: $0 <arquivo.csv> <numero_da_coluna>" >&2
    exit 1
fi


Nome_Coluna=$(head -n 1 "$1" | cut -d"," -f"$2")
echo "Nome da coluna: $Nome_Coluna"

obs=$(tail -n +2 "$1" | wc -l)
echo "Observações: $((obs))"

n_NA=$(tail -n +2 "$1" | cut -d"," -f"$2" | grep -c "^NA$" || true)
echo "NAs: $n_NA"

echo "Média por mês:"
tail -n +2 "$1" | awk -F',' -v  col="$2" '
{
	mes = $5
	valor = $col

	if (valor != "NA" && valor != ""){
		soma[mes] += valor
		dias[mes]++
	}
}
END {
	for (m in soma) {
		printf" - Mês %s: Média = %.2f | Dias medidos = %d\n", m, soma[m]/dias[m], dias[m]
	}
}' | sort -n

