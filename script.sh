cat /etc/hosts | while read ip name rest
do
	[[ -z "$ip" || "$ip" =~ ^# ]] && continue

	[[ -z "$name" ]] && continue

	real_ip=$(nslookup "$name" 2>/dev/null | awk '/^Address: / { print $2 }' | tail -n 1)

	if [[ -n "$real_ip" && "$real_ip" != "$ip" ]]; then
		echo "Bogus IP for $name in /etc/hosts!"
	fi
done
