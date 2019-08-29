.PHONY: check
check: md sniff stan style

.PHONY: fix
fix: fix-sniff fix-style

.PHONY: fix-sniff
fix-sniff: config public src vendor
	./vendor/bin/phpcbf

.PHONY: fix-style
fix-style: config public src vendor
	./vendor/bin/php-cs-fixer fix --verbose

.PHONY: md
md: config public src tests vendor
	./vendor/bin/phpmd config,public,src text phpmd.xml

.PHONY: sniff
sniff: config public src tests test-reports vendor
ifeq ($(CI), true)
	./vendor/bin/phpcs --report=junit > test-reports/code-sniffer.xml
else
	./vendor/bin/phpcs
endif

.PHONY: stan
stan: config public src tests test-reports vendor
ifeq ($(CI), true)
	./vendor/bin/phpstan analyse --error-format=junit > test-reports/static-analysis.xml
else
	./vendor/bin/phpstan analyse
endif

.PHONY: style
style: config public src tests test-reports vendor
ifeq ($(CI), true)
	./vendor/bin/php-cs-fixer fix --dry-run --format=junit --verbose > test-reports/code-style.xml
else
	./vendor/bin/php-cs-fixer fix --dry-run --verbose
endif

.PHONY: unit
unit: config public src tests test-reports vendor
ifeq ($(CI), true)
	./vendor/bin/phpunit --log-junit test-reports/unit.xml
else
	./vendor/bin/phpunit
endif

config:
	mkdir -p $@

public:
	mkdir -p $@

src:
	mkdir -p $@

tests:
	mkdir -p $@

test-reports:
	mkdir -p $@

vendor:
	composer install
