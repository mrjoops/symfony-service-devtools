.PHONY: check
check: md sniff stan style

.PHONY: fix-sniff
fix-sniff: config public src vendor
	./vendor/bin/phpcbf

.PHONY: fix-style
fix-style: config public src vendor
	./vendor/bin/php-cs-fixer fix --verbose

.PHONY: md
md: config public src vendor
	./vendor/bin/phpmd config,public,src text phpmd.xml

.PHONY: sniff
sniff: config public src test-reports vendor
ifeq ($(CI), true)
	./vendor/bin/phpcs --report=junit > test-reports/code-sniffer.xml
else
	./vendor/bin/phpcs
endif

.PHONY: stan
stan: config public src test-reports vendor
ifeq ($(CI), true)
	./vendor/bin/phpstan analyse --error-format=junit > test-reports/static-analysis.xml
else
	./vendor/bin/phpstan analyse
endif

.PHONY: style
style: config public src test-reports vendor
ifeq ($(CI), true)
	./vendor/bin/php-cs-fixer fix --dry-run --format=junit --verbose > test-reports/code-style.xml
else
	./vendor/bin/php-cs-fixer fix --dry-run --verbose
endif

config:
	mkdir -p $@

public:
	mkdir -p $@

src:
	mkdir -p $@

test-reports:
	mkdir -p $@

vendor:
	composer install
