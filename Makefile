# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Make will use bash instead of sh
SHELL := /usr/bin/env bash

# All is the first target in the file so it will
# get picked up when you just run 'make' on its own
all: check_shell check_python check_golang check_docker \
<<<<<<< HEAD
	check_base_files check_headers check_terraform
=======
	check_base_files check_headers check_terraform check_trailing_whitespace
>>>>>>> istio-fixes

# The .PHONY directive tells make that this isn't a real target and so
# the presence of a file named 'check_shell' won't cause this target to stop
# working

.PHONY: lint
lint: check_shell check_python check_golang check_docker check_base_files check_headers check_terraform

.PHONY: check_shell
check_shell:
	@source test/make.sh && check_shell

.PHONY: check_python
check_python:
	@source test/make.sh && check_python

.PHONY: check_golang
check_golang:
	@source test/make.sh && golang

.PHONY: check_docker
check_docker:
	@source test/make.sh && docker

.PHONY: check_base_files
check_base_files:
	@source test/make.sh && basefiles

.PHONY: check_shebangs
check_shebangs:
	@source test/make.sh && check_bash

# To be uncommented, after fixing whitespaces with istio
<<<<<<< HEAD
# .PHONY: check_trailing_whitespace
# check_trailing_whitespace:
# 	@source test/make.sh && check_trailing_whitespace
=======
.PHONY: check_trailing_whitespace
check_trailing_whitespace:
	@source test/make.sh && check_trailing_whitespace
>>>>>>> istio-fixes

.PHONY: check_headers
check_headers:
	@echo "Checking file headers"
	@python3.7 test/verify_boilerplate.py

.PHONY: check_terraform
check_terraform:
	@scripts/setup-terraform-test.sh
	@source test/make.sh && check_terraform





################################################################################################
#             Infrastructure bootstrapping and mgmt helpers                                    #
################################################################################################

# create/delete/validate is for CICD
# 1. Creates the gke-tf and application gke clusters in separate projects
.PHONY: create
create:
	@source scripts/create.sh

# 2. Ensures that the gke-tf HTTPS endpoint is healthy and that a workload
#    in the application cluster can fetch secrets from gke-tf.
.PHONY: validate
validate:
	@source scripts/validate.sh

# 3. Removes all resources built in the create step.
.PHONY: teardown
teardown:
	@source scripts/teardown.sh
