tfe-cloud-state-fix
====================

This utility allows you to upload a fixed state to Terraform Enterprise/Cloud using 
the Terraform Cloud/Enterprise State Versions API. This utility will automatically create a payload JSON with incremented versions and upload to Terraform Enterprise/Cloud using the API token.


Requirements
============
* Fixed State file

Usage
======
```
export TOKEN=<Terraform Enterprise/Cloud User API Token>
./fix_state.sh <STATE FILE> <WORKSPACE-ID>
```