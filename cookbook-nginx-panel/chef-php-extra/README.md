# Description

Installs and configures additional PHP modules and PEAR packages that are commonly used but not part of the Opscode Cookbooks. This includes additional tools that are used during development for quality assurance and testing.

**This cookbook now adds support for CentOS 6.* and correct package names. Use this chef-php-extra::default instead of php::default to ensure compatibility with CentOS 6.*.**

[![Build Status](https://secure.travis-ci.org/inviqa/chef-php-extra.png?branch=master)](http://travis-ci.org/inviqa/chef-php-extra)

# Requirements

Chef 0.10.12 or higher required (for Chef environment use).

## Platform

* Debian, Ubuntu
* CentOS, Red Hat, Fedora

## Cookbooks

The following Opscode cookbooks are dependencies:

* git
* yum
* apt
* php

# Attributes

* `['xdebug']['cli_color']` = Enable cli colour output, defaults to `1`.
* `['xdebug']['scream']` = Enable removal for of `@` error suppression functionality, defaults to `0`.
* `['xdebug']['remote_enable']` = Defaults to `On`.
* `['xdebug']['remote_autostart']` = Defaults to `0`.
* `['xdebug']['remote_mode']` = Defaults to `req`.
* `['xdebug']['remote_connect_back']` = Defaults to `1`.
* `['xdebug']['idekey']` = Defaults to `macgdbp`.
* `['xdebug']['file_link_format']` = Defaults to `txmt://open?url=file://%f&line=%1`.
* `['xdebug']['profiler_enable_trigger']` = Defaults to `0`.
* `['xdebug']['profiler_enable']` = Defaults to `0`.
* `['xdebug']['profiler_output_dir']` = Defaults to `/tmp/cachegrind`.

# Providers

## composer

Provides `install_composer` and `install_packages` actions which install composer in the directory provided, and installs the project's dependencies.

```ruby
chef_php_extra_composer "/path/to/project/dir" do
  action [:install_composer, :install_packages]
end
```

# Recipes

## default

Install the additional PHP modules not part of the Opscode cookbook.

## development

Installs and configures a standard set of tools used in development of PHP projects. This will install the standard set of static code analysis tools for PHP as well as testing and quality assurance tools.

## module_dev

Installs the php5_dev module that is required by xdebug.

## module_gd

Installs the php5_gd module adding support for CentOS 6.* and correct package selection.


## module_imagick

Installs the php5_imagick module used for image processing.

## module_mcrypt

Install the php5_mcrypt module that is commonly used but not part of the Opscode PHP cookbook

## module_soap

Installs php5_soap as it is a commonly used module that is not part of the Opscode PHP cookbook.

## module_xml

Installs php5_xml as it is a commonly used module that is not part of the Opscode PHP cookbook.

## pear

Upgrades PEAR using PEAR.

## PHP_CodeBrowser

Installs PHP_CodeBrowser with PEAR so that is can be used to generate a GUI to interact with the source code and static code analysis results.

## PHP_CodeSniffer

Installs PHP_CodeSniffer using PEAR with the standard sniffs PEAR and Zend.

## PHP_Depend

Installs PHP_Depend with PEAR so that it can be used in Jenkins.

## PHP_PMD

Installs PHP_PMD with PEAR so that it can be used in Jenkins.

## phpcpd

Installs phpcpd which allows you to identify and duplicate code within your PHP project.

## PhpDocumentor

Installs PhpDocumentor so that you can generate API documentation for you code.

## phploc

Installs phploc so that you can gather statistics about your PHP code.

## PHPUnit

Installs PHPUnit and dependencies for unit testing your PHP code.

## predis

Installs the php redis extension configure and make install from source after a checkout from GitHub from the master branch

## vfsStream

Installs vfsStream which allows you to create mock file system resources for unit testing.

## xdebug

Installs and configures xdebug so that it provides more details stack traces for any error output. xdebug is configured to connect back to a debugger at the host machine initiating the request.

## zendframework

Installs the latest build of Zend Framework 1.x as system wide resource with PEAR.

# Usage

You can select any of the recipes to be executed directly referencing them from this cookbook.

    chef-php-extra::xdebug
    
If you are setting up a development environment you can use the single recipe that will add all the standard tools that may be used during development of projects

    chef-php-extra::development

# License and Author

Author:: Alistair Stead (alistair@inviqa.com) Author:: Marcello Duarte (marcello@inviqa.com)

Copyright 2012, Inviqa

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

