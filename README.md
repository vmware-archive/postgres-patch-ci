## Description

Concourse pipeline used to test any patch submitted to postgres hackers list.

1. Apply the patch on the current master
1. Runs tests


## How to update the pipeline

### Prerequirements:
- fly CLI for the current version of concourse
- lastpass CLI tools


### Steps
1. Login to lastpass
1. Login to concourse using the target `prod`
    ```bash
    fly -t prod login -c https://prod.ci.gpdb.pivotal.io
    ```
1. Run the command:
    ```bash
    bin/set-pipeline.sh
    ```
