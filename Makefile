.PHONY: all update

all:
	@bash -c 'source preflight/all.sh && source apps/all.sh'

update:
	@bash -c 'source preflight/upgrade.sh && source apps/all.sh'
