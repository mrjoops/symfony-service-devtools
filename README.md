# mrjoops/symfony-service-devtools

A set of useful tools for building [Symfony](https://symfony.com) services.
To date, it includes:

* Code quality tools with gently defaults
  * PHPMD
  * PHP Code Sniffer
  * PHP CS Fixer
  * PHPStan
* Test tools
  * PHPUnit
* A ready to go Docker environment
* Configuration for CI tool Bitbucket Pipelines
* a Makefile to ease interaction with these tools

## Installation

You can install it with [Composer](https://getcomposer.org).

```
composer config extra.symfony.allow-contrib true
composer require --dev mrjoops/symfony-service-devtools
```

## Prerequisites

Although both are optional, please ensure you have installed **docker-compose** alongside [Docker](https://hub.docker.com/search?q=&type=edition&offering=community) on your system.

If you use Symfony Flex, you can safely jump to the [Usage](#usage) section.
Otherwise you must copy the following files in your project to enjoy all the features:

* .env.test
* .php_cs.dist
* bitbucket-pipelines.yml
* docker-compose.yml
* Dockerfile
* Makefile
* phpcs.xml.dist
* phpmd.xml
* phpstan.neon.dist
* phpunit.xml.dist

```
cp vendor/mrjoops/symfony-service-devtools/{.env.test,.php_cs.dist,bitbucket-pipelines.yml,docker-compose.yml,Dockerfile,Makefile,phpcs.xml.dist,phpmd.xml,phpstan.neon.dist,phpunit.xml.dist} .
```

Don't forget to add the following lines in your `.gitignore` file:

```
/.php_cs
/.php_cs.cache
/phpcs.xml
/.phpcs-cache
/phpstan.neon
/phpunit.xml
.phpunit.result.cache
/test-reports/
/vendor/
```

Feel free to edit these files to fit your needs.

## <a name="usage"></a>Usage

### Quality tools

You can run all the code quality tools with this command:

```
make check
```

You can run them individually:

```
make md
make sniff
make stan
make style
```

You can also run the fixers with this command:

```
make fix
```

And again, you can run them individualy:

```
make fix-sniff
make fix-style
```

### Testing tools

You can run PHPUnit with this command:

```
make unit
```

### Docker

You can add services to the `docker-compose.yml` file.
Then you can start your services with the following command:

```
docker-compose up -d
```

The base Docker image used here is [mrjoops/ppm](https://cloud.docker.com/u/mrjoops/repository/docker/mrjoops/ppm) which uses [PHP-PM](https://github.com/php-pm/php-pm), so you have an efficient PHP web server up and running! 

## Continuous integration

A configuration for [Bitbucket Pipelines](https://bitbucket.org/product/features/pipelines) exists, it will run all checks and tests on pull requests.

## Opinionated advices

1. Do yourself a favor and create this alias:
   `alias dk='docker-compose exec app'`
   so you'll just have to prefix your commands with `dk` to have them executed in the container.
2. It's a good idea to add `make check` (or `dk make check`) to your git workflow by creating a pre-commit hook.
