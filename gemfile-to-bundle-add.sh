#!/usr/bin/env bash
# shellcheck disable=SC2086

GEMFILE=${1:-./Gemfile}

while IFS= read -r line; do
	if [[ $line =~ ^gem ]]; then
		GEM=$(echo "$line" | sed -e 's/gem[[:space:]]*//g' \
			-e 's/[[:space:]]*,[[:space:]]*git:[[:space:]]*/ --git /g' \
			-e 's/[[:space:]]*,[[:space:]]*branch:[[:space:]]*/ --branch /g')
		GEM=$(eval echo $GEM) # drop quotes
		echo "> bundle add $GEM"
		bundle add ${GEM}
	fi
done < "$GEMFILE"
