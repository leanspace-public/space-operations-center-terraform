# space-operations-center-terraform

This repository contains the configuration used for the SOC (Space Operations Center)

Please modify this project with:

- in the root `main.tf` in the provider, input your tenant and a client id and client secret; the last two can be found in a Service Account of the service Teams&Roles
- in the folder `satellites/plugins` put your 2 downloaded jars, if you don't have these jars please contact your Leanspace Customer Success Manager
  - `generic-ccsds-protocol-transformer-plugin.jar`
  - `satellite-command-transformer-plugin.jar`
