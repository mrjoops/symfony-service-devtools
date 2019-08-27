# mrjoops/symfony-service

A set of useful tools for building [Symfony](https://symfony.com) services.
To date, it includes:

* Code quality tools with gently defaults
  * PHPMD
  * PHP Code Sniffer
  * PHP CS Fixer
  * PHPStan
* Configuration for CI tool Bitbucket Pipelines
* a Makefile to ease interaction with these tools

## Installation

You can install it with [Composer](https://getcomposer.org).

```
composer require mrjoops/symfony-service
```

## Prerequisites

You must copy the following files in your project to enjoy all the features:

* .php_cs.dist
* .phpcs.xml.dist
* bitbucket-pipelines.yml
* Makefile
* phpmd.xml
* phpstan.neon.dist

Feel free to edit these files to fit your needs.

## Usage

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

## Continuous integration

A configuration for [Bitbucket Pipelines](https://bitbucket.org/product/features/pipelines) exists, it will run all the checks on pull requests.

## Opinionated advices

It's a good idea to add `make check` to your git workflow by creating a pre-commit hook.
