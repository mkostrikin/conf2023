# Variable with complex structure of values
variable "values" {}

# From what env state we need to get the state of resource like shared/test/prod etc
variable "env" {}

# What resources/component state we need to get, this value used in key for path to tfstate
variable "component" {}
