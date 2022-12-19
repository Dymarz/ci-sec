# ***Playground for Dynamic Application Security Testing (DAST) in CI/CD-Pipelines***
[![pipeline status](https://gitlab.com/dymi/ci-sec/badges/master/pipeline.svg)](https://gitlab.com/dymi/ci-sec/-/commits/master)
[![bachelor status](https://img.shields.io/badge/bachelor-pending-lightgrey)](https://gitlab.com/dymi/transferleistungen/-/tree/master)

This project simulate the dynamic security testing process in a common CI-Pipeline.
It use the three different **DAST** technics: *Web Application* and *Behaviour Driven Security Testing* such as *Security API Scanning* **(WAST, BDST, SAS)**.
* [Base Repo](https://gitlab.com/rvbuijtenen/continuous-security/-/tree/master) where most ideas comes from
* Docker Image from [OWASP Juice Shop](https://github.com/juice-shop/juice-shop) used as an insecure web application
* [OWASP Zed Attack Proxy (ZAP)](https://github.com/zaproxy/zaproxy) as security scanning tool
* [My Related work](https://gitlab.com/dymi/transferleistungen/-/tree/master)

## Process explained:
The *.gitlab-ci.yml* defines the CI Jobs. It use a docker container to start the engine and build docker containers in it. In the three different testing methods folders are *docker-compose.yaml* which define the services. The **Juice Shop** Application will be used in every job. The other services in the job will scan the application and push the results to the artifacts.

## Specials:
The folder [*.linux*](.linux) contains a awesome [gitlab-runner script](.linux/run-local-gitlab-runner.sh) for local gitlab ci tests! :heart_eyes_cat:
This works only under Linux. Script needs to from the .linux folder.

Advantages:
* Much faster build results to test some ci jobs
* No need to commit and push every random try
* Save gitlab runner build time (they are limited)

TODOs in this section to run this under windows:
* gitlab-runner do not support mounting files in windows! :crying_cat_face:
* Maybe an addition abstraction layer can handle this
  * Copy whole Repo in a fresh Linux Container with Docker and hope that gitlab-runner doesn't have problems with a windows docker desktop daemon

- [x] This project has a private gitlab runner (**disabled**)
- [ ] Script this gitlab runner and edit this description 
___
## WAST:

### Pitfalls:

* docker-compose up **--abort-on-container-exit**
  * when zap-scan finished, the juice-shop is still running
* build seperate dockerimage for zapscan and integrate a *[wait-for-it.sh](https://github.com/vishnubob/wait-for-it)* script
  * this checks the availability of the webapp
  * it try 30sec to connect the service
  * run script when service responed
  * otherwise abort
* error-code from scan make the pipeline fail but the scan was successful.
  * need seperate **evaluate job** or method to handle the error-code, otherwise it will be hard to understand when a scan aborted or a scanreport is accessible 
  * [x] ExitCodes can be mocked 
* ARTIFACTS: **.gitlab-ci.yml start the whole repository in a docker** is important to understand because the scanresults from the docker in docker container need to be mount on a volumn in this repository. After the docker-compose.yaml is finish and the services pushed their results in the repository_volumn, the job is done and these results can be pushed from the gitlab runner to the artifacts.
* Scanresults can not be published when the mounted folder "scanresults" dont have write-permission for all users! happens under local linux
  * maybe need a privileged gitlab runner container...

### Comparison to the base repo:
* don't need to build the zap application
  * reduce massive CI build time
* just two instead of three services
* Use zapscan directly with using their Dockerimage instead of starting zap and then use script with these proxy 

## BDST

### Pitfalls
* ZAP cant see a sql injection request???
  * [ ] Should be fixed 
  * [ ] Publish the reports
* Own Selenium Docker Image is too huge (1,7 GB , ty chrome)
  * [ ] Make it smaller -> build faster

### Comparison to the base repo:
* ruby instead of python
* dont need static ip addresses :)

## Improvement Ideas and Upcoming Questions:
- [ ] Image Cache? Container Cache? Reduce build and startup times. 
* What is the right scan time??? actually 1min... Fullscan is over 90min.
* How can this be a Framework or Default Repo for others who wanna integrate fast and for free DAST in their projects? 
  * Try other WebApplications instead of JuiceShop and show differences
  * Abstract this repo in a complex WebAppRepo with much more CI/CD Jobs where the webapp need to build their image by themself. Can we integrate it fast? 
* Look at the Tools!
  * What does the reports mean?
  * What should the devs do with it? Upcoming Workflow...
  * Show some more configurations
  * Compare some alternatives tools
* Compare GitLab Ultimate integrated DAST Options
* Compare AzureDevOps integrated DAST Options
* Compare GitHub Actions DAST Options
* Compare other CICD Host Plattform DAST Options instead of gitlab. Pitfalls their? or much more easier..? But for what price.. worth it?
