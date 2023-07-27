GIT_URL=git@git.ridotto.by:bbsoft/bbsoft-client.git
BRANCH=default-branch-main
REGISTRY_URL=registry.prod.default
REGISTRY_PROJECT=default-project-name
SERVICE_NAME=default-service-name


build:
	if [ -d $(SERVICE_NAME) ]; then rm -rf $(SERVICE_NAME); fi
	git clone $(GIT_URL) -b $(BRANCH)
	if echo $(BRANCH) | grep -q '[а-яА-Я]'; then \
          echo "BRANCH - $(BRANCH) contaion russian words" ; \
		  echo "Merge branch into new BRANCH without russian words" ; \
		  exit  1; \
        else \
          echo "BRANCH doesn't contain russian words"; \
	  docker build -t $(REGISTRY_URL)/$(REGISTRY_PROJECT)/$(SERVICE_NAME):$(BRANCH)-$(CI_COMMIT_SHORT_SHA) $(SERVICE_NAME); \
	  docker push ${REGISTRY_URL}/${REGISTRY_PROJECT}/$(SERVICE_NAME):${BRANCH}-${CI_COMMIT_SHORT_SHA} ; \
        fi
	
	rm -rf $(SERVICE_NAME)
